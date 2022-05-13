# Demo setup
Scenario created by the demo scripts:
- Source Resource group containing:
  - two CentOS VMs
  - a virtual network with a 'Servers' subnet
  - A recovery service vault
- Target Resource Group containing
    - target Vnet

## Configuration
Edit setup.ps1 and change as required:

## Setup

The setup.ps1 file will:
- Deploy the items above.
- Protect (replicate) vm1
