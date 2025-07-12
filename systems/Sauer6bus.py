from power.models.electricity_models import *

class sauer6bus(Network):
    """
    Class to represent the Sauer 6 bus system.
    """
    def __init__(self):
        super().__init__(name="Sauer 6 Bus System")
        self._create_buses()
        self._create_lines()
        self._create_generators()
        self._create_loads()

    def _create_buses(self):
        """
        Creates the buses for the Sauer 6 bus system.
        """
        self.buses = [
            Bus(self, id=1, bus_type='Slack', v=1.05, theta=0.0, Sh=1),
            Bus(self, id=2, bus_type='PV', v=1.10, theta=0.0),
            Bus(self, id=3, bus_type='PQ', v=1.00, theta=0.0),
            Bus(self, id=4, bus_type='PQ', v=1.00, theta=0.0),
            Bus(self, id=5, bus_type='PQ', v=1.00, theta=0.0),
            Bus(self, id=6, bus_type='PQ', v=1.00, theta=0.0)
        ]

    def _create_lines(self):
        """
        Creates the lines for the Sauer 6 bus system.
        """
        self.lines = [
            Line(id=1,  from_bus=self.buses[0], to_bus=self.buses[3], r=0.080, x=0.370, b_half=0.00014),
            Line(id=2,  from_bus=self.buses[0], to_bus=self.buses[5], r=0.123, x=0.518, b_half=0.00021),
            Line(id=3,  from_bus=self.buses[1], to_bus=self.buses[2], r=0.723, x=1.050, b_half=0.0),
            Line(id=4,  from_bus=self.buses[1], to_bus=self.buses[4], r=0.282, x=0.640, b_half=0.0),
            Line(id=5,  from_bus=self.buses[3], to_bus=self.buses[5], r=0.097, x=0.407, b_half=0.00015),
            Line(id=6,  from_bus=self.buses[3], to_bus=self.buses[2], r=0.000, x=0.266, b_half=0.0, tap_ratio=1.025),
            Line(id=7,  from_bus=self.buses[3], to_bus=self.buses[2], r=0.000, x=0.266, b_half=0.0, tap_ratio=1.025),
            Line(id=8,  from_bus=self.buses[5], to_bus=self.buses[4], r=0.000, x=0.428, b_half=0.0, tap_ratio=1.1),
            Line(id=9,  from_bus=self.buses[5], to_bus=self.buses[4], r=0.000, x=1.000, b_half=0.0, tap_ratio=1.1)
        ]

    def _create_generators(self):
        # Criar os geradores
        self.generators = [
            Generator(id=1, bus=self.buses[0], pb=1.0),    # Slack (bus 1)
            Generator(id=2, bus=self.buses[1], pb=1.0, p_input=0.500)    # PV
        ]
    
    def _create_loads(self):
        # Criar as cargas
        self.loads = [
            Load(id=1, bus=self.buses[2], pb=1.0, p_input=0.550, q_input=0.130),  # Bus 3
            Load(id=2, bus=self.buses[4], pb=1.0, p_input=0.300, q_input=0.180),  # Bus 5
            Load(id=3, bus=self.buses[5], pb=1.0, p_input=0.500, q_input=0.050)   # Bus 6
        ]