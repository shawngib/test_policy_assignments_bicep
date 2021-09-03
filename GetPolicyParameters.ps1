# IL5 only exists in GOV cloud, this will give false policy sets in commercial
$il5 = Get-AzPolicySetDefinition -Id /providers/Microsoft.Authorization/policySetDefinitions/f9a961fa-3241-4b20-adc4-bbf8ad9d7197

$CMMC = Get-AzPolicySetDefinition -Id /providers/Microsoft.Authorization/policySetDefinitions/b5629c75-5c77-4422-87b9-2509e680f8de


$parameters = @()
$CMMC.Properties.Parameters.PSObject.Properties | foreach-object {
    $name = $_.Name 
    $value = $_.value.defaultValue
    $type = $_.value.type
    "$type = $value" 
    if($type -eq "String") {
    $parameter = @"
        "$name" : { 
        "value" : "$value"
        },
"@
    $parameters += $parameter
    }
} 

$parameters = @()
$il5.Properties.Parameters.PSObject.Properties | foreach-object {
    $name = $_.Name 
    $value = $_.value.defaultValue
    $type = $_.value.type
    "$type = $value" 
    if($type -eq "String") {
    $parameter = @"
        "$name" : { 
        "value" : "$value"
        },
"@
    $parameters += $parameter
    }
} 