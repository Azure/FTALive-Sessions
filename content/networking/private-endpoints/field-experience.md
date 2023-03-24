# What we see in the field at Fast Track for Azure

When working with customers, we often see the following:

- Customers who want to leverage Private Endpoints for security purposes, enable them, but find that they do not operate without additional configuration.
- Customers who want to access Azure resources over their private network from their on-prem locations, but do not have a plan for managing DNS resolution from on-prem.
- Customers who want to use Private Endpoint for inbound traffic to the services, but don't have a plan for how other services will interact, or how those same services will handle outbound traffic.
- When customers encounter issues with Private Endpoints, these issues can make them feel uncomfortable with the solution.
- In addition, customers who have challenge implementing a secure solution may feel like they have to implement a less secure solution in order to get unblocked.

These are all scenarios that can be addressed, but being forewarned about how to adopt Private Endpoints for a workload can save a lot of effort.

## The Difference between Private Link and Private Endpoints

Sometimes it can be confusing to navigate the relationship between the Private Link and Private Endpoint services, and so customer organizations can be unsure about what they need to set up.  To help clarify:

- Private Link is a broad service that allows for private connectivity.
- You can go to the Private Link Center to manage both Private Endpoints, Private Link Services, and Azure Arc and Azure Monitor private link scopes.
- Private Endpoints are connections in to Private Links for resources.
- You use a Private Endpoint to connect to a service from your virtual network.
- You create a Private Link to enable others to connect to your service from their virtual networks via a Private Endpoint
- Having a Private Link lets others make Private Endpoints.
- To give access to an Azure service, like a Storage Account, you generally only need a Private Endpoint.  The "Private Link Service" is provided on the Azure management side and is backed in to the service.

>!NOTE - We aren't going to be talking about Private Link service - just focus on Private Endpoints.
