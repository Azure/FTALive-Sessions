# Customer Identity Access Management with Azure AD B2C

> **[prev](11-external-identities-scenario.md) | [home](readme.md)  | next**

Since most people will likely be at least somewhat familiar with Azure AD, let's focus a bit more on Azure AD B2C specifically. An Azure AD B2C directory is completely separate from your organizational Azure AD directory (but built on the same underlying global platform). There are several high-level concepts that are important in an Azure AD B2C deployment, as you can see in the most important pages in the Azure Portal experience:

- **App registrations**: Similar to Azure AD, you have to register your applications in order for the directory to issue tokens to them.
- **Identity providers**: You can select which external IdP's a user can sign in with (social and enterprise identities) and which authentication methods can be used for "local" accounts (username, email or phone number).
- **User attributes**: You can define additional information about users that you want to store within the directory itself; note that B2C isn't intended to be used as a CRM system but can store important identity-related information which users can be allowed to modify (through a profile editing policy).
- **User flows**: Azure AD B2C provides pre-built policies called *user flows* which allow you to easily configure sign-up, sign-in, profile editing and password reset capabilities.
- **API Connectors**: Built-in user flows expose certain extensibility points which allow you to inject custom logic as a REST API call.
- **Identity Experience Framework**: When the built-in user flows don't do exactly what you need, you can create *custom policies* which puts you in complete control of the user journey.

> **DEMO - Azure AD B2C**
>
> - Navigate to your Azure AD B2C directory in the Azure Portal and **walk through the top-level pages** mentioned above (feel free to skip API Connectors and Identity Experience Framework though as these are more advanced).
> - Create a **new combined sign-up and sign-in user flow**.
> - Open the **Properties** page where you can easily enable Multi-Factor Authentication (and even Conditional Access).
> - Open the **Identity providers** page where you can configure different user flows with different IdP's, for example to allow social identities for some scenarios but not for others.
> - Open the **User attributes** page where you define which information is captured from a user during sign-up.
> - Open the **Application claims** page where you select the attributes that will be emitted into the token that gets sent towards the application.
> - Open the **Page layouts** page where you can completely customize the HTML, CSS and JavaScript for each page.
> - Click **Run user flow** to easily try out any changes to the user flow directly from the Azure Portal, even without building any application (for example, by using [https://jwt.ms](https://jwt.ms) or [https://authr.biz](https://authr.biz) so that you see the claims issued in the token).

In real-world scenarios there are likely requirements that cannot be met with out-of-the-box functionality in Azure AD B2C, which is why it's important to know that there are a few levels of customization such as *HTML, CSS and JavaScript* to customize what happens on the actual pages hosted by Azure AD B2C, *API Connectors* to call external REST API's to influence user flows, and finally *custom policies* to take full control (at the cost of considerable complexity).

- One very common requirement is to **allow only pre-identified users to sign up**, which is demonstrated in the [Delegated User Management sample](https://github.com/azure-ad-b2c/api-connector-samples/tree/main/InvitationCodeDelegatedUserManagement).
- Another typical scenario (as it's built-in with Azure AD but not in Azure AD B2C) is to use B2C not only for authentication but also for **authorization**, which is demonstrated in the [App Roles sample](https://github.com/azure-ad-b2c/api-connector-samples/tree/main/Authorization-AppRoles) (with extensive guidance on alternative approaches).
- Finally, it's worth calling out that there is a large collection of **[custom policy samples](https://github.com/azure-ad-b2c/samples)** which covers many other requirements that real-world implementations may require.

> **[prev](11-external-identities-scenario.md) | [home](readme.md)  | next**
