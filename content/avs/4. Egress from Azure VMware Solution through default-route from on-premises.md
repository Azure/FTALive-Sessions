# 4. Egress from Azure VMware Solution through 0.0.0.0/0 advertisement from on-premises
| Scenario | Traffic inspection requirements | Recommended solution design | Considerations |
|---|----|---|---|
| 4 | - Internet ingress <br> - To Azure Virtual Network| Use Virtual WAN secured hub. </br></br>  For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use Azure Firewall.</br></br> Deploy a secured Virtual WAN hub and enable public IP in Azure VMware Solution. | Choose this option to advertise the `0.0.0.0/0` route from on-premises datacenters. |

![image](https://user-images.githubusercontent.com/97964083/216826417-fc2178e4-7f6b-4265-b6d2-d72d1dad057b.png)


#### [prev](./understand-forecast.md) | [home](./readme.md)  | [next](./control.md)
