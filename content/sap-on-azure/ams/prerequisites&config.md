# Provider Configuration Prerequisites

#### [prev](./providers.md) | [home](./introduction.md)

## Provider type: SAP NetWeaver

1. Unprotect methods for metrics

* setup following parameter in DEFAULT.PFL **service/protectedwebmethods = SDEFAULT -GetQueueStatistic -ABAPGetWPTable -EnqGetStatistic -GetProcessList**
* Restart the SAPStartSRV service on each instance in the SAP system. Restarting the services doesn't restart the entire system. This process only restarts SAPStartSRV (on Windows) or the daemon process (in Unix or Linux).

2. Set up RFC metrics

* Download the custom role [Z_AMS_NETWEAVER_MONITORING.zip](https://github.com/Azure/Azure-Monitor-for-SAP-solutions-preview/files/8710130/Z_AMS_NETWEAVER_MONITORING.zip) and upload into working client using PFCG.
* Create a dedicated system user and assign the role uploaded in previous step. This is used for AMS to connect with SAP Application.
* Ensure ST-PI is at least on 740 SP05 level or above.
* Enable SMON to monitor system performance as per SAP NOTE: [2651881](https://userapps.support.sap.com/sap/support/knowledge/en/2651881)
* Ensure ICM port is enabled via Profile parameter or via SMICM.
* Activate following SICF services **(wsdl, wsdl11 and RFC)** under the path /default_host/sap/bc/soap/.
* Activate following SICF services /sap/public/ping and /sap/bc/ping as well. Test the ping service to ensure ICM port is reachable from web client.

3. Configure the NetWeaver provider as per the [MS docs](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/sap/configure-netweaver-azure-monitor-sap-solutions#add-netweaver-provider)


## Provider type: SAP HANA

1. Create a dedicated user (preferably technical User for which there is no password expiry) with MONITORING or BACKUP CATALOG READ roles assigned. Create the same in SYSTEMDB rather than Tenant DB as former has got more monitoring views.
2. Provide the input as shown in the image below to configure HANA provider.
3. For HA systems, IP address of Standard ILB can be used so that failover scenarios are monitored. 

<br>
<p align="center">
<img src="/content/sap-on-azure/images/hanaprovider.png" width="50%" height="50%">
</p>


## Provider type: MS SQL Server

1. Open the Windows port in the local firewall of SQL Server and the network security group (NSG) where SQL Server and Azure Monitor for SAP solutions exist. The default port is 1433.
2. Ensure [SQL authentication](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/sap/configure-sql-server-azure-monitor-sap-solutions#configure-sql-server) is enabled on MS SQL server.
3. Create a dedicated user for the database SID as described in [MS Docs](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/sap/configure-sql-server-azure-monitor-sap-solutions#configure-sql-server).
4. Configure MS SQL Provider in AMS as shown below.

<br>
<p align="center">
<img src="/content/sap-on-azure/images/mssprovider.png" width="50%" height="50%">
</p>


## Provider type: High Availability cluster (Pacemaker)

1. Install HA Agent on each of the cluster node based on the Operating system version.
* For SUSE-based clusters, install [ha_cluster_provider](https://github.com/ClusterLabs/ha_cluster_exporter#installation) in each node. Minium of SLES 12 SP3 or above is required.
* For RHEL-based clusters, install [performance co-pilot (PCP) and the pcp-pmda-hacluster](https://access.redhat.com/articles/6139852) sub package in each node. Supported RHEL versions are 8.2, 8.4 and above.
* For RHEL-based pacemaker clusters, also install [PMProxy](https://access.redhat.com/articles/6139852) in each node
2. Configure High Availability cluster (pacemaker) provider for each node as mentioned in [MS Docs](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/sap/configure-ha-cluster-azure-monitor-sap-solutions#create-provider-for-azure-monitor-for-sap-solutions)
3. Each node have to be added separately into High Availability cluster (pacemaker) provider.

<br>
<p align="center">
<img src="/content/sap-on-azure/images/hacluster.png" width="50%" height="50%">
</p>


## Provider type: OS Linux

1. Install [node exporter version 1.8.0](https://prometheus.io/download/#node_exporter) in each SAP host that you want to monitor.
2. Configure Linux Provider in AMS service as described in [MS Docs](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/sap/configure-linux-os-azure-monitor-sap-solutions#create-linux-provider)

## Provider type: IBM Db2

1. Create a dedicated DB user with DBADM or SYSCTRL (used for DB2 specific monitoring functions).
2. Follow the [MS docs](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/sap/configure-db-2-azure-monitor-sap-solutions#create-ibm-db2-provider) to configure IBM db2 provider.

## Additional Information

* https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/sap/azure-monitor-providers
* https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/sap/monitor-sap-on-azure-reference
* https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/sap/create-network-azure-monitor-sap-solutions
* https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/sap/azure-monitor-alerts-portal
* https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/sap/azure-monitor-sap-quickstart


#### [prev](./providers.md) | [home](./introduction.md)
