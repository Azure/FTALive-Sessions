# AVS Internet Connectivity Portal Change

If you're using Scenario 1,2,4,5, you must choose **"Do not connect or connect using default route from Azure**. This step will need to be done after you have deployed your Azure Network and after you have deployed AVS.
- For scenarios 1,2 & 5, as long as you are advertising a default-route to AVS, your internet breakout will be Azure. 
- For scenario 4, as long as you are advertising a default-route from on-premise, your internet breakout will be on-premise. 
- Please keep in mind that if you are using this option and are not advertising a default-route, your AVS workload will be completely isolated with no internet access. 
![image](https://user-images.githubusercontent.com/97964083/217078074-ed72cdb8-237e-4612-a42b-7d706120d8f4.png)

### Enable Public IP to the NSX-T Data Center Edge for Azure VMware Solution
If you're using Scenario 3, you must choose **"Connect using Public IP down to the NSX-T Edge"**. Again, This step will need to be done after you have deployed your Azure Network and after you have deployed AVS.
- For scenario 3, your internet breakout will be Azure VMWare Solution. 
![image](https://user-images.githubusercontent.com/97964083/217096473-40af8f40-c9c5-48fa-99a1-bb0abad28456.png)

### Enable Managed SNAT for Azure VMware Solution workloads
If you're not using any of the Scenarios and you just do not care about network inspection and just need your AVS workload to have internet access you must choose **"Connect using SNAT"**. This is Azure VMware Solution’s Managed Source NAT (SNAT) to connect to the Internet outbound only.
- For SNAT your local internet breakout will be Azure VMWare Solution. This is not a popular option; we mostly see this option used in cases as a break-glass scenario where immediate internet access is needed during the deployment of AVS so workload can get updates. 
![image](https://user-images.githubusercontent.com/97964083/217094810-13b5f795-b3bd-4c2d-a89a-1a3835818877.png)

#### [prev](https://github.com/jasonamedina/FTALive-Sessions/blob/main/content/avs/Scenario%205.md) | [home](./readme.md)
