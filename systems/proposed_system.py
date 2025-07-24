from power.models.electricity_models import *
import numpy as np

class three_bus(Network):
    def __init__(self):
        super().__init__(id=1, name="3-Bus System")
        self._create_buses()
        self._create_loads()
        self._create_generators()
        self._create_lines1()
        #self._create_lines2()

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
            Generator(id=1, bus=self.buses[0], name="PG1", cost_a_input=0, cost_b_input=15.9120, cost_c_input=0.081760, p_max_input=250, p_min_input=0, pb=100),
            Generator(id=2, bus=self.buses[1], name="PG2", cost_a_input=0, cost_b_input=19.355, cost_c_input=0.019380, p_max_input=157, p_min_input=0, pb=100),
            Generator(id=3, bus=self.buses[2], name="PG3", cost_a_input=0, cost_b_input=25.6600, cost_c_input=0.019570, p_max_input=388, p_min_input=0, pb=100),
        ]

    def _create_lines1(self):
        suscpetancias = np.array([70, 100, 40])
        #condutancias = np.array([10, 10, 20])
        #admitancias = condutancias - 1j * suscpetancias
        #impendance = 1 / admitancias
        #r= np.real(impendance)
        #x = np.imag(impendance)
        x = 1/suscpetancias
        r = np.zeros(shape=3)

        # Create lines
        self.lines = [
            Line(id=1, from_bus=self.buses[0], to_bus=self.buses[1], x=x[0], r=r[0], flow_max=87, pb=100),
            Line(id=2, from_bus=self.buses[0], to_bus=self.buses[2], x=x[1], r=r[1], flow_max=200, pb=100),
            Line(id=3, from_bus=self.buses[1], to_bus=self.buses[2], x=x[2], r=r[2], flow_max=20, pb=100),
        ]

    def _create_lines2(self):
        suscpetancias = np.array([70, 100, 40])
        condutancias = np.array([10, 10, 20])
        admitancias = condutancias - 1j * suscpetancias
        impendance = 1 / admitancias
        r= np.real(impendance)
        x = np.imag(impendance)

        # Create lines
        self.lines = [
            Line(id=1, from_bus=self.buses[0], to_bus=self.buses[1], x=x[0], r=r[0], flow_max=87, pb=100),
            Line(id=2, from_bus=self.buses[0], to_bus=self.buses[2], x=x[1], r=r[1], flow_max=200, pb=100),
            Line(id=3, from_bus=self.buses[1], to_bus=self.buses[2], x=x[2], r=r[2], flow_max=20, pb=100),
        ]