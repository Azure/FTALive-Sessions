param (
    [string]$gMSAAccountName,
    [string]$LBFQDN,
    [string]$SCOMMIServersGroupName,
    [string]$SCOMMILocalDomainAccountName,
    [securestring]$SCOMMILocalDomainAccountPassword,
    [string]$LBAddress
)
# Sample usage
# .\add-scommiaccounts.ps1 -gMSAAccountName "SCOMMIgMSA" -LBFQDN "SCOMMI-LB.contoso.com" -SCOMMIServersGroupName "SCOMMI-Servers" `
# -SCOMMILocalDomainAccountName "SCOMMI-Local" -SCOMMILocalDomainAccountPassword (ConvertTo-SecureString -String "Password" -AsPlainText -Force) -LBAddress x.x.x.x"
function set-Allow-ManagedBy-Permissions  {
    param (
        [string]$groupName,
        [string]$userName
    )
    #Manager setzen
    $user = Get-ADUser $userName 
    #Set-ADGroup „VL_ManagerTest“ -Replace @{managedBy=$user.DistinguishedName}
    #RightsGuid
    $guid = [guid]'bf9679c0-0de6-11d0-a285-00aa003049e2'
    #SID of the Managers
    $sid = [System.Security.Principal.SecurityIdentifier]$user.sid
    #ActiveDirectoryAccessRule 
    $ctrlType = [System.Security.AccessControl.AccessControlType]::Allow 
    $rights = [System.DirectoryServices.ActiveDirectoryRights]::WriteProperty -bor [System.DirectoryServices.ActiveDirectoryRights]::ExtendedRight
    $rule = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($sid, $rights, $ctrlType, $guid)
    $group = Get-ADGroup $groupName
    $aclPath = "AD:\" + $group.distinguishedName 
    $acl = Get-Acl $aclPath
    $acl.AddAccessRule($rule) 
    Set-Acl -acl $acl -path $aclPath
}
# create active direcoty local account
# 
if (!(Get-WindowsFeature RSAT-AD-PowerShell)) {
    Install-WindowsFeature RSAT-AD-PowerShell -Confirm
}
# Import-Module ActiveDirectory
new-aduser -Name $SCOMMILocalDomainAccountName -AccountPassword $SCOMMILocalDomainAccountPassword -PasswordNeverExpires $true -Enabled $true
$domainAccount=Get-ADUser $SCOMMILocalDomainAccountName
# Create AD Group
New-adgroup $SCOMMIServersGroupName -GroupCategory Security -GroupScope Global
# Set managed by permissions for the account to the group above
$group=Get-ADGroup $SCOMMIServersGroupName
Set-adgroup $group -ManagedBy $domainAccount
# Set Allow-ManagedBy-Permissions
set-Allow-ManagedBy-Permissions -groupName $SCOMMIServersGroupName -userName $SCOMMILocalDomainAccountName
# Set DNS Entry
$allPieces = $LBFQDN.Split(".")
$shortLBName=$allPieces[0]
$ZoneName = [string]::Join('.',$allPieces[1..($allPieces.Length - 1)])
Add-DnsServerResourceRecordA -Name $shortLBName -ZoneName $ZoneName  -IPv4Address $LBAddress
# Create gMSA
New-ADServiceAccount $gMSAAccountName `
                    -DNSHostName $LBFQDN `
                    -PrincipalsAllowedToRetrieveManagedPassword $SCOMMIServersGroupName `
                    -KerberosEncryptionType AES128, AES256 `
                    -ServicePrincipalNames "MSOMHSvc/$LBFQDN", "MSOMHSvc/$shortLBName", "MSOMSdkSvc/$LBFQDN", "MSOMSdkSvc/$shortLBName"
