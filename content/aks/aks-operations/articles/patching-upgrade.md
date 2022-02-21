# Patching and Upgrade

## Upgrade Kubernetes versions in AKS

- AKS supports 3 GA Kubernetes minor versions (N - 2), and supports 2 stable patch versions for each minor version.
  - To see all supported versions in an Azure region, use `az aks get-versions --location <location> --output table`.
  - To see which version your cluster can upgrade to, use `az aks get-upgrades --resource-group <resource group> --name <cluster name>`.
- You have 30 days from a patch/minor version removal to upgrade to a supported version. Failing to do so within this time window would lead to outside of support of the cluster.
- When you upgrade the AKS cluster, patch versions can be skipped. But the minor versions of the control plane cannot be skipped, except for upgrading from an unsupported version to the minimum supported version. The minor versions of node agent may be the same as or up to two minor versions older than the minor version of the control plane. The table below summarizes the supported version skew according to the [Version Skew Policy](https://kubernetes.io/releases/version-skew-policy/).

    <table>
    <thead>
      <tr>
        <th>Node</th>
        <th>Component</th>
        <th>Supported version skew</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td rowspan="2">Control Plane</td>
        <td>kube-apiserver</td>
        <td>- Must be within 1 minor version difference</td>
      </tr>
      <tr>
        <td>kube-controller-manager<br>kube-scheduler<br>cloud-controller-manager</td>
        <td>- Must not be newer than kube-apiserver<br>- Must be within 1 minor version older than kube-apiserver</td>
      </tr>
      <tr>
        <td rowspan="2">Worker Node</td>
        <td>kubelet</td>
        <td>- Must not be newer than kube-apiserver<br>- Must be within 2 minor version older than kube-apiserver</td>
      </tr>
      <tr>
        <td>kube-proxy</td>
        <td>- Must be on the same minor version as kubelet</td>
      </tr>
      <tr>
        <td>Client</td>
        <td>kubectl</td>
        <td>- Can be 1 minor version newer or older than kube-apiserver</td>
      </tr>
    </tbody>
    </table>

- The Kubernetes upgrade of AKS cannot be rollback or downgrade.
- The Kubernetes can be upgraded in 3 scopes:
  - **Upgrade a cluster**: `az aks upgrade --resource-group <resource group> --name <cluster name> --kubernetes-version <k8s version>`
  - **Upgrade the control plane only**: `az aks upgrade --resource-group <resource group> --name <cluster name> --kubernetes-version <k8s version> --control-plane-only`
  - **Upgrade node pools**: `az aks nodepool upgrade --resource-group <resource group> --cluster-name <cluster name> --name <nodepool name> --kubernetes-version <k8s version>`

Read further:

- [Supported Kubernetes versions in AKS](https://docs.microsoft.com/azure/aks/supported-kubernetes-versions)

## Upgrade node OS

- The Linux nodes in AKS clusters automatically check and install updates daily. But AKS doesn't automatically reboot the nodes even if the updates requires the reboot. You have to reboot the nodes either manually or by using tools like [Kured](https://github.com/weaveworks/kured). Please be careful about the capacity impact when you reboot the node manually or with Kured.
- AKS provides a new node image with the latest OS and runtime updates weekly.
  - To check the image version of a node pool, use `az aks nodepool show --resource-group <resource group> --cluster-name <cluster name> -name <nodepool name> --query nodeImageVersion`.
  - To see the latest image version available for the node pool, use `az aks nodepool get-upgrades --resource-group <resource group> --cluster-name <cluster name> --nodepool-name <nodepool name>`.
  - To upgrade the node image for all nodes in the cluster, use `az aks upgrade --resource-group <resource group> --name <cluster name> --node-image-only`.
  - To upgrade the image of a node pool, use `az aks nodepool upgrade --resource-group <resource group> --cluster-name <cluster name> --name <nodepool name> --node-image-only`.
- The OS of Windows nodes can only be upgraded with the image.

Read further:

- [AKS node image upgrade](https://docs.microsoft.com/azure/aks/node-image-upgrade)

## How AKS upgrade works

AKS takes the following process to upgrade an AKS cluster (with default max surge which is 1).

- A buffer node with the specified Kubernetes version is added to the cluster.
- An old node is cordoned and drained.
- The old node is reimaged to be the new buffer node.
- When the upgrade completes, the last buffer node is deleted.

## Recommendations for the upgrade strategy

- For medium and large AKS clusters, upgrade Kubernetes on control plane first, and then upgrade node pools one at a time. Avoid upgrading the whole cluster in one shot. However, if you upgrade a cluster from unsupported version to the supported version, you should upgrade the whole cluster to avoid having the unsupported version skew.
- To increase the speed of upgrades, consider setting the max surge of node pools. Max-surge setting of 33% is recommended for production node pools.

  > [!NOTE]
  > If you are using Azure CNI, when setting max-surge, make sure you have sufficient IP addresses for the surge of the nodes. Also make sure you have enough compute quota.

- For the critical workload in production, use [Pod Disruption Budget](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) (PDB) to ensure the availability of the workload. Meanwhile, also make sure the PDB doesn't block the upgrade process. For example, ensure the `allowed disruptions` to be at least 1.
- It is recommended to upgrade the image of node pools regularly. The process of upgrading the node pool image is better than patching and rebooting the node manually or with Kured. You can leverage the CI/CD pipeline or [auto-upgrade channel](https://docs.microsoft.com/azure/aks/upgrade-cluster#set-auto-upgrade-channel) to upgrade the image of node pools regularly.
- Use [Planned Maintenance](https://docs.microsoft.com/azure/aks/planned-maintenance) to control the schedule of the upgrade.
  
  > [!NOTE]
  > Auto-upgrade channel and Planned Maintenance are preview features.

- When upgrading the node pools of medium and large AKS clusters, you can consider adopting the **blue/green upgrade strategy** if possible.

Read further:

- [Upgrade an AKS cluster](https://docs.microsoft.com/azure/aks/upgrade-cluster)
- [Upgrade AKS nodes using GitHub Actions](https://docs.microsoft.com/azure/aks/node-upgrade-github-actions)
- [AKS Day-2 Operations](https://docs.microsoft.com/azure/architecture/operator-guides/aks/aks-upgrade-practices)
