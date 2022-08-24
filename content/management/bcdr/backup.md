# Azure Backup

### What can we backup?

Diverse support for workloads running in Azure, on-premises or in other clouds:

- [Azure Backup - Support Matrix](https://docs.microsoft.com/en-us/azure/backup/backup-support-matrix)
- [Azure Backup Server - Support Matrix](https://docs.microsoft.com/en-us/azure/backup/backup-mabs-protection-matrix)
   
### Types of Vaults
- [Recovery Services Vaults](https://docs.microsoft.com/en-us/azure/backup/backup-azure-recovery-services-vault-overview)
- [Backup Vaults](https://docs.microsoft.com/en-us/azure/backup/backup-vault-overview)

### VM Restore Options
  - [Instant Restore](https://docs.microsoft.com/en-us/azure/backup/backup-instant-restore-capability) provides snapshot-based disk recovery to speed up restore times.
  - Recover files and folders from a [recovery point](https://docs.microsoft.com/en-us/azure/backup/backup-azure-restore-files-from-vm) (without restoring the full VM)

### Backup Policies
  - [Enhanced Policies](https://docs.microsoft.com/en-us/azure/backup/backup-azure-vms-enhanced-policy) can support hourly backups (4 hour minimum RPO)

### Backup Center

[Backup Center](https://docs.microsoft.com/en-us/azure/backup/backup-overview#what-can-i-back-up) makes it easier to manage backups at scale.  Remember to [configure](https://docs.microsoft.com/en-us/azure/backup/configure-reports) Azure Backup reports to gain insights into backup jobs. Use [built-in](https://docs.microsoft.com/en-us/azure/backup/azure-policy-configure-diagnostics) Azure Policy definitions to automate your backup protection at scale.

#### DEMO: Key benefits of Backup Center

- Provides a data source-centric vs. vault-centric view 
- Backup Reports
- Governance: Azure Policies for Backup 

#### DEMO: Azure VM Backup & Restore 

- Enable Backup Protection
- Recover an Azure VM
- Recover a file from a restore point

### Additional learning resources

[FAQ - Back up Azure VMs](https://docs.microsoft.com/en-us/azure/backup/backup-azure-vm-backup-faq)

[Tutorial - Backup Multiple Azure VMs](https://docs.microsoft.com/en-us/azure/backup/tutorial-backup-vm-at-scale)

[Protect Against Ransomware](https://docs.microsoft.com/en-us/azure/security/fundamentals/backup-plan-to-protect-against-ransomware)