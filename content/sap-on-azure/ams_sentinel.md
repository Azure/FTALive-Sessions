# Welcome to FTA Live session "Azure Monitor for SAP Solutions and Microsoft Sentinel Continuous Threat Monitoring for SAP"

## Agenda

Azure Monitor for SAP Solutions (AMS) is an Azure-native monitoring product for SAP landscapes on Azure. In the first part of this session, you will learn about AMS and how you can utilize it for monitoring your mission-critical SAP workloads for availability, performance, and operation.
<br /><br />The second part will cover Microsoft Sentinel Continuous Threat Monitoring for SAP solution. Microsoft Sentinel is a cloud-native Security Information and Event Management (SIEM) and Security Orchestration, Automation, and Response (SOAR) solution. Join this session to learn about how to deploy, configure and monitor your SAP systems with Microsoft Sentinel for advanced threat detection.
<br /><br />Both presentations will be accompanied by demos.

## Azure Monitor for SAP Solutions (AMS)

When you have critical applications and business processes relying on Azure resources, you'll want to monitor those resources for their availability, performance, and operation.

Azure Monitor for SAP Solutions is an Azure-native monitoring product for anyone running their SAP landscapes on Azure. It works with both [SAP on Azure Virtual Machines](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/hana-get-started) and [SAP on HANA Large Instances](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/hana-overview-architecture).

With AMS, you can collect telemetry data from Azure infrastructure and databases in one central location and visually correlate the data for faster troubleshooting.

You can monitor different components of an SAP landscape, such as Azure virtual machines (VMs), high-availability cluster, SAP HANA database, SAP NetWeaver, and so on, by adding the corresponding [provider](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/azure-monitor-providers) for that component. For more information, see [Deploy Azure Monitor for SAP Solutions by using the Azure portal](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/azure-monitor-sap-quickstart).

Supported infrastructure:

- Azure virtual machine
- HANA Large Instance

Supported databases:

- SAP HANA
- Microsoft SQL server

AMS uses the [Azure Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/overview) capabilities of [Log Analytics](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-overview) and [Workbooks](https://docs.microsoft.com/en-us/azure/azure-monitor/visualize/workbooks-overview).

For more information, please refer to [Monitor SAP on Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/monitor-sap-on-azure).

### Links

- [AMS Onboarding Guide](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/azure-monitor-sap-quickstart)
- [AMS FAQ](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/azure-monitor-faq)
- [Private preview: Root cause analysis, new telemetry, & alerts for SAP NetWeaver in AMS](https://azure.microsoft.com/en-us/updates/private-preview-root-cause-analysis-new-telemetry-for-sap-netweaver/)
- [Azure Monitor Log Analytics data export is in public preview](https://azure.microsoft.com/en-us/updates/azure-monitor-log-analytics-data-export-is-in-public-preview/)
- [SAP NetWeaver monitoring- Azure Monitoring for SAP Solutions](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/sap-netweaver-monitoring-azure-monitoring-for-sap-solutions/ba-p/2262721)
- [New features in AMS: Alerts, 'data-size' for SAP HANA, HA cluster (RHEL) and new NetWeaver telemetry](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/new-features-in-ams-alerts-data-size-for-sap-hana-ha-cluster/ba-p/2550708)
- [Using Azure Lighthouse and Azure Monitor for SAP Solutions to view telemetry across Multiple Tenants](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/using-azure-lighthouse-and-azure-monitor-for-sap-solutions-to/ba-p/1537293)
- [IT Service Management Connector Overview](https://docs.microsoft.com/en-us/azure/azure-monitor/alerts/itsmc-overview)
- [Public Preview of SAP NetWeaver, North Europe, OS, and new insights in Cluster Monitoring](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/public-preview-of-sap-netweaver-north-europe-os-and-new-insights/ba-p/2262975)
- [SUSE & Microsoft collaborates to provide SAP monitoring](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/suse-amp-microsoft-collaborates-to-provide-sap-monitoring/ba-p/1571926)
- [SUE Monitoring Capabilities](https://documentation.suse.com/sles-sap/15-SP2/html/SLES-SAP-sol-monitoring/art-sol-monitoring.html)
- [SAP on Azure Video Podcast - Update on Azure Monitor for SAP](https://www.youtube.com/watch?v=8GkISZgiuZg)

## Microsoft Sentinel Continuous Threat Monitoring for SAP

> [!IMPORTANT]
> The Microsoft Sentinel SAP solution is currently in PREVIEW

[Microsoft Sentinel solutions](https://docs.microsoft.com/en-us/azure/sentinel/sentinel-solutions) include bundled security content, such as threat detections, workbooks, and watchlists. With these solutions, you can onboard Microsoft Sentinel security content for a specific data connector by using a single process.

By using the Microsoft Sentinel SAP data connector, you can monitor SAP systems for sophisticated threats within the business and application layer. The data connector collects logs from Advanced Business Application Programming (ABAP) via NetWeaver RFC calls and from file storage data via OSSAP Control interface. The SAP data connector adds to the ability of Microsoft Sentinel to monitor the SAP underlying infrastructure.

Microsoft Sentinel provides you [SAP Solution security content](https://docs.microsoft.com/en-us/azure/sentinel/sap-solution-security-content) to gain insight into your organization's SAP environment and improve any related security operation capabilities.

Supported SAP versions. We recommend using [SAP_BASIS versions 750 SP13](https://support.sap.com/en/my-support/software-downloads/support-package-stacks/product-versions.html#:%7E:text=SAP%20NetWeaver%20%20%20%20SAP%20Product%20Version,%20%20SAPKB710%3Cxx%3E%20%207%20more%20rows) or later.
For more information, please refer to [Microsoft Sentinel for SAP](https://docs.microsoft.com/en-us/azure/sentinel/sap-deploy-solution)
