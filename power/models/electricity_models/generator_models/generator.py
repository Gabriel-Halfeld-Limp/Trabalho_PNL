from power.models.electricity_models.bus_models import *
from dataclasses import dataclass
from typing import ClassVar, Optional
import numpy as np

@dataclass
class Generator:
    bus: 'Bus'
    name: Optional[str] = None
    id: Optional[int] = None

    pb: float = 1.0
    p_input: float = 0.0
    q_input: float = 0.0
    p_max_input: float = float('inf')
    p_min_input: float = 0.0
    q_max_input: Optional[float] = 99999
    q_min_input: Optional[float] = -99999
    cost_a_input: float = 0.0
    cost_b_input: float = 0.0
    cost_c_input: float = 0.0
    ramp_input: float = 0.0

    _id_counter: ClassVar[int] = 0

    def __post_init__(self):
        if self.id is None:
            self.id = Generator._id_counter
            Generator._id_counter += 1
        else:
            self.id = int(self.id)
            if self.id >= Generator._id_counter:
                Generator._id_counter = self.id + 1

        if self.name is None:
            self.name = f"Generator {self.id}"

        self.bus.add_generator(self)
        self.network = self.bus.network
        self.network.generators.append(self)

    @property
    def p(self) -> float:
        return self.p_input / self.pb

    @property
    def q(self) -> float:
        return self.q_input / self.pb

    @property
    def p_max(self) -> float:
        return self.p_max_input / self.pb

    @property
    def p_min(self) -> float:
        return self.p_min_input / self.pb

    @property
    def q_max(self) -> Optional[float]:
        return self.q_max_input / self.pb if self.q_max_input is not None else None

    @property
    def q_min(self) -> Optional[float]:
        return self.q_min_input / self.pb if self.q_min_input is not None else None

    @property
    def cost_a(self) -> float:
        return self.cost_a_input * self.pb

    @property
    def cost_b(self) -> float:
        return self.cost_b_input * self.pb

    @property
    def cost_c(self) -> float:
        return self.cost_c_input * self.pb
    
    @property
    def ramp(self) -> float:
        return self.ramp_input / self.pb

    def __repr__(self):
        return (f"Generator(id={self.id}, bus={self.bus.id}, p={self.p:.3f}, q={self.q:.3f}, "
                f"p_range=[{self.p_min:.3f},{self.p_max:.3f}], q_range=[{self.q_min},{self.q_max}]),")