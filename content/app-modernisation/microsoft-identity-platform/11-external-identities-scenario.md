# Real-world scenario with external identities

> **[prev](10-identity-offerings-choice.md) | [home](readme.md)  | [next](12-ciam-b2c.md)**

If possible, an application should only have to trust a single Identity Provider so that the complexity of authentication and authorization is externalized and the required configuration in the application remains relatively simple. However, real-world use cases may involve multiple integrations where Azure AD is used for the organization's own employees, B2B guest users in the same directory are used for business partners, Azure AD B2C with local or social accounts are used for end customers, and the same Azure AD B2C with enterprise federation is used for business customers.

> **DEMO - Woodgrove External Identities**
>
> - Open the **[Woodgrove CIAM demo](https://aka.ms/CIAMDemo)** web application. Optionally, use the [configuration page](https://aka.ms/CIAMDemoConfig) to change the industry or other options.
> - Go to the **Sign In** page and note the various ways this application is able to sign in users:
>   - **Individual customers**: This uses Azure AD B2C for a fully branded experience that looks like an integral part of the web app; depending on [configuration](https://aka.ms/CIAMDemoConfig) users can sign in with "local" (using an email address or phone number) or "social" accounts.
>   - **Business customers**: This still uses Azure AD B2C (as it is for *end customers that happen to belong to an organization*) which is set up with federation towards multi-tenant Azure AD; this allows business customers to sign in with their existing work account.
>   - **Partners**: This uses the Woodgrove organizational Azure AD directory (not the Azure AD B2C directory used above) to allow Woodgrove employees to sign in, as well as collaboration partners to sign up and sign in using Azure AD B2B guest user access.
> - **Open the sign-up or sign-in experience for each of these options**, but there's no need to actually go through it fully. The point is that a single web app can have a range of options for end users to sign up and/or in, and these can all be delivered through Azure AD and Azure AD B2C.

> **[prev](10-identity-offerings-choice.md) | [home](readme.md)  | [next](12-ciam-b2c.md)**
