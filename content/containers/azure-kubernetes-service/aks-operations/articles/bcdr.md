# Business Continuity and Disaster Recovery

## Uptime SLA of AKS

- The financially backed uptime SLA is for the Kubernetes API server.
  - Clusters that use availability zones: **99.95%**
  - Clusters that do not use availability zones: **99.9%**
- The SLO for clusters which opt out of the paid uptime SLA is **99.5%**.
- The SLA of the agent node is covered by the virtual machine SLA of Azure.
- **The SLA guarantees that you will get the service credit if we don't meet the SLA.** Evaluate the **cost of the impact** vs. **the service credit** you get in case outage happens, and plan the BC/DR strategy accordingly.

Read further:

- [AKS Uptime SLA](https://docs.microsoft.com/azure/aks/uptime-sla)
- [SLA for AKS](https://azure.microsoft.com/support/legal/sla/kubernetes-service/v1_1/)

## BC/DR best practices

- The financially backed uptime SLA is recommended for AKS clusters in production. Deploy the AKS clusters in production with availability zones.
- Define your own SLA for the workloads that you run in AKS clusters. If the SLA of AKS cannot meet your requirement, or if the impact of the potential outage is not affordable, consider deploying another AKS cluster to the second region. The paired region is preferred if AKS is available in the paired region. The cluster in the second region can be used as a hot, warm or cold standby of the cluster in the primary region.
  - The planned maintenance of AKS platform are serialized with a delay of at least 24 hours between paired regions.
  - Recovery efforts for paired regions are prioritized where needed.
- To achieve registry resilience in case of a regional failure, enable geo-replication on the Azure container registry. Geo-replication enables an Azure container registry to function as a single registry, serving multiple regions with multi-master regional registries.
- Leverage Availability Zones when possible. 
- Use Infrastructure as Code (IaC) to deploy and configure AKS clusters. With IaC, you can redeploy the clusters quickly whenever needed.
    - Ensure any management activities (i.e. patches, upgrades, identity and access management) is applied on the secondary instances
- Use CI/CD pipeline to deploy applications. Include your AKS clusters in different regions in the pipeline to ensure the latest code is deployed in all clusters simultaneously.
    - Consider [GitOps](https://docs.microsoft.com/azure/azure-arc/kubernetes/tutorial-use-gitops-flux2#for-azure-kubernetes-service-clusters) to ensure consistent deployment across primary and secondary clusters
- Avoid storing the state of applications in the cluster as much as you can. Externalize state by using a database or other data store that runs outside of the AKS cluster.
- If you have to store the state in the cluster, think of the disaster recovery strategy for the storage of the state, such as how to backup the storage, how to replicate or migrate the data in multiple regions, the RPO/RTO etc.
  - [ZRS](https://github.com/kubernetes-sigs/azuredisk-csi-driver/tree/master/deploy/example/topology#zrs-disk-support) Disks allows creation of volumes that can tolerate zonal failures. Stateful workloads in a multi-zone cluster can be moved across zones with uninterrupted access to the volumes.
  
    > ⚠️ ZRS for managed disks is only supported with Premium SSD and Standard SSD managed disks. Make sure that its [limitations](https://docs.microsoft.com/azure/virtual-machines/disks-redundancy#limitations) are reviewed before using it.
  
  - Build the infrastructure-based asynchronous geo-replication based on distributed storage solutions such as [GlusterFS](https://docs.gluster.org/en/latest/) or storage solutions for Kubernetes such as [Portworx](https://portworx.com/).
  - Backup and restore : You backup and restore the applications and the persistent volumes on the cluster by using Kubernetes backup tools such as [Velero](https://github.com/vmware-tanzu/velero-plugin-for-microsoft-azure) or [Kasten](https://www.kasten.io/). [Azure Kubernetes Service (AKS) Backup](https://azure.microsoft.com/en-us/updates/private-preview-aks-backup/). It allows you to backup and restore your containerized applications, both stateless and stateful, running on your AKS clusters and data stored within Persistent Volumes attached to the clusters. 

    > 📘
    > You can use Velero to backup applications as well as the persistent volumes that are based on Azure Managed Disk. For persistent volumes that are based on Azure Files, you can use [Velero with Restic](https://velero.io/docs/v1.6/restic/). But make sure you understand all its limitations before using it. An alternative approach is to backup Azure Files separately with Azure Backup.

- Create a DR plan for your AKS clusters. Have rehearsals regularly to make sure it works.

Read further:

- [Best practices for business continuity and disaster recovery in AKS](https://docs.microsoft.com/azure/aks/operator-best-practices-multi-region)
- [Create AKS cluster that uses availability zones](https://learn.microsoft.com/en-us/azure/aks/availability-zones?source=recommendations)
