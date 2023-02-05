# 1. Secured Virtual WAN hub with default route propagation

| Scenario | Traffic inspection requirements | Recommended solution design | Considerations |
|---|----|---|---|
| 1 |  - Internet ingress <br> - Internet egress | Use a Virtual WAN secured hub with default gateway propagation. </br></br> For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use Azure Firewall.</br></br> Deploy a secured Virtual WAN hub and enable public IP in Azure VMware Solution. | This solution doesn't work for on-premises filtering. Global Reach bypasses Virtual WAN hubs. |
  
![eslz-net-scenario-1](https://user-images.githubusercontent.com/97964083/216805269-ccdc8006-1202-4ab1-863a-f5d9b296863d.png)

#### [prev](https://github.com/jasonamedina/FTALive-Sessions/blob/main/content/avs/Traffic%20Inspection%20Requirements.md) | [home](./readme.md) | [next](https://github.com/jasonamedina/FTALive-Sessions/blob/main/content/avs/Scenario%202.md)
