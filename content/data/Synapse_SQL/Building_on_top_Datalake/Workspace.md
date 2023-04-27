## Workspace 


[<Back](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/Building_on_top_Datalake/Storage.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/Building_on_top_Datalake/Network.md)


#### Workspace Encryption

Workspaces can be configured to enable double encryption with a customer-managed key at the time of workspace creation. Enable double encryption using a customer-managed key on the "Security" tab when **creating** your new workspace. You can choose to enter a key identifier URI or select from a list of key vaults in the same region as the workspace. The Key Vault itself needs to have purge protection enabled.

<img width="528" alt="image" src="https://user-images.githubusercontent.com/62876278/218741629-b6bba426-a124-4656-8205-57125cb1f2d7.png">


#### Workspace permissions

Azure Synapse Workspace is integrated with Azure role-based access control (Azure RBAC) to manage its resources. Azure RBAC allows you to manage Azure resource access through role assignments. You can assign these roles to users, groups service principals, and **managed identities**. Use built-in roles to allocate permissions and only create custom roles when required.

![image](https://user-images.githubusercontent.com/62876278/208107285-857a14c3-f5db-4ef7-9540-c1ace1024691.png)


Azure Synapse Analytics requires users in Azure Owner or Azure Contributor roles at the resource-group to control management of its dedicated SQL pools, Spark pools, and Integration runtimes. In addition to this, users and the workspace system-identity must be granted Storage Blob Data Contributor access to the ADLS Gen2 storage container associated with the Synapse workspace.


### Security RBAC

#### Access Synapse Studio

You can open Synapse Studio and view details of the workspace and list any of its Azure resources such as SQL pools, Spark pools, or Integration runtimes. You will see if you've been assigned any Synapse RBAC role or have the Azure Owner, Contributor, or Reader role on the workspace.

![image](https://user-images.githubusercontent.com/62876278/208107151-76be8069-8834-4536-8c80-4a2e7d5c128b.png)


### Resource management

You can create SQL pools, Data Explorer pools, Apache Spark pools, and Integration runtimes if you're an Azure Owner or Contributor on the workspace. When using ARM templates for automated deployment, you need to be an Azure Contributor on the resource group.

You can pause or scale a dedicated SQL pool, configure a Spark pool, or an integration runtime if you're an Azure Owner or Contributor on the workspace or that resource.

#### Access Control

Suggestion: You can create a basic group and add your members at the same time using the Azure Active Directory (Azure AD) portal and add permissions as applied,  you will use the following [Access control in Synapse workspace how to - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/how-to-set-up-access-control) and [How to manage groups - Azure Active Directory - Microsoft Entra | Microsoft Learn](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/how-to-manage-groups):

- **Security Groups**, to group users with similar access requirements.
- **Azure roles**, to control who can create and manage SQL pools, Apache Spark pools and Integration runtimes, and access ADLS Gen2 storage.
- **Synapse roles**, to control access to published code artifacts, use of Apache Spark compute resources and integration runtimes.
- **SQL permissions**, to control administrative and data plane access to SQL pools.
- **Git permissions**, to control who can access code artifacts in source control if you configure Git-support for workspaces.

### View and edit code artifacts

With access to Synapse Studio, you can create new code artifacts, such as SQL scripts, KQL scripts, notebooks, spark jobs, linked services, pipelines, dataflows, triggers, and credentials. These artifacts can be published or saved with additional permissions.

If you're a Synapse Artifact User, Synapse Artifact Publisher, Synapse Contributor, or Synapse Administrator you can list, open, and edit already published code artifacts.

### Execute your code

You can execute SQL scripts on SQL pools if you have the necessary SQL permissions defined in the SQL pools. You can execute KQL scripts on Data Explorer pools if you have the necessary permissions.

You can run notebooks and Spark jobs if you have Synapse Compute Operator permissions on the workspace or specific Apache Spark pools.

With Compute Operator permissions on the workspace or specific integration runtimes, and appropriate credential permissions you can execute pipelines.

### Monitor and manage execution

You can review the status of running notebooks and jobs in Apache Spark pools if you're a Synapse User.

You can review logs and cancel running jobs and pipelines if you're a Synapse Compute Operator at the workspace or for a specific Spark pool or pipeline.

### Debug pipelines

You can review and make changes in pipelines as a Synapse User, but if you want to be able to debug it you also need to have Synapse Credential User.

### Publish and save your code

You can publish new or updated code artifacts to the service if you're a Synapse Artifact Publisher, Synapse Contributor, or Synapse Administrator.

You can commit code artifacts to a working branch of a Git repository if the workspace is Git-enabled and you have Git permissions. With Git enabled, publishing is only allowed from the collaboration branch.

If you close Synapse Studio without publishing or committing changes to code artifacts, then those changes will be lost.

## Tasks and required roles

The table below lists common tasks and for each task, the Synapse RBAC, or Azure RBAC roles required.

 Note

Synapse Administrator is not listed for each task unless it is the only role that provides the necessary permission. A Synapse Administrator can perform all tasks enabled by other Synapse RBAC roles.

 Note

Guest users from another tenant are also able to review, add, or change role assignments once they have been assigned as Synapse Administrator.


#### Synapse role-based access control
Azure Synapse also includes Synapse role-based access control (RBAC) roles to manage different aspects of Synapse Studio. Leverage these built-in roles to assign permissions to users, groups, or other security principals to manage who can:

        Publish code artifacts and list or access published code artifacts.
        Execute code on Apache Spark pools and integration runtimes.
        Access linked (data) services that are protected by credentials.
        Monitor or cancel job executions, review job output and execution logs.


The minimum Synapse RBAC role required is shown.

All Synapse RBAC roles at any scope provide you Synapse User permissions at the workspace.

All Synapse RBAC permissions/actions shown in the table are prefixed `Microsoft/Synapse/workspaces/...`.

| Task (I want to...)                                          | Role (I need to be...)                                       | Synapse RBAC permission/action                               |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Open Synapse Studio on a workspace                           | Synapse User or                                              | read                                                         |
|                                                              | Azure Owner or Contributor, or Reader on the workspace       | none                                                         |
| List SQL pools or Data Explorer pools or Apache Spark pools, or Integration runtimes and access their configuration details | Synapse User or                                              | read                                                         |
|                                                              | Azure Owner or Contributor, or Reader on the workspace       | none                                                         |
| List linked services or credentials or managed private endpoints | Synapse User                                                 | read                                                         |
| SQL POOLS                                                    |                                                              |                                                              |
| Create a dedicated SQL pool or a serverless SQL pool         | Azure Owner or Contributor on the workspace                  | none                                                         |
| Manage (pause or scale, or delete) a dedicated SQL pool      | Azure Owner or Contributor on the SQL pool or workspace      | none                                                         |
| Create a SQL script                                          | Synapse User or Azure Owner or Contributor on the workspace.  *Additional SQL permissions are required to run a SQL script, publish, or commit changes*. |                                                              |
| List and open any published SQL script                       | Synapse Artifact User or Artifact Publisher, or Synapse Contributor | artifacts/read                                               |
| Run a SQL script on a serverless SQL pool                    | SQL permissions on the pool (granted automatically to a Synapse Administrator) | none                                                         |
| Run a SQL script on a dedicated SQL pool                     | SQL permissions on the pool (granted automatically to a Synapse Administrator) | none                                                         |
| Publish a new or updated, or deleted SQL script              | Synapse Artifact Publisher or Synapse Contributor            | sqlScripts/write, delete                                     |
| Commit changes to a SQL script to the Git repo               | Requires Git permissions on the repo                         |                                                              |
| Assign Active Directory Admin on the workspace (via workspace properties in the Azure Portal) | Azure Owner or Contributor on the workspace                  |                                                              |
| DATA EXPLORER POOLS                                          |                                                              |                                                              |
| Create a Data Explorer pool                                  | Azure Owner or Contributor on the workspace                  | none                                                         |
| Manage (pause or scale, or delete) a Data Explorer pool      | Azure Owner or Contributor on the Data Explorer pool or workspace | none                                                         |
| Create a KQL script                                          | Synapse User.  *Additional Data Explorer permissions are required to run a script, publish, or commit changes*. |                                                              |
| List and open any published KQL script                       | Synapse Artifact User or Artifact Publisher, or Synapse Contributor | artifacts/read                                               |
| Run a KQL script on a Data Explorer pool                     | Data Explorer permissions on the pool (granted automatically to a Synapse Administrator) | none                                                         |
| Publish new, update, or delete KQL script                    | Synapse Artifact Publisher or Synapse Contributor            | kqlScripts/write, delete                                     |
| Commit changes to a KQL script to the Git repo               | Requires Git permissions on the repo                         |                                                              |
| APACHE SPARK POOLS                                           |                                                              |                                                              |
| Create an Apache Spark pool                                  | Azure Owner or Contributor on the workspace                  |                                                              |
| Monitor Apache Spark applications                            | Synapse User                                                 | read                                                         |
| View the logs for completed notebook and job execution       | Synapse Monitoring Operator                                  |                                                              |
| Cancel any notebook or Spark job running on an Apache Spark pool | Synapse Compute Operator on the Apache Spark pool.           | bigDataPools/useCompute                                      |
| Create a notebook or job definition                          | Synapse User or Azure Owner or Contributor, or Reader on the workspace  *Additional permissions are required to run, publish, or commit changes* | read                                                         |
| List and open a published notebook or job definition, including reviewing saved outputs | Synapse Artifact User or Synapse Monitoring Operator on the workspace | artifacts/read                                               |
| Run a notebook and review its output, or submit a Spark job  | Synapse Apache Spark Administrator or Synapse Compute Operator on the selected Apache Spark pool | bigDataPools/useCompute                                      |
| Publish or delete a notebook or job definition (including output) to the service | Artifact Publisher on the workspace or Synapse Apache Spark Administrator | notebooks/write, delete                                      |
| Commit changes to a notebook or job definition to the Git repo | Git permissions                                              | none                                                         |
| PIPELINES, INTEGRATION RUNTIMES, DATAFLOWS, DATASETS & TRIGGERS |                                                              |                                                              |
| Create, update, or delete an Integration runtime             | Azure Owner or Contributor on the workspace                  |                                                              |
| Monitor Integration runtime status                           | Synapse Monitoring Operator                                  | read, integrationRuntimes/viewLogs                           |
| Review pipeline runs                                         | Synapse Monitoring Operator                                  | read, pipelines/viewOutputs                                  |
| Create a pipeline                                            | Synapse User  *Additional Synapse permissions are required to debug, add triggers, publish, or commit changes* | read                                                         |
| Create a dataflow or dataset                                 | Synapse User  *Additional Synapse permissions are required to publish, or commit changes* | read                                                         |
| List and open a published pipeline                           | Synapse Artifact User or Synapse Monitoring Operator         | artifacts/read                                               |
| Preview dataset data                                         | Synapse User and Synapse Credential User on the WorkspaceSystemIdentity |                                                              |
| Debug a pipeline using the default Integration runtime       | Synapse User and Synapse Credential User on the WorkspaceSystemIdentity credential | read, credentials/useSecret                                  |
| Create a trigger, including trigger now (requires permission to execute the pipeline) | Synapse User and Synapse Credential User on the WorkspaceSystemIdentity | read, credentials/useSecret/action                           |
| Execute/run a pipeline                                       | Synapse User and Synapse Credential User on the WorkspaceSystemIdentity | read, credentials/useSecret/action                           |
| Copy data using the Copy Data tool                           | Synapse User and Synapse Credential User on the Workspace System Identity | read, credentials/useSecret/action                           |
| Ingest data (using a schedule)                               | Synapse Author and Synapse Credential User on the Workspace System Identity | read, credentials/useSecret/action                           |
| Publish a new, updated, or deleted pipeline, dataflow, or trigger to the service | Synapse Artifact Publisher on the workspace                  | pipelines/write, delete dataflows/write, delete triggers/write, delete |
| Commit changes to pipelines, dataflows, datasets, or triggers to the Git repo | Git permissions                                              | none                                                         |
| LINKED SERVICES                                              |                                                              |                                                              |
| Create a linked service (includes assigning a credential)    | Synapse User  *Additional permissions are required to use a linked service with credentials, or to publish, or commit changes* | read                                                         |
| List and open a published linked service                     | Synapse Artifact User                                        | linkedServices/write, delete                                 |
| Test connection on a linked service secured by a credential  | Synapse User and Synapse Credential User                     | credentials/useSecret/action                                 |
| Publish a linked service                                     | Synapse Artifact Publisher or Synapse Linked Data Manager    | linkedServices/write, delete                                 |
| Commit linked service definitions to the Git repo            | Git permissions                                              | none                                                         |
| ACCESS MANAGEMENT                                            |                                                              |                                                              |
| Review Synapse RBAC role assignments at any scope            | Synapse User                                                 | read                                                         |
| Assign and remove Synapse RBAC role assignments for users, groups, and service principals | Synapse Administrator at the workspace or at a specific workspace item scope | roleAssignments/write, delete                                |




#### Reference

[Understand the roles required to perform common tasks in Azure Synapse - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/synapse-workspace-understand-what-role-you-need)

[How to review Azure Synapse RBAC role assignments in Synapse Studio - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/how-to-review-synapse-rbac-role-assignments)

[Access control in Synapse workspace how to - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/how-to-set-up-access-control)

[How to manage groups - Azure Active Directory - Microsoft Entra | Microsoft Learn](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/how-to-manage-groups)

[Workspace Encryption | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/workspaces-encryption)

