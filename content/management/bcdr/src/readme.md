# Demo setup
Scenario created by the demo scripts:
- Source Resource group containing:
  - two CentOS VMs
  - a virtual network with a 'Servers' subnet
  - A recovery service vault
- Target Resource Group containing
    - target Vnet

## Configuration
- Install pre-requisites, including [Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install#manual-with-powershell)
- Review & Edit setup.ps1 and change as required

## Setup

The setup.ps1 file will:
- Deploy the items above.
- Protect (replicate) vm1
