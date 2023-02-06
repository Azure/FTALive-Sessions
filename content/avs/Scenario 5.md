# 5. A third-party NVA in the hub VNet inspects traffic between AVS and the internet and between AVS and Azure VNets
| Scenario | Traffic inspection requirements | Recommended solution design | Considerations |
|---|----|---|---|
| 5 | - Internet ingress <br> - Internet egress </br> - To on-premises datacenter </br> - To Azure Virtual Network   | </br>  Use third-party firewall solutions in a hub virtual network with Azure Route Server. </br></br> For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use a third-party firewall NVA on Azure. </br></br> Use an on-premises third-party firewall NVA. </br></br> Deploy third-party firewall solutions in a hub virtual network with Azure Route Server. | Choose this option to advertise the `0.0.0.0/0` route from an NVA in your Azure hub virtual network to an Azure VMware Solution.|

![image](https://user-images.githubusercontent.com/97964083/216826483-bbb1c507-7fcf-4da6-98ea-a86100a2b28f.png)


#### [prev](https://github.com/jasonamedina/FTALive-Sessions/blob/main/content/avs/Scenario%204.md) | [home](./readme.md) 
