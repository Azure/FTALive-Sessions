from azureml.core import Workspace

compute_name = "cpu-cluster"
ws = Workspace.from_config()

# Have 2 nodes as hot stand by to accelerate processing
cluster = ws.compute_targets[compute_name]
cluster.update(min_nodes=2)
