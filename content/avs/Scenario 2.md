# 2. Network Virtual Appliance in Azure Virtual Network to inspect all network traffic
| Scenario | Traffic inspection requirements | Recommended solution design | Considerations |
|---|----|---|---|
| 2 |  - Internet ingress <br> - Internet egress <br> - To on-premises datacenter <br> - To Azure Virtual Network| Use third-party firewall NVA solutions in your hub virtual network with Azure Route Server. </br></br> Disable Global Reach. </br></br> For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use a third-party firewall NVA on Azure.| Choose this option if you want to use your existing NVA and centralize all traffic inspection in your hub virtual network. |  

![image](https://user-images.githubusercontent.com/97964083/216825937-9e97d644-f391-4d3d-ae5b-7d24ea8888b2.png)

#### [prev](https://github.com/jasonamedina/FTALive-Sessions/blob/main/content/avs/Scenario%201.md) | [home](./readme.md)  | [next](https://github.com/jasonamedina/FTALive-Sessions/blob/main/content/avs/Scenario%203.md)
