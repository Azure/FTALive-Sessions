# Forcing PowerShell to use TLS1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Requesting the Azure AD Tenant Id to authenticate against
$WorkspaceID = Read-Host -Prompt "Enter the Workspace id of the workspace to be removed from MMA configuration."

# Validating the workspace is not empty
If(!([string]::IsNullOrEmpty($WorkspaceID)) -or !([string]::IsNullOrWhiteSpace($WorkspaceID)))
{
    # Creating agent configuration object
    $AgentCfg = New-Object -ComObject AgentConfigManager.MgmtSvcCfg

    # Verifying that Workspace is configured for this MMA
    $Workspace = $AgentCfg.GetCloudWorkspace($WorkspaceID)
    if($Workspace)
    {
        Write-Host "Found configured Log Analytics Workspace <$WorkspaceID>."

        # Removing workspace
        $Error.Clear()
        $AgentCfg.RemoveCloudWorkspace($WorkspaceID)
        if($Error)
        {
            Write-Host "There was a critical error removing the Log Analytics workspace <$WorkspaceID>.  Error is: $Error"
            exit
        }
        
        # Restart Agent
        Write-Host "Log Analytics workspace <$WorkspaceID> removed succesfully."
        Write-Host "Restarting the Log Analytics Agent now."
        #Restart-Service healthservice
        $AgentCfg.ReloadConfiguration()
    }
    else
    {
        Write-Host "This agent was not configured to report to Log Analytics workspace <$WorkspaceID>."
        exit
    }
}