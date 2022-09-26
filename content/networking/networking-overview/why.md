# Why should we talk about networking?

## [prev](./readme.md) | [home](./readme.md)  | [next](./basics.md)

## Networking in Azure is defined virtually (what is this "Fabric" I keep hearing about)

This means networking concepts learnt traditionally don't always apply.

This also means newer techniques are available when designing a network topology.

## Common traps and wrong assumptions

- Thinking there is still layer 2
- Running a DHCP server in Azure
- Adding Multiple NICs on VMs to influence bandwidth
- Force tunneling and hair-pinning
- Assuming no public IP equals no internet access
- Fear of Public Endpoints
- VNet mistakes:
  - Nesting VNets unnecessarily
  - Forgetting to use Network Security Groups (NSGs)
  - Asking too much from Network Security Groups (NSGs)
  - Trying to put PaaS services "into" a VNet when there is no requirement to do so
- Security mistakes
  - Low segmentation/high trust design.
  - Not leveraging Identity as the primary security layer.
  - Not considering logging requirements in network design.

## Troubleshoot difficulties

- Relying on ICMP and on-prem utilities
- Forgetting platform handles routing, not the VMs
- Misconfigured DNS
