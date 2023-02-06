# What are your AVS traffic inspection requirements?
So how do we know which Network Scenario is best for us? First, you need to figure out your AVS inspection requirements, as shown below. Knowing your inspection requirements will guide you to the correct scenario that you will deploy. 

The following table uses VMware solution traffic inspection requirements to provide recommendations and considerations for the most common networking scenarios.

| Scenario | Traffic inspection requirements | Recommended solution design | Considerations |
|---|----|---|---|
| 1 |  - Internet ingress <br> - Internet egress | Use a Virtual WAN secured hub with default gateway propagation. </br></br> For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use Azure Firewall.</br></br> Deploy a secured Virtual WAN hub and enable public IP in Azure VMware Solution. | This solution doesn't work for on-premises filtering. Global Reach bypasses Virtual WAN hubs. |
| 2 |  - Internet ingress <br> - Internet egress <br> - To on-premises datacenter <br> - To Azure Virtual Network| Use third-party firewall NVA solutions in your hub virtual network with Azure Route Server. </br></br> Disable Global Reach. </br></br> For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use a third-party firewall NVA on Azure.| Choose this option if you want to use your existing NVA and centralize all traffic inspection in your hub virtual network. |
| 3 | - Internet ingress <br> - Internet egress <br> - To on-premises datacenter <br> - To Azure Virtual Network <br> Within Azure VMware Solution <br>|   Use NSX-T or a third-party NVA firewall in Azure VMware Solution. </br></br>  Use Application Gateway for HTTPs, or Azure Firewall for non-HTTPs traffic. </br></br> Deploy the secured Virtual WAN hub and enable public IP in Azure VMware Solution.| Choose this option if you need to inspect traffic from two or more Azure VMware Solution private clouds. </br></br> This option lets you use NSX-T native features. You can also combine this option with NVAs running on Azure VMware Solution between L1 and L0. |
| 4 | - Internet ingress <br> - To Azure Virtual Network| Use Virtual WAN secured hub. </br></br>  For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use Azure Firewall.</br></br> Deploy a secured Virtual WAN hub and enable public IP in Azure VMware Solution. | Choose this option to advertise the `0.0.0.0/0` route from on-premises datacenters. |
| 5 | - Internet ingress <br> - Internet egress </br> - To on-premises datacenter </br> - To Azure Virtual Network   | </br>  Use third-party firewall solutions in a hub virtual network with Azure Route Server. </br></br> For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use a third-party firewall NVA on Azure. </br></br> Use an on-premises third-party firewall NVA. </br></br> Deploy third-party firewall solutions in a hub virtual network with Azure Route Server. | Choose this option to advertise the `0.0.0.0/0` route from an NVA in your Azure hub virtual network to an Azure VMware Solution.|


**You can find more information on Traffic Inspection Requirements in the link below.**  
https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/azure-vmware/example-architectures

#### [prev](./understand-forecast.md) | [home](./readme.md)  | [next](https://github.com/jasonamedina/FTALive-Sessions/blob/main/content/avs/Scenario%201.md)
