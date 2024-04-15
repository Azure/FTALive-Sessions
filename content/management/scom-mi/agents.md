# SCOM MI Agents

Azure Monitor SCOM Managed Instance provides a cloud-based alternative for Operations Manager users providing monitoring continuity for cloud and on-premises environments across the cloud adoption journey.

[Monitor Azure and Off-Azure Virtual machines with Azure Monitor SCOM Managed Instance](https://learn.microsoft.com/en-us/system-center/scom/monitor-off-azure-vm-with-scom-managed-instance?view=sc-om-)

[Monitor Azure and Off-Azure Virtual machines with Azure Monitor SCOM Managed Instance (preview)](https://learn.microsoft.com/en-us/system-center/scom/monitor-arc-enabled-vm-with-scom-managed-instance?view=sc-om-2022)

## Supported Scenarios

The following are the supported monitoring scenarios:

- Azure Windows VMs that have Line of sight connectivity to the Management Server
- Azure Windows VMs with no Line of sight connectivity (must use managed Gateway)
- On-premise Arc-enabled VM's that have Line of sight connectivity to Management Server.
- On-premises agents with no Line of sight connectivity (must use managed Gateway) to Azure

Note:

- Linux VMs in Azure are not currently supported.
- Agent multi-homing isn't supported to multiple SCOM Managed Instances.

## Managed Gateways

Managed Gateways need to be Arc-enabled and then the Gateway extension needs to be installed, it can be installed via the Managed Gateways page in SCOM MI.
