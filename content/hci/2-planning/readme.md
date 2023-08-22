# Azure Stack HCI - Part 2: Planning & Deploying Azure Stack HCI

## Target Audience 
Level: 200+  
Who?: Admins - Architects - deploying operating (tech sales)  

## Agenda
- Introduction To Requirements
  - [System Requirements](https://learn.microsoft.com/en-us/azure-stack/hci/concepts/system-requirements)
  - [Physical (Network) Requirements](https://learn.microsoft.com/en-us/azure-stack/hci/concepts/physical-network-requirements?tabs=22H2%2C20-21H2reqs)
  - [Host (Network) Requirements](https://learn.microsoft.com/en-us/azure-stack/hci/concepts/host-network-requirements)
  - [Firewall Requirements](https://learn.microsoft.com/en-us/azure-stack/hci/concepts/firewall-requirements)
  - [Limitations](https://learn.microsoft.com/en-us/azure-stack/hci/concepts/system-requirements#maximum-supported-hardware-specifications)
  
- Networking
  - [Traffic classes](https://learn.microsoft.com/en-us/azure-stack/hci/concepts/host-network-requirements#network-traffic-types)
  - Storage Networks - [Switched](https://learn.microsoft.com/en-us/azure-stack/hci/concepts/physical-network-requirements?tabs=20-21H2%2C20-21H2reqs#using-switches) v [Switchless](https://learn.microsoft.com/en-us/azure-stack/hci/concepts/physical-network-requirements?tabs=20-21H2%2C20-21H2reqs#using-switchless)
  - Usage of [RDMA](https://en.wikipedia.org/wiki/Remote_direct_memory_access)
  - Typical Network Designs
  
- Storage
  - [Resiliency/Fault Tolerance](https://learn.microsoft.com/en-us/azure-stack/hci/concepts/fault-tolerance)
  - [Hardware](https://learn.microsoft.com/en-us/azure-stack/hci/concepts/drive-symmetry-considerations)
  - [Scaling](https://learn.microsoft.com/en-us/azure-stack/hci/manage/add-cluster)
  - Performance: [Understanding the storage pool cache](https://learn.microsoft.com/en-us/azure-stack/hci/concepts/cache)
  - Performance: [Benchmarking with VMFleet](https://techcommunity.microsoft.com/t5/azure-stack-blog/vmfleet-2-0-quick-start-guide/ba-p/2824778) and [Youtube: Azure Stack HCI Performance Testing using Vmfleet ft. Jaromir Kaspar](https://www.youtube.com/watch?v=YMYDzqnDMYc&t)
  
- Deployment/Cluster Creation
  - [OS Installation](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/operating-system)
  - [WAC](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/create-cluster?tabs=manually-configure-host-networking)
  - [Powershell](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/create-cluster-powershell)
  
- Registration
  - [Requirements](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/register-with-azure#region-availability)
  - [Via WAC](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/register-with-azure#register-a-cluster-using-windows-admin-center)
  - [Via PowerShell](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/register-with-azure#register-a-cluster-using-powershell)
  

## Additional viewing/reading/hands on
- Watch: [Manfred Helber (MVP): Azure Stack HCI Deployment Specialist Workshop](https://www.youtube.com/playlist?list=PL7cBl3ig-01NKNgTWtDy0KUDW_YNX50_1)
- Watch: [Learn Live - Azure Hybrid Cloud Study Hall](https://learn.microsoft.com/en-us/events/learn-events/learnlive-azure-hybrid-cloud-study-hall/)
- Watch: [The Hybrid Friends](https://www.youtube.com/channel/UC6nSJh2DNpMVZVhCEWtGNgw)
- Do: [Jumpstart HCIBox](https://github.com/microsoft/AzStackHCISandbox/blob/main/README.md)
- [Build a nested enviroment](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/tutorial-private-forest)
- Planning right-sizing: [Azure Stack sizing tool](https://hcicatalog.azurewebsites.net/#/sizer)



## Related sessions: 
- [Azure Stack HCI - Part 1: Introduction To HCI](../1-intro/readme.md)
- [Azure Stack HCI - Part 3: Operating Azure Stack HCI](../3-operating/readme.md)
  


[up](../readme.md)