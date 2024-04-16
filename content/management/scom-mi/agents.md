# SCOM MI Agents

Azure Monitor SCOM Managed Instance provides a cloud-based alternative for Operations Manager users providing monitoring continuity for cloud and on-premises environments across the cloud adoption journey.

[Monitor Azure and Off-Azure Virtual machines with Azure Monitor SCOM Managed Instance](https://learn.microsoft.com/en-us/system-center/scom/monitor-off-azure-vm-with-scom-managed-instance?view=sc-om-)

[Monitor Azure and Off-Azure Virtual machines with Azure Monitor SCOM Managed Instance (preview)](https://learn.microsoft.com/en-us/system-center/scom/monitor-arc-enabled-vm-with-scom-managed-instance?view=sc-om-2022)

## Supported Scenarios

The following are the supported monitoring scenarios:

- Azure Windows VMs that have Line of sight connectivity to the Management Server
- On-premise Windows & Linux Arc-enabled VMs that have Line of sight connectivity to Management Server.
- On-premise Windows & Linux agent VMs that have Line of sight connectivity to Management Server.
- On-premises Windows agents with no Line of sight connectivity (must use managed Gateway) to Azure

Note:

- Linux VMs in Azure and Linux VMs that sit behind a gateway are not currently supported.
- Agent multi-homing isn't supported to multiple SCOM Managed Instances. However, it can have a multi-home configuration for on-premises System Center Operations Manager and a SCOM Managed Instance.
- Agents that are directly connected to the SCOM MI need to be able to reach <region>.workloadnexus.azure.com on port 443.
- .NET 4.7.2 and TLS 1.2 is required for agent install.

## Managed Gateways

Managed Gateways need to be Arc-enabled with the Gateway extension installed, it can be installed via the Managed Gateways page in SCOM MI.

Note:

- Currently, multi-homing for gateway servers isn't supported.
- Arc-enabled Gateways require line of sight to <region>.workloadnexus.azure.com on port 443.
- Initial authentication is performed by a managed identity, then certificates are used to manage Managed Gateways by Microsoft.
