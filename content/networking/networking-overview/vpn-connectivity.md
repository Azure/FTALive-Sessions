# VPN Connectivity

[prev](./hybrid-connectivity-overview.md) | [home](./readme.md)  | [next](./er-connectivity.md)

## Why use VPN Connectivity?

- VPN is quicker to configure and does not require third-party involvement
- VPN is less expensive than ExpressRoute
- Less resilient and consistent connectivity is acceptable
- Maximum single-connection throughput of ~1Gbps is acceptable
- ExpressRoute is not available or feasible

## Configuring VPN Connectivity

1. Create a VPN Gateway in Azure
1. Configure your on-prem device to connect to the gateway
1. Configure routing between Azure and your external network

- [**Customer devices**](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpn-devices): Microsoft provides a list of validated devices, supported IPSec/IKE configurations, and sample scripts for configuring your VPN device.
- **Routing options**:
  - [BGP](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-bgp-overview): BGP is required for multiple connections and active/active Gateway configurations.
    > When configuring, ensure BGP is enabled at the Gateway, Local Network Gateway, and Connection
  - Static routes using [Local Network Gateways](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#lng)
- [**Availability Design**](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-highlyavailable): high-availability is accomplished with multiple customer-side VPN devices and ideally active/active VPN gateway configurations

  ![VPN dual-redundancy diagram](./png/vpn-dual-redundancy.png)

- VPN connectivity can alternatively be established without a Virtual Network Gateway, using NVAs that you deploy and manage
