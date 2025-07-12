from power.models.electricity_models import *

class bus2aula9(Network):
    def __init__(self):
        super().__init__(id=1, name="Simple 2-Bus System")
        self._create_buses()
        self._create_loads()
        self._create_generators()
        self._create_lines()

    def _create_buses(self):
        # Create buses
        self.buses = [
            Bus(self, id=1, bus_type='Slack'),
            Bus(self, id=2, bus_type='PQ')
        ]

    def _create_loads(self):
        # Create loads
        self.loads = [
            Load(id=1, bus=self.buses[1], p_input=0.1, q_input=0),  # Bus 2
        ]

    def _create_generators(self):
        # Create generators
        self.generators = [
            Generator(id=1, bus=self.buses[0])  # Slack (bus 1)
        ]

    def _create_lines(self):
        # Create lines
        self.lines = [
            Line(id=1, from_bus=self.buses[0], to_bus=self.buses[1], r=0.0, x=1)
        ]


