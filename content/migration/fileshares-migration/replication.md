# Milestone: Assess and Select Migration Tooling

#### [prev](./landingzone.md) | [home](./readme.md)  | [next](./testing.md)

The following content can be used as a checklist to incorporate within your migration project plan to ensure best practices.
## **Data Transfer** 

### Choose between Offline vs. Online data transfer
Decide on [Data Transfer Methodology](https://docs.microsoft.com/en-us/azure/storage/common/storage-migration-overview?toc=/azure/storage/blobs/toc.json#select-the-migration-method) based on the following [graph](https://docs.microsoft.com/en-us/azure/storage/common/storage-choose-data-transfer-solution) and extend based on the following scenarios:
- [Large dataset, low network bandwidth](https://docs.microsoft.com/en-us/azure/storage/common/storage-solution-large-dataset-low-network?toc=/azure/storage/blobs/toc.json)
- [Large dataset, moderate to high network bandwidth](https://docs.microsoft.com/en-us/azure/storage/common/storage-solution-large-dataset-moderate-high-network?toc=/azure/storage/blobs/toc.json)
- [Small dataset, low to moderate network bandwidth](https://docs.microsoft.com/en-us/azure/storage/common/storage-solution-small-dataset-low-moderate-network?toc=/azure/storage/blobs/toc.json)
 
## **Migration Tooling** 

### Choose between automated vs. manual approach
Automated approaches encompass wizard driven tools which migrate at scale file share environments. A manual approach refers to building custom scripts to migrate specific file shares.

- [Manual Approach Comparison](https://docs.microsoft.com/en-us/azure/storage/common/storage-solution-periodic-data-transfer?toc=/azure/storage/blobs/toc.json#scriptedprogrammatic-network-data-transfer)
 
### Review if automated migration tool supports desired sources and destinations

- [Storage Migration Service](https://docs.microsoft.com/en-us/windows-server/storage/storage-migration-service/overview#how-the-migration-process-works)
- [File Sync Service and Third Party ISVs](https://docs.microsoft.com/en-us/azure/storage/solution-integration/validated-partners/data-management/migration-tools-comparison?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/toc.json#supported-azure-services)
    - Consider the [File Migration Program](https://techcommunity.microsoft.com/t5/azure-storage-blog/migrate-the-critical-file-data-you-need-to-power-your/ba-p/3038751) to attain free licensing for selected ISVs
- [NetApps Cloud Sync](https://docs.netapp.com/us-en/cloud-manager-sync/reference-supported-relationships.html)

## **Migrate File Shares Dependencies**
### Choose between automated vs. manual approach to migrate clients
Azure Migrate, a redeploy approach or other third party tools can be used to migrate dependent client machines such as Applications hosted on Windows and Linux servers consuming the file shares.

Guidance can be found in our [FTA Live for Server Migration](../server-migration/replication.md) content. 

