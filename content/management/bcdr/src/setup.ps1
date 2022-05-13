# Initialize variables
$vmname="centosvm1"
$sourceResourcegroupName="fta-live-bcdr"
$targetResourcegroupName="fta-live-bcdr-asr"
$vaultName="fta-live-bcdr-vault"
$sourcelocation="eastus"
$targetlocation="westus"
$sourceVnetName="vnet-fta-live-bcdr"
$targetVnetName="vnet-fta-live-bcdr-asr"
$randomstoragechars=-join ((97..122) | Get-Random -Count 4 | ForEach-Object {[char]$_})
$sourceStorageAccountName="ftalivebcdr$randomstoragechars"

# Create the source & target resource groups to contain the ASR demo
Write-Output "Creating the source and target resource groups"
New-AzResourceGroup -ResourceGroupName $sourceResourcegroupName -Location $sourcelocation
New-AzResourceGroup -ResourceGroupName $targetResourcegroupName -Location $targetlocation

#Accept Marketplace Terms
Write-Output "Accepting Marketplace Terms"
Get-AzMarketplaceTerms -Publisher "cognosys" -Product "centos-7-8-free" -Name "centos-7-8-free" | Set-AzMarketplaceTerms -Accept

#Deploy source VMs & Vault via Bicep
Write-Output "Deploying VMs & Vault via Bicep"
$parameters = @{
        VnetName=$sourceVnetName
        storageaccountname=$sourceStorageAccountName
    }
New-AzResourceGroupDeployment -Name "ftalivebcdr$randomstoragechars" -ResourceGroupName $sourceResourcegroupName `
        -TemplateFile ./ftalivebcdr.bicep -TemplateParameterObject $parameters

#Deploy failover target environment via Bicep
Write-Output "Deploying failover target environment via Bicep"
$parameters = @{
        VnetName=$targetVnetName
    }
New-AzResourceGroupDeployment -Name "ftalivebcdr2$randomstoragechars" -ResourceGroupName $targetResourcegroupName `
        -TemplateFile ./targetbcdr.bicep -TemplateParameterObject $parameters

$sourceStorageAccount=get-AzStorageaccount -ResourceGroupName $sourceResourcegroupName -Name $sourceStorageAccountName
$vault=Get-AzRecoveryServicesVault -ResourceGroupName $sourceResourcegroupName -Name $vaultName
$vm=get-azvm -Name $vmname -ResourceGroupName $sourceResourcegroupName

#Disable soft-delete on the vault
Write-Output "Disabling soft-delete on the vault"
Set-AzRecoveryServicesVaultProperty -VaultId $vault.ID -SoftDeleteFeatureState Disable

#Setting the vault context.
Write-Output "Setting the vault context"
Set-AzRecoveryServicesAsrVaultContext -Vault $vault

#Create Primary ASR fabric
Write-Output "Creating Primary ASR fabric"
$TempASRJob = New-AzRecoveryServicesAsrFabric -Azure -Location $sourcelocation  -Name "A2Ademo-$sourcelocation"

# Track Job status to check for completion
while (($TempASRJob.State -eq "InProgress") -or ($TempASRJob.State -eq "NotStarted")){
        #If the job hasn't completed, sleep for 10 seconds before checking the job status again
        Write-Output $TempASRJob.State
        sleep 10;
        $TempASRJob = Get-AzRecoveryServicesAsrJob -Job $TempASRJob
}

#Check if the Job completed successfully. The updated job state of a successfully completed job should be "Succeeded"
Write-Output $TempASRJob.State

$PrimaryFabric = Get-AzRecoveryServicesAsrFabric -Name "A2Ademo-$sourcelocation"

#Create Recovery ASR fabric
Write-Output "Creating Recovery ASR fabric"
$TempASRJob = New-AzRecoveryServicesAsrFabric -Azure -Location $targetlocation  -Name "A2Ademo-$targetlocation"

# Track Job status to check for completion
while (($TempASRJob.State -eq "InProgress") -or ($TempASRJob.State -eq "NotStarted")){
        Write-Output $TempASRJob.State
        sleep 10;
        $TempASRJob = Get-AzRecoveryServicesAsrJob -Job $TempASRJob
}

#Check if the Job completed successfully. The updated job state of a successfully completed job should be "Succeeded"
Write-Output $TempASRJob.State

$RecoveryFabric = Get-AzRecoveryServicesAsrFabric -Name "A2Ademo-$targetlocation"

#Create a Protection container in the primary Azure region (within the Primary fabric)
Write-Output "Creating a Protection container in the primary Azure region (within the Primary fabric)"
$TempASRJob = New-AzRecoveryServicesAsrProtectionContainer -InputObject $PrimaryFabric -Name "A2A$($sourceLocation)ProtectionContainer"

#Track Job status to check for completion
while (($TempASRJob.State -eq "InProgress") -or ($TempASRJob.State -eq "NotStarted")){
        Write-Output $TempASRJob.State
        sleep 10;
        $TempASRJob = Get-AzRecoveryServicesAsrJob -Job $TempASRJob
}

Write-Output $TempASRJob.State

$PrimaryProtContainer = Get-AzRecoveryServicesAsrProtectionContainer -Fabric $PrimaryFabric -Name "A2A$($sourceLocation)ProtectionContainer"

#Create a Protection container in the recovery Azure region (within the Recovery fabric)
Write-Output "Creating a Protection container in the recovery Azure region (within the Recovery fabric)"
$TempASRJob = New-AzRecoveryServicesAsrProtectionContainer -InputObject $RecoveryFabric -Name "A2A$($targetlocation)ProtectionContainer"

#Track Job status to check for completion
while (($TempASRJob.State -eq "InProgress") -or ($TempASRJob.State -eq "NotStarted")){
        Write-Output $TempASRJob.State
        sleep 10;
        $TempASRJob = Get-AzRecoveryServicesAsrJob -Job $TempASRJob
}

#Check if the Job completed successfully. The updated job state of a successfully completed job should be "Succeeded"
Write-Output $TempASRJob.State

$RecoveryProtContainer = Get-AzRecoveryServicesAsrProtectionContainer -Fabric $RecoveryFabric -Name "A2A$($targetlocation)ProtectionContainer"

#Create replication policy
Write-Output "Creating replication policy"
$TempASRJob = New-AzRecoveryServicesAsrPolicy -AzureToAzure -Name "A2APolicy" -RecoveryPointRetentionInHours 24 -ApplicationConsistentSnapshotFrequencyInHours 4

#Track Job status to check for completion
while (($TempASRJob.State -eq "InProgress") -or ($TempASRJob.State -eq "NotStarted")){
        Write-Output $TempASRJob.State
        sleep 10;
        $TempASRJob = Get-AzRecoveryServicesAsrJob -Job $TempASRJob
}

#Check if the Job completed successfully. The updated job state of a successfully completed job should be "Succeeded"
Write-Output $TempASRJob.State

$ReplicationPolicy = Get-AzRecoveryServicesAsrPolicy -Name "A2APolicy"

#Create Protection container mapping between the Primary and Recovery Protection Containers with the Replication policy
Write-Output "Creating Protection container mapping between the Primary and Recovery Protection Containers with the Replication policy"
$TempASRJob = New-AzRecoveryServicesAsrProtectionContainerMapping -Name "A2APrimaryToRecovery" -Policy $ReplicationPolicy -PrimaryProtectionContainer $PrimaryProtContainer -RecoveryProtectionContainer $RecoveryProtContainer

#Track Job status to check for completion
while (($TempASRJob.State -eq "InProgress") -or ($TempASRJob.State -eq "NotStarted")){
        Write-Output $TempASRJob.State
        sleep 10;
        $TempASRJob = Get-AzRecoveryServicesAsrJob -Job $TempASRJob
}
#Check if the Job completed successfully. The updated job state of a successfully completed job should be "Succeeded"
Write-Output $TempASRJob.State

$SrcToTgTPCMapping = Get-AzRecoveryServicesAsrProtectionContainerMapping -ProtectionContainer $PrimaryProtContainer -Name "A2APrimaryToRecovery"

#Get the Recovery Network in the recovery region
$TargetRecoveryVnet =get-AzVirtualNetwork -Name $targetVnetName -ResourceGroupName $targetResourcegroupName
$SourceVnet=get-AzVirtualNetwork -Name $sourceVnetName -ResourceGroupName $sourceResourcegroupName

#Create an ASR network mapping between the primary Azure virtual network and the recovery Azure virtual network
Write-Output "Creating an ASR network mapping between the primary Azure virtual network and the recovery Azure virtual network"
$TempASRJob = New-AzRecoveryServicesAsrNetworkMapping -AzureToAzure -Name "A2ASrcToTgtNWMapping" -PrimaryFabric $PrimaryFabric -PrimaryAzureNetworkId $SourceVnet.Id -RecoveryFabric $RecoveryFabric -RecoveryAzureNetworkId $TargetRecoveryVnet.Id

#Track Job status to check for completion
while (($TempASRJob.State -eq "InProgress") -or ($TempASRJob.State -eq "NotStarted")){
        Write-Output $TempASRJob.State
        sleep 10;
        $TempASRJob = Get-AzRecoveryServicesAsrJob -Job $TempASRJob
}

#Check if the Job completed successfully. The updated job state of a successfully completed job should be "Succeeded"
Write-Output $TempASRJob.State

#Get the resource group that the virtual machine must be created in when failed over.
$RecoveryRG = Get-AzResourceGroup -Name $targetResourcegroupName -Location $targetlocation

#Specify replication properties for each disk of the VM that is to be replicated (create disk replication configuration)


#Create a list of disk replication configuration objects for the disks of the virtual machine that are to be replicated.
$diskconfigs = @()

#OsDisk
$OSdiskId = $vm.StorageProfile.OsDisk.ManagedDisk.Id
$RecoveryOSDiskAccountType = $vm.StorageProfile.OsDisk.ManagedDisk.StorageAccountType
$RecoveryReplicaDiskAccountType = $vm.StorageProfile.OsDisk.ManagedDisk.StorageAccountType

Write-Output "Creating disk replication configuration for OS disk"
$OSDiskReplicationConfig = New-AzRecoveryServicesAsrAzureToAzureDiskReplicationConfig -ManagedDisk -LogStorageAccountId $sourceStorageAccount.Id `
         -DiskId $OSdiskId -RecoveryResourceGroupId  $RecoveryRG.ResourceId -RecoveryReplicaDiskAccountType  $RecoveryReplicaDiskAccountType `
         -RecoveryTargetDiskAccountType $RecoveryOSDiskAccountType

$diskconfigs += $OSDiskReplicationConfig

# Data disk
Write-Output "Adding data disk replication configuration"
foreach ($dd in $vm.StorageProfile.DataDisks)
{
    $datadiskId1 = $dd.ManagedDisk.Id
    $RecoveryReplicaDiskAccountType = $dd.ManagedDisk.StorageAccountType
    $RecoveryTargetDiskAccountType = $dd.ManagedDisk.StorageAccountType
    
    $DataDiskReplicationConfig  = New-AzRecoveryServicesAsrAzureToAzureDiskReplicationConfig -ManagedDisk -LogStorageAccountId $EastUSCacheStorageAccount.Id `
             -DiskId $datadiskId1 -RecoveryResourceGroupId $RecoveryRG.ResourceId -RecoveryReplicaDiskAccountType $RecoveryReplicaDiskAccountType `
             -RecoveryTargetDiskAccountType $RecoveryTargetDiskAccountType
    $diskconfigs += $DataDiskReplicationConfig
}

#Start replication by creating replication protected item. Using a GUID for the name of the replication protected item to ensure uniqueness of name.
Write-Output "Starting replication"
$TempASRJob = New-AzRecoveryServicesAsrReplicationProtectedItem -AzureToAzure -AzureVmId $vm.Id -Name (New-Guid).Guid -ProtectionContainerMapping $srcToTgtPCMapping -AzureToAzureDiskReplicationConfiguration $diskconfigs -RecoveryResourceGroupId $RecoveryRG.ResourceId
