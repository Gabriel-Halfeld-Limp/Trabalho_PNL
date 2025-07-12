from pyomo.environ import *
from power import *
import numpy as np
import pandas as pd

class PNL_OPF:
    def __init__(self, network: Network, com_rede=True):
        if not isinstance(com_rede, bool):
            raise TypeError("O parâmetro 'com_rede' deve ser booleano (True ou False).")
        #Rede
        self.net = network.ACtoDC #Transforma rede AC em DC
        self.com_rede = com_rede

        # Generators, Loads, Buses, Lines
        self.generators = self.net.generators
        self.loads = self.net.loads
        self.buses = self.net.buses
        self.lines = self.net.lines

        # Pyomo Model
        self.model = ConcreteModel()
        self.model.name = 'Otimização do Despacho Termoelétrico com e sem rede DC, Custos Quadráticos e Estimativas de Geração Cúbicas'

        # Constrói o modelo passo a passo
        self._create_sets()
        self._create_parameters()
        self._create_variables()
        self._create_constraints()
        self._create_objective()   

    def _create_sets(self):    
        self.model.generators = Set(initialize=[g.name for g in self.generators], doc="Conjunto de geradores") # Cria conjunto de geradores com os nomes
        self.model.loads = Set(initialize=[l.name for l in self.loads], doc="Conjunto de cargas") # Cria conjunto de cargas
        self.model.buses = Set(initialize=[b.name for b in self.buses], doc="Conjunto de barras")  # Cria conjunto de barras
        self.model.lines = Set(initialize=[ln.name for ln in self.lines], doc="Conjunto de linhas") # Cria conjunto de linhas    

    def _create_parameters(self):
        #Generators
        m = self.model
        m.generator_bus = Param(m.generators, initialize={g.name: g.bus.name for g in self.generators}) #Localização dos geradores
        m.generator_pmax = Param(m.generators, initialize={g.name: g.p_max for g in self.generators}) #Geração Máxima
        m.generator_pmin = Param(m.generators, initialize={g.name: g.p_min for g in self.generators}) #Geraçã Mínima
        m.generator_cost_a = Param(m.generators, initialize={g.name: g.cost_a for g in self.generators}) #Custo a
        m.generator_cost_b = Param(m.generators, initialize={g.name: g.cost_b for g in self.generators})#Custo b
        m.generator_cost_c = Param(m.generators, initialize={g.name: g.cost_c for g in self.generators})#Custo c

        #Loads
        m.load_bus = Param(m.loads, initialize={l.name: l.bus.name for l in self.loads})
        m.load_p= Param(m.loads, initialize={l.name: l.p for l in self.loads})

        #Lines
        m.line_from = Param(m.lines, initialize={ln.name: ln.from_bus.name for ln in self.lines}) #Barra de
        m.line_to = Param(m.lines, initialize={ln.name: ln.to_bus.name for ln in self.lines}) #Barra para
        m.line_x = Param(m.lines, initialize={ln.name: ln.x for ln in self.lines}) #Reatância da linha

        if self.com_rede == True:
            m.flow_max = Param(m.lines, initialize={ln.name: ln.flow_max_pu for ln in self.lines}) #Fluxo máximo nas linhas
        else:
            pass

        #Bus
        m.bus_type = Param(m.buses, initialize={b.name: b.bus_type for b in self.buses}) #Tipo de barra.

    def _create_variables(self):
        m = self.model

        #Generators
        def gen_bounds(m, g):
            p_min = m.generator_pmin[g]
            p_max = m.generator_pmax[g]
            return (p_min, p_max)
        m.p = Var(m.generators, bounds=gen_bounds, doc="Active Power Generation (pu)")

        #Buses
        if self.com_rede == True:
            m.theta = Var(m.buses, domain=Reals, doc=f"Bus angles ref to Slack")
            # Identifica barra slack
            slack_bus = next((b for b in m.buses if m.bus_type[b] == "Slack"), None)
            if slack_bus is None:
                raise ValueError("Nenhuma barra slack encontrada!")
            m.theta[slack_bus].fix(0)

    def _create_constraints(self):
        m = self.model

        if self.com_rede == True: #Balanço por Barra
            def balance_with_net_rule(m, bus):
                generation = sum(m.p[g] if m.generator_bus[g] == bus else 0 for g in m.generators)
                load = sum(m.load_p[l] if m.load_bus[l] == bus else 0 for l in m.loads)
                #Fluxos que vêm e vão (f=(theta1 - theta2)/X12)
                flow_out = sum(
                    (m.theta[m.line_to[ln]] - m.theta[m.line_from[ln]]) / m.line_x[ln]
                    if m.line_from[ln] == bus else 0 for ln in m.lines)
                flow_in = sum(
                    (m.theta[m.line_from[ln]] - m.theta[m.line_to[ln]]) / m.line_x[ln]
                    if m.line_to[ln] == bus else 0 for ln in m.lines)
                return generation - flow_out + flow_in == load
            m.balance_with_net = Constraint(m.buses, rule=balance_with_net_rule, doc="Balance of Generation and Load with Network Rule")

        else: #com_rede == False, Balanço total
            def balance_without_net_rule(m):
                generation = sum(m.p[g] for g in m.generators)
                load = sum(m.load_p[l] for l in m.loads)
                return generation == load
            m.balance_without_net = Constraint(rule=balance_without_net_rule, doc="Total Balance of Generation and Load")

    def _create_objective(self):
        m = self.model
        def objective_rule(m):
            total_cost = 0
            for g in m.generators:
                total_cost += (
                    m.generator_cost_a[g] * m.p[g] +
                    (m.generator_cost_b[g] / 2) * m.p[g]**2 +
                    (m.generator_cost_c[g] / 3) * m.p[g]**3
                )
            return total_cost

        m.obj = Objective(rule=objective_rule, sense=minimize)

    def _create_results(self):
        """
        Método para extrair resultados após resolver o modelo.
        Pode ser chamado após a resolução para obter os resultados.
        """
        m = self.model
        # Calcula o custo real com base nas variáveis resolvidas
        total_cost = 0
        for g in m.generators:
            total_cost += (
                m.generator_cost_a[g] * m.p[g].value +
                (m.generator_cost_b[g] / 2) * m.p[g].value**2 +
                (m.generator_cost_c[g] / 3) * m.p[g].value**3
            )

        # Cria um dicionário para os resultados
        results_dict = {
            'Objective Value': value(m.obj),
            'Total Cost': f'Total Cost: $ {total_cost}',
            'Generators Power (pu)': {g: value(m.p[g]) for g in m.generators}
        }

        if self.com_rede:
            results_dict['Bus Angles'] = {b: value(m.theta[b]) for b in m.buses}
            # Calcula o fluxo em cada linha
            results_dict['Line Flows (pu)'] = {
                ln: (value(m.theta[m.line_to[ln]]) - value(m.theta[m.line_from[ln]])) / m.line_x[ln]
                for ln in m.lines
            }

        # Exporta os resultados como DataFrame de uma linha
        self.results = pd.DataFrame([results_dict])

        return self.results


    def solve(self, solver_name='ipopt', tee=False):
        """
        Solve the optimization problem using the specified solver.
        Args:
            solver_name (str): The name of the solver to use.
            tee (bool): Whether to print solver output.
        Returns:
            SolverResults: The results of the optimization.
        """
        solver = SolverFactory(solver_name)
        results = solver.solve(self.model, tee=tee)
        return results

    

    


        
        