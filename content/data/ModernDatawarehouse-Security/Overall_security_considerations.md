## Overall Security considerations

#### Security

[<Back](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/MDW.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/ADLS%20Security.md)

#### Least Privilege user

The information security principle of least privilege asserts that users and applications should be granted access only to the data and operations they require to perform their jobs.

- Prevent **overprivileged** applications by revoking *unused* and *reducible* permissions.

- Use the identity platform's **consent** framework to require that a human consent to the request from the application to access protected data.

- **Build** applications with least privilege in mind during all stages of development

  

#### AAD

  ##### AAD security Groups 

  Azure Active Directory (Azure AD) provides several ways to manage access to resources, applications, and tasks. With Azure AD groups, you can grant access and permissions to a group of users instead of for each individual user. 

  Azure Synapse Workspace supports managed identities for its Azure resources. Use managed identities with Azure Synapse Workspace instead of creating service principals to access other resources. Azure Synapse Workspace can natively authenticate to the Azure services/resources that supports Azure AD authentication through a pre-defined access grant rule without using credentials hard coded in source code or configuration files.

  ##### What are Managed identities?

  ·    **System-assigned**. Some Azure services allow you to enable a managed identity directly on a service instance. When you enable a system-assigned managed identity, an identity is created in Azure AD. The identity is tied to the lifecycle of that service instance.

  ·    **User-assigned**. You may also create a managed identity as a standalone Azure resource. You can [create a user-assigned managed identity](https://learn.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/how-to-manage-ua-identity-portal) and assign it to one or more instances of an Azure service. For user-assigned managed identities, the identity is managed separately from the resources that use it.

  ###### MFA

  Azure AD Multi-Factor Authentication works by requiring two or more of the following authentication methods:

      Something you know, typically a password.

      Something you have, such as a trusted device that's not easily duplicated, like a phone or hardware key.

      Something you are - biometrics like a fingerprint or face scan.

  Azure AD Multi-Factor Authentication can also further secure password reset. When users register themselves for Azure AD Multi-Factor Authentication, they can also register for self-service password reset in one step. Administrators can choose forms of secondary authentication and configure challenges for MFA based on configuration decisions.
  You can use security defaults in Azure AD tenants to quickly enable Microsoft Authenticator for all users. You can enable Azure AD Multi-Factor Authentication to prompt users and groups for additional verification during sign-in.

#### Azure Policies

[Azure Policy](https://docs.microsoft.com/azure/governance/policy/overview?WT.mc_id=itopstalk-blog-phschmit) is a service in Azure which allows you create polices which enforce and control the properties of a resource. When these policies are used they enforce different rules and effects over your resources, so those resources stay compliant with your IT governance standards.

To summarize, Azure policy is basically 3 components; policy definition , assignment and parameters.

##### Azure Policy and Azure RBAC

There are a few key differences between Azure Policy and Azure role-based access control (Azure RBAC). Azure Policy evaluates state by examining properties on resources that are represented in Resource Manager and properties of some Resource Providers. Azure Policy ensures that resource state is compliant to your business rules without concern for who made the change or who has permission to make a change. Azure Policy through DenyAction effect can also block certain actions on resources. Some Azure Policy resources, such as [policy definitions](https://learn.microsoft.com/en-us/azure/governance/policy/overview#policy-definition), [initiative definitions](https://learn.microsoft.com/en-us/azure/governance/policy/overview#initiative-definition), and [assignments](https://learn.microsoft.com/en-us/azure/governance/policy/overview#assignments), are visible to all users. This design enables transparency to all users and services for what policy rules are set in their environment.

Azure RBAC focuses on managing user [actions](https://learn.microsoft.com/en-us/azure/role-based-access-control/resource-provider-operations) at different scopes. If control of an action is required based on user information, then Azure RBAC is the correct tool to use. Even if an individual has access to perform an action, if the result is a non-compliant resource, Azure Policy still blocks the create or update.

The combination of Azure RBAC and Azure Policy provides full scope control in Azure.

#### Environments

Use the [Continuous Delivery](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/considerations/development-strategy-development-lifecycle#deployment-strategy) process to quickly and safely delivers new value to production. You can deliver small changes frequently, which reduces the risk of problems.

Other factors affect "deployment pain to production", including your adoption of multiple delivery/deployment environments. A multienvironment approach lets you build, test, and release code with greater speed and frequency to make your deployment as straightforward as possible. You can remove manual overhead and the risk of a manual release, and instead automate development with a multistage process targeting different environments.

A common multienvironment architecture includes four tiers:

- Development
- Test
- Staging
- Production

In this architecture, your product transitions in order from Development (the environment where you develop changes to the software) through Production (the environment your users directly interact with). You might also introduce a User Acceptance Test (UAT) environment to validate end-to-end business flow.

| Environment | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| Development | Your development environment (dev) is where changes to software are developed. |
| Test        | Your test environment allows either human testers or automated tests to try out new and updated code. Developers must accept new code and configurations through unit testing in your development environment before allowing those items to enter one or more test environments. |
| Staging     | Staging is where you do final testing immediately prior to deploying to production. Each staging environment should mirror an actual production environment as accurately as possible. |
| UAT         | User Acceptance Testing (UAT) allows your end-users or clients to perform tests to verify/accept the software system before a software application can move to your production environment. |
| Production  | Your production environment (production), sometimes called *live*, is the environment your users directly interact with. |



#### References

[Environments - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/considerations/environments)

[Testing approach for Azure landing zones - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach)

[Learn about groups and group membership - Azure Active Directory - Microsoft Entra | Microsoft Learn](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/concept-learn-about-groups)

[Increase application security with the principle of least privilege - Microsoft Entra | Microsoft Learn](https://learn.microsoft.com/en-us/azure/active-directory/develop/secure-least-privileged-access)

[Secure access control using groups in Azure AD - Microsoft Entra | Microsoft Learn](https://learn.microsoft.com/en-us/azure/active-directory/develop/secure-group-access-control)

[Azure Policy Initiatives vs Azure Policies: When should I use one over the other? (microsoft.com)](https://techcommunity.microsoft.com/t5/itops-talk-blog/azure-policy-initiatives-vs-azure-policies-when-should-i-use-one/ba-p/1229167#:~:text=What%20is%20an%20Azure%20Policy%3F%201%20Policy%20definition,number%20of%20policy%20definitions%20you%20must%20create.%20 )

[Overview of Azure Policy - Azure Policy | Microsoft Learn](https://learn.microsoft.com/en-us/azure/governance/policy/overview)

[Development lifecycle - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/considerations/development-strategy-development-lifecycle#deployment-strategy)

[Landing Zone | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/)

[MFA | Microsoft Learn](https://learn.microsoft.com/en-us/azure/active-directory/authentication/concept-mfa-howitworks)

[Using MFA | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-mfa-ssms-overview?source=recommendations&view=azuresql)
