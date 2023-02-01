$LOCATION = 'australiaeast'
$PREFIX = 'afd'
$RG_NAME = "$PREFIX-aca-rg"

# create resource group
New-AzResourceGroup -Location $LOCATION -name $RG_NAME -Force      

# deploy infrastructure
$params = @{
	'location' = $LOCATION
	'prefix'   = $PREFIX
}

New-AzResourceGroupDeployment `
	-Name 'infra-deployment' `
	-ResourceGroupName $RG_NAME `
	-TemplateFile ./main.bicep `
	-TemplateParameterObject $params

# get deployment template outputs
$OUTPUT = $(Get-AzResourceGroupDeployment -ResourceGroupName $RG_NAME -Name 'infra-deployment').Outputs 

# approve private endpoint connection
$PEC = $(Get-AzPrivateEndpointConnection `
		-PrivateLinkResourceType Microsoft.Network/privateLinkServices `
		-ResourceGroupName $RG_NAME `
		-ServiceName $OUTPUT['privateLinkServiceName'].value)

Write-Output "approving private endpoint connection ID: '$($PEC.Id)'"

Approve-AzPrivateEndpointConnection `
	-PrivateLinkResourceType Microsoft.Network/privateLinkServices `
	-ResourceGroupName $RG_NAME `
	-ServiceName $OUTPUT['privateLinkServiceName'].value `
	-Name $PEC.Name

# test AFD endpoint
curl "https://$($OUTPUT['afdFqdn'].value)"
