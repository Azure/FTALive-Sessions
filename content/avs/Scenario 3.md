# 3. Egress natively from Azure VMware Solution using NSX-T or NVA 
| Scenario | Traffic inspection requirements | Recommended solution design | Considerations | Internet Breakout |
|---|----|---|---|---|
| 3 | - Internet ingress <br> - Internet egress <br> - To on-premises datacenter <br> - To Azure Virtual Network <br> Within Azure VMware Solution <br>|   Use NSX-T or a third-party NVA firewall in Azure VMware Solution. </br></br>  Use NSX-T Advanced Load Balancer for HTTPs, or NSX-T Firewall for non-HTTPs traffic. </br></br> Public IP for Internet breakout from Azure VMware Solution, SNAT, and DNAT. | Enable Public IP down to the NSX Edge in Azure Portal. This option allows for low-latency connections to Azure, and the ability to scale the number of outbound connections. </br></br> Leverage the NSX firewall for granular rule creation, URL filtering, and TLS Inspection. </br></br> Consider using a load balancer to evenly distribute traffic to workloads. </br></br> Enable DDoS protection.  | Azure VMWare Solution

![image](https://user-images.githubusercontent.com/97964083/217638380-8fb7deb4-5ee5-42e3-91d4-6fd3d1651880.png)



#### [prev](https://github.com/jasonamedina/FTALive-Sessions/blob/main/content/avs/Scenario%202.md) | [home](./readme.md)  | [next](https://github.com/jasonamedina/FTALive-Sessions/blob/main/content/avs/Scenario%204.md)
