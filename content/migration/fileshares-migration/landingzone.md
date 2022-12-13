# Milestone: Design and Build Landing Zone

#### [prev](./scan.md) | [home](./readme.md)  | [next](./replication.md)

The overall Landing Zone architecture and implementation will be defined by your specific company requirements. Specific requirements to host File Shares infrastructure will need to be defined based on the underlying Landing Zone design.
## Azure Landing Architecture
It's important to plan for the overall Landing Zone architecture and implementation before focusing on the File Shares architecture requirements.

Guidance can be found in our [FTA Live for Server Migration](../server-migration/landingzone.md) content. 
## File Shares Architecture
The following architecture options exists for the various file share services and use cases:
### **NetApps Architecture**
- [Storage Hierarchy of Azure NetApps Files](https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-understand-storage-hierarchy)
-  [Guidelines for Azure NetApp Files network planning](https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-network-topologies)
- [VDI Specific Architecture](https://docs.microsoft.com/en-us/azure/architecture/example-scenario/wvd/windows-virtual-desktop)

### **Azure Files Architecture**
- [Planning for an Azure Files Deployment](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-planning)
- [Simple Hybrid Architecture](https://docs.microsoft.com/en-us/azure/architecture/hybrid/azure-file-share)
- [Advanced Hybrid Architecture](https://docs.microsoft.com/en-us/azure/architecture/example-scenario/hybrid/azure-files-on-premises-authentication)
- [VDI Specific Architecture](https://docs.microsoft.com/en-us/azure/architecture/example-scenario/wvd/windows-virtual-desktop)
### **Azure Files Sync Service Architecture**
- [Planning for an Azure Files Sync Service Deployment](https://docs.microsoft.com/en-us/azure/storage/file-sync/file-sync-planning)
- [Simple Hybrid Architecture](https://docs.microsoft.com/en-us/azure/architecture/hybrid/hybrid-file-services)
- [Advanced Hybrid Architecture](https://docs.microsoft.com/en-us/azure/architecture/hybrid/azure-files-private)
- [VDI Specific Architecture](https://docs.microsoft.com/en-us/azure/architecture/example-scenario/hybrid/hybrid-file-share-dr-remote-local-branch-workers)

### **Windows Server File Share on Azure Architecture**

- [TBD]()
