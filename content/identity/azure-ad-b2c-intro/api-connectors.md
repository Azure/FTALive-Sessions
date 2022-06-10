# API Connectors

#### [home](./readme.md) | [prev](./application-integration.md) | [next](./identity-experience-framework.md)

Allow you to integrate your user flows with REST APIs to customize the experience and integrate with external systems. Provides Azure AD B2C with the information needed to call an API endpoint by defining the HTTP endpoint URL and authentication for the API call. Once you configure an API connector, you can enable it for a specific step in a user flow. When a user reaches that step in the flow, the API connector is invoked.

## Scenarios for API Connectors

- Validate user input data
- Verify user identity
- Integrate with a custom approval workflow
- Augment tokens with data from external sources
- Reformat or assign a value to an attribute collected from a user
- Run custom business logic

## Where can you enable an API Connector?

- Sign Up
    - After federating with an identity provider
    - Before creating the user
    - Before sending the token
- Sign In
    - Before sending the token

## Sample API Connectors

Sample API Connectors can be found [here](https://github.com/azure-ad-b2c/api-connector-samples)
