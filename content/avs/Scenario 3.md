# 3. Egress natively from Azure VMware Solution using NSX-T or NVA 
| Scenario | Traffic inspection requirements | Recommended solution design | Considerations | Internet Breakout |
|---|----|---|---|---|
| 3 | - Internet ingress <br> - Internet egress <br> - To on-premises datacenter <br> - To Azure Virtual Network <br> Within Azure VMware Solution <br>|   Use NSX-T or a third-party NVA firewall in Azure VMware Solution. </br></br>  Use Application Gateway for HTTPs, or Azure Firewall for non-HTTPs traffic. </br></br> Deploy the secured Virtual WAN hub and enable public IP in Azure VMware Solution.| Choose this option if you need to inspect traffic from two or more Azure VMware Solution private clouds. </br></br> This option lets you use NSX-T native features. You can also combine this option with NVAs running on Azure VMware Solution between L1 and L0. | Azure VMWare Solution

![image](https://user-images.githubusercontent.com/97964083/217638380-8fb7deb4-5ee5-42e3-91d4-6fd3d1651880.png)



#### [prev](https://github.com/jasonamedina/FTALive-Sessions/blob/main/content/avs/Scenario%202.md) | [home](./readme.md)  | [next](https://github.com/jasonamedina/FTALive-Sessions/blob/main/content/avs/Scenario%204.md)
