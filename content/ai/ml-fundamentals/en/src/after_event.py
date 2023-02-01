from azureml.core import Workspace
from azureml.core.compute import ComputeInstance, AmlCompute
from azureml.pipeline.core.schedule import Schedule

ws = Workspace.from_config()

# Delete any deployed webservices
for webservice_name, webservice in ws.webservices.items():
    print(f"Deleting webservice {webservice.name}")
    try:
        webservice.delete()
    except Exception as e:
        print(f"Failed to delete web service {webservice.name} with error {e})")

# Disable scheduled pipelines
schedules = Schedule.list(ws, active_only=True)
for schedule in schedules:
    print(
        f"Disabling schedule with id {schedule.id} (Published pipeline: {schedule.pipeline_id}"
    )
    schedule.disable(wait_for_provisioning=True)

# Loop through compute targets and scale down clusters
for ct_name, ct in ws.compute_targets.items():
    if isinstance(ct, AmlCompute):
        print(f"Scaling down cluster {ct.name}")
        try:
            ct.update(min_nodes=0)
        except Exception as e:
            print(f"Failed to scale down cluster {ct.name} with error {e})")

# Once done, shutdown compute instance
for ct_name, ct in ws.compute_targets.items():
    if isinstance(ct, ComputeInstance) and ct.get_status().state != "Stopped":
        print(f"Stopping compute instance {ct.name}")
        try:
            ct.stop(wait_for_completion=False, show_output=False)
        except Exception as e:
            print(f"Failed to stop compute {ct.name} with error {e})")
