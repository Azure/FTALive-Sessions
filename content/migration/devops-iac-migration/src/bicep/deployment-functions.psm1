$hash_windows_os=@{
    "2008"="2008-R2-SP1"
    "2012"="2012-Datacenter"
    "2016"="2016-Datacenter"
    "2019"="2019-Datacenter"
    "2022"="2022-datacenter"
}

function Get-VMOS {
    param (
        [string]$OS
    )
    $templateOS = New-Object PSobject | Select-Object PublisherName,Offer,Sku,Ostype
    if ($OS.Contains('Windows Server')){
        $OSVersion = $OS | Select-String -Pattern "\b\d{4}\b"
        $templateOS.PublisherName = "MicrosoftWindowsServer"
        $templateOS.Offer = "WindowsServer"
        $templateOS.Sku = $hash_windows_os[$OSVersion.Matches.Value]
        $templateOS.Ostype = "Windows"
        return $templateOS
    }
    elseif ($OS.Contains('Linux')) {
        $templateOS.PublisherName = "Canonical"
        $templateOS.Offer = "UbuntuServer"
        $templateOS.Sku = "18.04-LTS"
        $templateOS.Ostype = "Linux"
        return $templateOS
    }
    Write-Error -Message "Windows OS not found"
    throw
}
