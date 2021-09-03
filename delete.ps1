#Use a filter to select resource groups by substring
$filter = '-hub'
 
#Find Resource Groups by Filter -> Verify Selection
Get-AzResourceGroup | ? ResourceGroupName -match $filter | Remove-AzResourceGroup -AsJob -Force



#Use a filter to select resource groups by substring
$filter = '-operations'
 
#Find Resource Groups by Filter -> Verify Selection
Get-AzResourceGroup | ? ResourceGroupName -match $filter | Remove-AzResourceGroup -AsJob -Force