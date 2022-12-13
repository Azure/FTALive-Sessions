[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$AssessedMachinesFilePath,
    [Parameter(Mandatory=$true)]
    [string]$AssessedDisksFilePath,    
    [Parameter(Mandatory=$true)]
    [string]$RG,
    [Parameter(Mandatory=$true)]
    [string]$Location,
    [Parameter(Mandatory=$true)]
    [string]$VNetName,
    [Parameter(Mandatory=$true)]
    [string]$SubnetName
)
if ($null -eq (get-module deployment-functions))
{
    import-module ./src/bicep/deployment-functions.psm1
}
$hash_disk_table=Get-Content ./src/bicep/hash_disk_table.json | ConvertFrom-Json
$hash_disk_type=Get-Content ./src/bicep/hash_disk_type.json | convertfrom-json

$CSV_All_Assessed_Disks = $AssessedDisksFilePath
$CSV_All_Assessed_Machines = $AssessedMachinesFilePath
$CSV_All_Assessed_Disks_temp = $AssessedDisksFilePath.Replace("All_Assessed_Disks","All_Assessed_Disks_temp")
$CSV_All_Assessed_Machines_temp = $AssessedMachinesFilePath.Replace("All_Assessed_Machines","All_Assessed_Machines_temp")

$All_Assessed_Machines_Header = 'Machine','VM host','Azure VM readiness','Azure readiness issues','Data collection issues','Recommended size','Compute monthly cost estimate USD','Storage monthly cost estimate USD','Operating system','Boot type','Cores','Memory(MB)','CPU usage(%)','Memory usage(%)','Storage(GB)','Standard HDD disks','Standard SSD disks','Premium disks','Ultra disks','Disk read(ops/sec)','Disk write(ops/sec)','Disk read(MBPS)','Disk write(MBPS)','Network adapters','IP address','MAC address','Network in(MBPS)','Network out(MBPS)','Group name'
$All_Assessed_Disks_Header = 'Machine','Disk name','Azure disk readiness','Recommended disk size SKU','Recommended disk type','Azure readiness issues','Data collection issues','Monthly cost estimate','Source disk size(GB)','Target disk size(GB)','Disk read(MBPS)','Disk write(MBPS)','Disk read(ops/sec)','Disk write(ops/sec)','Ultra disk provisioned IOPS (Operations/Sec)','Ultra disk provisioned throughput (MBPS)'

$CSV_All_Assessed_Machines_Info = Get-Content -Path $CSV_All_Assessed_Machines | Select-Object -Skip 1
$CSV_All_Assessed_Machines_Info | Out-File -FilePath $CSV_All_Assessed_Machines_temp
$vmAttributes = Import-Csv -Path $CSV_All_Assessed_Machines_temp -Header $All_Assessed_Machines_Header
#$vmAttributes
$endRow_All_Assessed_Machines = ((Get-Content $CSV_All_Assessed_Machines).Length)-1
$templateVMObj = New-Object PSobject | Select-Object Machine,Recommended_size,Operating_system,disk_properties
$arrVMs=New-Object System.Collections.ArrayList
for ($i = 0; $i -lt $endRow_All_Assessed_Machines; $i++) {
    $vmObj = $templateVMObj | Select-Object *
    $vmObj.Machine = $vmAttributes[$i].Machine
    $vmObj.Recommended_size = $vmAttributes[$i].'Recommended size'
    $vmObj.Operating_system = $vmAttributes[$i].'Operating system'
    #$vmObj
    [void]$arrVMs.Add($vmObj)
    # $arrVMs.Add($vmObj)
}
#$arrVMs
# Disks
$endRow_All_Assessed_Disks = (Get-Content $CSV_All_Assessed_Disks).Length
$CSV_All_Assessed_Disks_Info = Get-Content -Path $CSV_All_Assessed_Disks | Select-Object -Skip 1
$CSV_All_Assessed_Disks_Info | Out-File -FilePath $CSV_All_Assessed_Disks_temp
$diskAttributes = Import-Csv -Path $CSV_All_Assessed_Disks_temp -Header $All_Assessed_Disks_Header
#$diskAttributes
$templateDiskObj = New-Object PSobject | Select-Object Machine,Disk_name,Recommended_disk_size_sku
$arrDisks=New-Object System.Collections.ArrayList
for ($j = 0; $j -lt $endRow_All_Assessed_Disks; $j++) {
    $vmObj = $templateDiskObj | Select-Object *
    $vmObj.Machine = $diskAttributes[$j].Machine
    $vmObj.Disk_name = $diskAttributes[$j].'Disk name'
    $vmObj.Recommended_disk_size_sku = $diskAttributes[$j].'Recommended disk size SKU'
    [void]$arrDisks.Add($vmObj)
}
$arrDisks

foreach ($vm in $arrVMs) {
    $arrspecificVM=New-Object System.Collections.ArrayList
    foreach ($disk in $arrDisks) {
        if ($vm.Machine -eq $disk.Machine) {
            [void]$arrspecificVM.Add($disk)
        }
    }
    $vm.disk_properties = $arrspecificVM
}
Write-Output "---arrVMs---"
$arrVMs
#$arrVMs[0].disk_properties

foreach ($vm in $arrVMs) {
    Write-Output "---vm---"
    $vm
    $vnet = Get-AzVirtualNetwork -ResourceGroupName $RG -Name $VNetName
    $os = Get-VMOS($vm.Operating_system)
    $diskCount = 1
    $disksizes=@()
    $disktypes=@()
    foreach ($disk in $vm.disk_properties) {
        if ($disk.Disk_name -ne "scsi0:0") {
            $disk_sku = ($disk.Recommended_disk_size_sku.split("_"))[1]
            $disk_type = $hash_disk_type[$disk_sku.substring(0,1)]
            $disktypes+=$disk_type
            $disk_size = $hash_disk_table[$disk_sku]
            $disksizes+=$disk_size
            $diskCount++
        }
    }
    $parameters = @{
        vmname=$vm.Machine
        vnetId=$vnet.id
        SubnetName=$SubnetName
        location=$Location
        osType=$os.Ostype
        vmSize=$vm.Recommended_size
        publisher=$os.PublisherName
        offer=$os.offer
        sku=$os.Sku
        datadisksizes=$disksizes
        datadisktypes=$disktypes
    }
    if ($parameters.osType -eq 'Windows')
    {
        New-AzResourceGroupDeployment -location $Location -ResourceGroupName $RG -TemplateFile .\src\bicep\vmwindows.bicep -TemplateParameterObject $parameters
    }
    else {
        New-AzResourceGroupDeployment -location $Location -ResourceGroupName $RG -TemplateFile .\src\bicep\vmlinux.bicep -TemplateParameterObject $parameters
    }
}
