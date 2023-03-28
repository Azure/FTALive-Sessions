# What we see in the field at Fast Track for Azure

When working with customers, we often see the following:

- Customers who want to leverage Private Endpoints for security purposes, enable them, but fail to complete all of the required configuration.
- Customers who want to access Azure resources over their private network from their on-prem locations, but do not have a plan for managing DNS resolution for their Private Endpoints from on-prem.
- Customers who want to use Private Endpoints for inbound traffic to the services, but don't have a plan for how other services will interact, or how those same services will handle outbound traffic.
- When customers encounter issues configuring Private Endpoints, these issues can make them feel uncomfortable with the solution.
- In addition, customers who have challenge implementing a secure solution may feel like they have to implement a less secure solution in order to get unblocked.
- Customers who implement Private Endpoints without considering whether their security posture actually requires them, or if they can meet requirements combining public endpoints, traffic encryption, and strong authentication.

These are all scenarios that can be addressed, but being forewarned about how to adopt Private Endpoints for a workload can save a lot of effort.

>[!NOTE] - We aren't going to be talking about Private Link service - just focus on Private Endpoints.
