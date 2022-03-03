# Microsoft Identity Platform

## Overview

In this session you will learn about the different offerings available in the Microsoft Identity Platform to help you integrate your solutions with a modern cloud-scale identity platform. We will discuss **Azure AD** (for both single-tenant and multi-tenant apps), **Azure AD B2B** for guest user access and **Azure AD B2C** for Customer Identity Access Management (CIAM). We will discuss how they are similar, where they are different, and when to choose which.

### Agenda

- [Overview of identity offerings](01-identity-offerings-overview.md)
  - [Azure AD](02-azuread.md)
  - [Azure AD B2B Guest User Access](04-azuread-b2b.md)
  - [Azure AD Multi-Tenant Apps](05-azuread-multitenant.md)
  - [Azure AD B2C](06-azuread-b2c.md)
- [Choosing the appropriate offering](10-identity-offerings-choice.md)
- [Real-world scenario with external identities](11-external-identities-scenario.md)
- [Customer Identity Access Management with Azure AD B2C](12-ciam-b2c.md)

### Audience

This session is mostly useful for identity architects and developers who want to integrate their solutions with the Microsoft Identity Platform to allow organizational users as well as external identities to sign in to their custom developed applications.

### Goals

In this session you will learn how to:

- Compare the different identity offerings.
- Choose which identity offering is most appropriate for your requirements.
- Integrate your applications with Azure AD and Azure AD B2C.

## Resources

Please find the most relevant resources below to continue your learning after this session.

### Help Me Choose

- [What is Azure Active Directory?](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-whatis)
- [What are External Identities in Azure Active Directory?](https://docs.microsoft.com/azure/active-directory/external-identities/compare-with-b2c)
- [What is guest user access in Azure Active Directory B2B?](https://docs.microsoft.com/azure/active-directory/external-identities/what-is-b2b)
- [What is Azure Active Directory B2C?](https://docs.microsoft.com/azure/active-directory-b2c/active-directory-b2c-overview)
- [Azure Active Directory External Identities Decision Tree](https://github.com/Azure/fta-identity/blob/master/identity-applications/aad-external-identities-decision-tree.md)
- [Azure Active Directory pricing](https://azure.microsoft.com/pricing/details/active-directory/)
- [Azure Active Directory External Identities pricing](https://azure.microsoft.com/pricing/details/active-directory/external-identities/)
- [Compare self-managed Active Directory Domain Services, Azure Active Directory, and managed Azure Active Directory Domain Services](https://docs.microsoft.com/azure/active-directory-domain-services/compare-identity-solutions)

### Help Me Architect

Azure AD:

- [What is the Microsoft identity platform?](https://docs.microsoft.com/azure/active-directory/develop/v2-overview)
- [Tenancy in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/develop/single-and-multi-tenant-apps)
- [Enhance security with the principle of least privilege](https://docs.microsoft.com/azure/active-directory/develop/secure-least-privileged-access)
- [Azure AD App Roles](https://docs.microsoft.com/azure/architecture/multitenant-identity/app-roles)
- [Building resilience into identity and access management with Azure Active Directory](https://aka.ms/AzureADresilience)
- [Security Controls: Identity Management](https://docs.microsoft.com/security/benchmark/azure/security-controls-v2-identity-management)

Azure AD multi-tenant applications:

- [Sign in any Azure Active Directory user using the multi-tenant application pattern](https://docs.microsoft.com/azure/active-directory/develop/howto-convert-app-to-be-multi-tenant)
- [Identity management in multi-tenant applications](https://docs.microsoft.com/azure/architecture/multitenant-identity/)

Azure AD B2C:

- [Woodgrove Groceries demo environment](https://aka.ms/CIAMDemo)
- [Sample custom policies](https://github.com/azure-ad-b2c/samples)
- [Sample API connectors](https://github.com/azure-ad-b2c/api-connector-samples)
- [Authorization in Azure AD B2C](https://github.com/azure-ad-b2c/api-connector-samples/tree/main/Authorization-AppRoles)
- [Solutions and Training for Azure Active Directory B2C](https://aka.ms/aadb2csolutions)

### Help Me Deploy

- [Microsoft identity platform code samples](https://docs.microsoft.com/azure/active-directory/develop/sample-v2-code)
- [Microsoft identity platform best practices and recommendations](https://docs.microsoft.com/azure/active-directory/develop/identity-platform-integration-checklist)
- [Azure AD application registration security best practices](https://docs.microsoft.com/azure/active-directory/develop/security-best-practices-for-app-registration)
- [Graph API for Azure AD](https://docs.microsoft.com/graph/azuread-identity-access-management-concept-overview)
