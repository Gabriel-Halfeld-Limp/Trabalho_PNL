from power import *
from systems import *

net = three_bus()
solver  = PNL_OPF(net, com_rede=True)
solver.model.pprint()
results = solver.solve()
results_json = results.to_json()
with open('results_com_rede.json', 'w') as f:
    f.write(results_json)