from power.models.electricity_models import *
import numpy as np

class test3bus(Network):
    def __init__(self):
        super().__init__(id=1, name="Simple 3-Bus System")
        self._create_buses()
        self._create_loads()
        self._create_generators()
        self._create_lines()

    def _create_buses(self):
        # Create buses
        self.buses = [
            Bus(self, id=1, bus_type='PV'),
            Bus(self, id=2, bus_type='PV'),
            Bus(self, id=2, bus_type='PQ'),
        ]

    def _create_loads(self):
        # Create loads
        self.loads = [
            Load(id=1, bus=self.buses[2], p_input_series= np.array([60, 75, 100])),
        ]

    def _create_generators(self):
        # Create generators
        self.generators = [
            Generator(id=1, bus=self.buses[0], cost_a_input=0.01, cost_b_input=10, cost_c_input=100, ramp_input=10, p_max_input=50, p_min_input=20),
            Generator(id=2, bus=self.buses[1], cost_a_input=0.02, cost_b_input=20, cost_c_input=200, ramp_input=15, p_max_input=60, p_min_input=40),
              # PV (bus 2)

        ]

    def _create_lines(self):
        # Create lines
        self.lines = [
            Line(id=1, from_bus=self.buses[0], to_bus=self.buses[1],x=0.5),
            Line(id=2, from_bus=self.buses[0], to_bus=self.buses[2], x=0.5),
            Line(id=3, from_bus=self.buses[1], to_bus=self.buses[2], x=0.5),
        ]