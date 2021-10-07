#Use a filter to select resource groups by substring
param ($filter)
 
#Find Resource Groups by Filter -> Verify Selection
Get-AzResourceGroup | ? ResourceGroupName -match $filter | Remove-AzResourceGroup -AsJob -Force

$diagnostics = Get-AzDiagnosticSetting -SubscriptionId bf031e99-23ef-4cc3-b5a9-b2761eb6126d | ? Name -Match $filter 

foreach($setting in $diagnostics)
{
    Remove-AzDiagnosticSetting -SubscriptionId bf031e99-23ef-4cc3-b5a9-b2761eb6126d -Name $setting.Name
}