# Azure AD - Authorization

> **[prev](02-azuread.md) | [home](readme.md)  | [next](04-azuread-b2b.md)**

By using authorization features like [directory groups](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-manage-groups), [app roles](https://docs.microsoft.com/azure/architecture/multitenant-identity/app-roles) and other types of Role Based Access Control (for example, Azure RBAC), you can define exactly who has access to which applications and with which permissions.

> **DEMO - Authorization with App Roles**
>
> - On the Azure AD app registration, open the **App roles** page and create a new app role. For example, set the **Display name** to `Expense Approvers`, **Allowed member types** to **Users/Groups**, **Value** to `Expenses.Approve` and **Description** to `Can approve expenses`.
> - Back on the **Overview** page, click through to the **Managed application in local directory** (or navigate to the **Enterprise applications** page in Azure AD and find the app), go to the **Users and groups** page and assign the user that you've signed in with to the app role you just created.
> - Go back to **Authr**, go to **New Request** (which keeps all existing parameters) and click **Submit** again. You should now see a `roles` claim in the token containing the app role assigned to the user and which the application can use for authorization purposes.

> **[prev](02-azuread.md) | [home](readme.md)  | [next](04-azuread-b2b.md)**
