// scope
targetScope = 'subscription'

module hubResourceGroup './modules/resourceGroup.bicep' = {
  name: 'hubResourceGroup'
  scope: subscription(hubSubscriptionId)
  params: {
    name: hubResourceGroupName
    location: hubLocation
    tags: tags
  }
}

module operationsResourceGroup './modules/resourceGroup.bicep' = {
  name: 'operationsResourceGroup'
  scope: subscription(operationsSubscriptionId)
  params: {
    name: operationsResourceGroupName
    location: operationsLocation
    tags: tags
  }
}

module hubPolicyAssignment './modules/policyassignment.bicep' = {
  name: 'policyAssignement'
  scope: resourceGroup(hubSubscriptionId, hubResourceGroupName)
  dependsOn: [
    hubResourceGroup
  ]
  params: {
    builtInAssignment: policy
  }
}

module operationsPolicyAssignment './modules/policyassignment.bicep' = {
  name: 'policyAssignement'
  scope: resourceGroup(operationsSubscriptionId, operationsResourceGroupName)
  dependsOn: [
    operationsResourceGroup
  ]
  params: {
    builtInAssignment: policy
  }
}


// parameters
param resourcePrefix string = 'mlz-${uniqueId}'
param hubResourceGroupName string = '${resourcePrefix}-hub'
param hubLocation string = deployment().location
param hubSubscriptionId string = subscription().subscriptionId
param uniqueId string = uniqueString(deployment().name)
param tags object = {
  'deployment': resourcePrefix
}
param operationsResourceGroupName string = replace(hubResourceGroupName, 'hub', 'operations')
param operationsSubscriptionId string = hubSubscriptionId
param operationsLocation string = hubLocation
param policy string = ''
