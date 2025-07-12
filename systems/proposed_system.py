from power.models.electricity_models import *
import numpy as np

class three_bus(Network):
    def __init__(self):
        super().__init__(id=1, name="3-Bus System")
        self._create_buses()
        self._create_loads()
        self._create_generators()
        self._create_lines()

    def _create_buses(self):
        # Create buses
        self.buses = [
            Bus(self, id=1, bus_type='Slack'),
            Bus(self, id=2, bus_type='PV'),
            Bus(self, id=3, bus_type='PV'),
        ]

    def _create_loads(self):
        # Create loads
        self.loads = [
            Load(id=1, bus=self.buses[1], name="PL2", p_input = 57, pb=100),
            Load(id=2, bus=self.buses[2], name="PL3", p_input = 480, pb=100),
        ]

    def _create_generators(self):
        # Create generators
        self.generators = [
            Generator(id=1, bus=self.buses[0], name="PG1", cost_a_input=16.97, cost_b_input=5.3975, cost_c_input=0.002176, p_max_input=250, p_min_input=0, pb=100),
            Generator(id=2, bus=self.buses[1], name="PG2", cost_a_input=10.86, cost_b_input=19.355, cost_c_input=0.019380, p_max_input=157, p_min_input=0, pb=100),
            Generator(id=3, bus=self.buses[2], name="PG3", cost_a_input=18.79, cost_b_input=9.3116, cost_c_input=0.001457, p_max_input=290, p_min_input=0, pb=100),
        ]

    def _create_lines(self):
        suscpetancias = np.array([70, 100, 40])
        condutancias = np.array([10, 10, 20])
        suscpetancias_pu = suscpetancias / 100
        condutancias_pu = condutancias / 100
        admitancias = condutancias_pu + 1j * suscpetancias_pu
        impendance = 1 / admitancias
        r_pu = np.real(impendance)
        x_pu = np.imag(impendance)

        # Create lines
        self.lines = [
            Line(id=1, from_bus=self.buses[0], to_bus=self.buses[1], x=x_pu[0], r=r_pu[0], flow_max=0.87),
            Line(id=2, from_bus=self.buses[0], to_bus=self.buses[2], x=x_pu[1], r=r_pu[1], flow_max=2),
            Line(id=3, from_bus=self.buses[1], to_bus=self.buses[2], x=x_pu[2], r=r_pu[2], flow_max=0.2),
        ]