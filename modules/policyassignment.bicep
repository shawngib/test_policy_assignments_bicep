targetScope = 'resourceGroup'

@allowed([
  'NIST'
  'IL5' // Gov cloud only, trying to deploy IL5 in AzureCloud will switch to NIST
  'CMMC'
  ''
])
@description('Built-in policy assignments to assign, default is none. [NIST/IL5/CMMC] IL5 is only availalbe for GOV cloud and will switch to NIST if tried in AzureCloud.')
param builtInAssignment string = ''


param policyAssignmentName string = 'MLZ -'

var policyDefinitionID = {
  NIST: {
    id: '/providers/Microsoft.Authorization/policySetDefinitions/cf25b9c1-bd23-4eb6-bd2c-f4f3ac644a5f'
    parameters: json(replace(loadTextContent('policy/NIST-policyAssignmentParameters.json'),'<LAWORKSPACE>', resourceGroup().name))
  }  
  IL5: {
    id: '/providers/Microsoft.Authorization/policySetDefinitions/f9a961fa-3241-4b20-adc4-bbf8ad9d7197'
    parameters: json(replace(loadTextContent('policy/IL5-policyAssignmentParameters.json'),'<LAWORKSPACE>', resourceGroup().name))
  }
  CMMC: {
    id: '/providers/Microsoft.Authorization/policySetDefinitions/b5629c75-5c77-4422-87b9-2509e680f8de'
    parameters: json(replace(loadTextContent('policy/CMMC-policyAssignmentParameters.json'),'<LAWORKSPACE>', resourceGroup().name))
  }  
}

var modifiedAssignment = (environment().name =~ 'AzureCloud' && builtInAssignment =~ 'IL5' ? 'NIST' :  builtInAssignment)
var assignmentName = '${policyAssignmentName} ${modifiedAssignment} ${resourceGroup().name}'

resource assignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = if (!empty(modifiedAssignment)){
  name: assignmentName
  location: resourceGroup().location
  properties: {
      policyDefinitionId: policyDefinitionID[modifiedAssignment].id
      parameters: policyDefinitionID[modifiedAssignment].parameters
  }
  identity: {
    type: 'SystemAssigned'
  }
}
