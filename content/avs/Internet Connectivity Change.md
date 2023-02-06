# AVS Internet Connectivity Portal Change

If you're using Scenario 1-5, you must choose **"Do not connect or connect using default route from Azure**. This step will need to be done after you have deployed your Azure Network and after you have deployed AVS.
![image](https://user-images.githubusercontent.com/97964083/217078074-ed72cdb8-237e-4612-a42b-7d706120d8f4.png)

# Alternative AVS Internet Breakout Options

### Enable Managed SNAT for Azure VMware Solution workloads
Azure VMware Solution’s Managed Source NAT (SNAT) to connect to the Internet outbound. A SNAT service translates from RFC1918 space to the public Internet for simple outbound Internet access. The SNAT service won't work when you have a default route from Azure.
![image](https://user-images.githubusercontent.com/97964083/217093272-01620069-ccb9-4387-a76d-e5cd28471256.png)

With this capability, you:
- Have a basic SNAT service with outbound Internet connectivity from your Azure VMware Solution private cloud.
- Have no control of outbound SNAT rules.
- Are unable to view connection logs.
- Have a limit of 128 000 concurrent connections.

How To Enable From Azure Portal: Choose **"Connect using SNAT"**
![image](https://user-images.githubusercontent.com/97964083/217094810-13b5f795-b3bd-4c2d-a89a-1a3835818877.png)

### Enable Public IP to the NSX-T Data Center Edge for Azure VMware Solution
This option brings an allocated Azure Public IPv4 address directly to the NSX-T Data Center Edge for consumption. It allows the Azure VMware Solution private cloud to directly consume and apply public network addresses in NSX-T Data Center as required. This option also lets you configure the public address on a third-party Network Virtual Appliance to create a DMZ within the Azure VMware Solution private cloud.

The architecture shows Internet access to and from your Azure VMware Solution private cloud using a Public IP directly to the NSX-T Data Center Edge.
![image](https://user-images.githubusercontent.com/97964083/217094150-367daa89-fae9-4cc5-8f2d-3b40378fc892.png)

These public addresses are used for the following types of connections:
- Outbound SNAT
- Inbound DNAT
- Load balancing using VMware NSX Advanced Load Balancer and other third-party Network Virtual Appliances
- Applications directly connected to a workload VM interface.

How To Enable From Azure Portal: Choose **"Connect using Public IP down to the NSX-T Edge"**
![image](https://user-images.githubusercontent.com/97964083/217096473-40af8f40-c9c5-48fa-99a1-bb0abad28456.png)

#### [prev](https://github.com/jasonamedina/FTALive-Sessions/blob/main/content/avs/Scenario%205.md) | [home](./readme.md)
