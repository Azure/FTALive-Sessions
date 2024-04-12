# SCOM MI Agents

## Directly connected agents

Directly connected agent from Azure or on-prem required direct line of sight to the management server. You can deploy the agent from the Azure Portal in SCOM MI and the Monitored Resources page.

## Gateway Agents

Gateway agents are to be configures the same way they were when it was SCOM on-prem. They will need line of sight to the Gateway server for connectivity with the relevant ports to be opened.

The agents that are installed with the use of a Gateway Server can be configured with a certificate or if they are domain joined, then kerberos can be used.
