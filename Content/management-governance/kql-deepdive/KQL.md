# Getting started with KQL

We took some time to explore constructing KQL queries, herewith more about the basic operators you may use:

*   [where operator in Kusto query language - Azure Data Explorer | Microsoft Docs](https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/whereoperator)
*   [summarize operator - Azure Data Explorer | Microsoft Docs](https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/summarizeoperator)
*   [render operator - Azure Data Explorer | Microsoft Docs](https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/renderoperator?pivots=azuremonitor)
*   [count operator - Azure Data Explorer | Microsoft Docs](https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/countoperator)
*   [parse operator - Azure Data Explorer | Microsoft Docs](https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/parseoperator)
*   [between operator - Azure Data Explorer | Microsoft Docs](https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/betweenoperator)
*   [The datetime data type - Azure Data Explorer | Microsoft Docs](https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/scalar-data-types/datetime)
*   [join operator - Azure Data Explorer | Microsoft Docs](https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/joinoperator?pivots=azuremonitor)

## Sample queries

List a table

        AzureActivity
        | count 

See what is in the table

        AzureActivity
        | take 10


Now, let's filter this query a bit more

        AzureActivity
        | where Level == "Error"

Multiple conditions

        AzureActivity
        | where CategoryValue == "Administrative"
        | where ActivityStatusValue == "Success"


Now, let's add a date filter to this query

        AzureActivity
        | where TimeGenerated > ago(2d) and TimeGenerated < ago(1h)
        | where Level == 'Critical'

Use summarise for exploration:

        AzureActivity
        | summarize by Level


Join:

        SecurityEvent 
        | where EventID == 4624		// sign-in events
        | project Computer, Account, TargetLogonId, LogonTime=TimeGenerated
        | join kind= inner (
        SecurityEvent 
        | where EventID == 4634		// sign-out events
        | project TargetLogonId, LogoffTime=TimeGenerated
            ) on TargetLogonId
        | extend Duration = LogoffTime-LogonTime
        | project-away TargetLogonId1 
        | top 10 by Duration desc


Parsing:

        Syslog 
        | where Facility == "authpriv"
        | parse SyslogMessage with * "(" session "):" * "user" UserName


Performance data with chart:

        Perf
        | where ObjectName == "LogicalDisk"
        | where InstanceName == "C:"
        | summarize AggregatedValue = avg(CounterValue) by Computer, InstanceName, bin(TimeGenerated, 1d) 
        | render timechart 



## Additional learning resources:

*   [Log Analytics tutorial - Azure Monitor | Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-tutorial)
*   [Query best practices - Azure Data Explorer | Microsoft Docs](https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/best-practices)
*   [Keyboard shortcuts in the Azure portal for Azure Resource Graph Explorer - Azure Resource Graph | Microsoft Docs](https://docs.microsoft.com/en-us/azure/governance/resource-graph/reference/keyboard-shortcuts) < this works in the Log Analytics query interface as well
*   [Log Analytics in Azure Monitor offers sets of example queries that you can run on their own or use as a starting point for your own queries. - Azure Monitor | Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/example-queries)
*   [Starter query samples - Azure Resource Graph | Microsoft Docs](https://docs.microsoft.com/en-us/azure/governance/resource-graph/samples/starter?tabs=azure-cli)
*   [Advanced query samples - Azure Resource Graph | Microsoft Docs](https://docs.microsoft.com/en-us/azure/governance/resource-graph/samples/advanced?tabs=azure-cli)
*   [Query across resources with Azure Monitor - Azure Monitor | Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/cross-workspace-query)