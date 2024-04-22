# Introduction to SCOM Managed Instance

### [Previous](readme.md) | [Home](readme.md) | [Next](setup.md)

In this module, you will learn about SCOM Managed Instance (SCOM MI) and how it differs from SCOM.

## What is SCOM MI?

SCOM MI is a new deployment option for System Center Operations Manager (SCOM) that allows you to run SCOM in Azure. SCOM MI is a managed service that is fully managed by Microsoft. This means that Microsoft is responsible for the infrastructure, availability, and performance of the SCOM MI service. You are responsible for configuring and managing the SCOM MI service.

## Diagram

![alt text](image.png)

## Comparison of SCOM on-premises with SCOM MI

SCOM Managed Instance has all the capabilities of System Center Operations Manager on-premises in a cloud-native way.

Comparison of SCOM on-premises with SCOM Managed Instance:

<https://learn.microsoft.com/en-us/system-center/scom/operations-manager-managed-instance-overview?view=sc-om-2022#comparison-of-system-center-operations-manager-on-premises-with-scom-managed-instance>

## Features

### SCOM Managed Instance functionality allows you to:

- Configure an E2E System Center Operations Manager setup (SCOM Managed Instance) on Azure.
- Manage (view, delete) your SCOM Managed Instance in Azure.
Connect to your SCOM Managed Instance using the System Center Operations Manager Ops console.
- Monitor workloads (wherever they're located) using the Ops, and while using your existing management packs.
- Incur zero database maintenance (Ops database and Data warehouse database) because of the offloading of database management to SQL Managed Instance (SQL MI).
- Scale your instance immediately without the need to add/delete physical servers.
- View your SCOM Managed Instance reports in Power BI.
- Patch your instance in one click with the latest bug fixes and features.

## New Features

### Manage

- [Monitored Resources (preview)](https://learn.microsoft.com/en-us/system-center/scom/monitor-arc-enabled-vm-with-scom-managed-instance?view=sc-om-2022)

- [Managed Gateways (preview)]()

### Monitoring

- [Configure Log Analytics for Azure Monitor](https://learn.microsoft.com/en-us/system-center/scom/configure-log-analytics-for-scom-managed-instance?view=sc-om-2022)

- [SCOM Alerts in Azure Monitor](https://learn.microsoft.com/en-us/system-center/scom/view-operations-manager-alerts-azure-monitor?view=sc-om-2022)

- [Logs (preview)](https://learn.microsoft.com/en-us/system-center/scom/configure-log-analytics-for-scom-managed-instance?view=sc-om-2022#view-logs)

![alt text](image-2.png)

- [Workbooks (preview)]()

### Dashboards and Reporting

- [Create PowerBI Reports](https://learn.microsoft.com/en-us/system-center/scom/operations-manager-managed-instance-create-reports-on-power-bi?view=sc-om-2022)

- [Microsoft SCOM Managed Instance Reports](https://appsource.microsoft.com/en-us/product/power-bi/microsoftcorporation1664440972680.9c257347-1dd6-4440-ab56-4392609cd1c8)

- [Grafana Dashboards](https://learn.microsoft.com/en-us/system-center/scom/dashboards-on-azure-managed-grafana?view=sc-om-2022)

- [Query SCOM MI from Grafana Dashboards](https://learn.microsoft.com/en-us/system-center/scom/query-scom-managed-instance-data-on-grafana?view=sc-om-2022)

Note: Grafana is still in preview

## Pricing and Benefits

- [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/details/monitor/)
- [Key Benefits](https://learn.microsoft.com/en-us/system-center/scom/operations-manager-managed-instance-overview?view=sc-om-2022#key-benefits)
- [Benefits and Cost Breakdown](https://techcommunity.microsoft.com/t5/system-center-blog/benefits-of-moving-to-azure-monitor-scom-managed-instance/ba-p/4057882)

#

### [Previous](readme.md) | [Home](readme.md) | [Next](setup.md)
