@description('Name of the Log Analytics workspace')
param name string 

@description('Role Definitions for the Log Analytics workspace')
param workloadRoleDefinitions array

@description('Tags for the Log Analytics workspace')
param tags object

@description('Create a Log Analytics workspace')
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: '${name}-${uniqueString(name, resourceGroup().id)}'
  location: resourceGroup().location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

@description('Role Assignment Resource')
module roleAssignments '../identity/roleAssignmentResource.bicep' = {
  scope: subscription()
  name: 'Monitoring-roleAssignments'
  params: {
    principalId: logAnalytics.identity.principalId
    roleDefinitions: workloadRoleDefinitions
  }
}
