@description('Environment Names')
param environmentTypesInfo array

@description('Project Name')
param projectName string

@description('Tags')
param tags object

var roles = [
  {
    id: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
    properties: {}
  }
  {
    id: 'eb960402-bf75-4cc3-8d68-35b34f960f72'
    properties: {}
  }
  {
    id: '18e40d4e-8d2e-438d-97e1-9528336e149c'
    properties: {}
  }
  {
    id: '45d50f46-0b78-4001-a660-4198cbe8cd05'
    properties: {}
  }
  {
    id: '331c37c6-af14-46d9-b9f4-e1909e1b95a0'
    properties: {}
  }
]

resource project 'Microsoft.DevCenter/projects@2024-10-01-preview' existing = {
  name: projectName
}

@description('Project Environment Type Resource')
resource envType 'Microsoft.DevCenter/projects/environmentTypes@2024-10-01-preview' = [
  for env in environmentTypesInfo: {
    name: env.name
    parent: project
    tags: tags
    identity: {
      type: 'SystemAssigned'
    }
    properties: {
      displayName: env.name
      status: 'Enabled'
      deploymentTargetId: subscription().id
      creatorRoleAssignment: {
        roles: toObject(roles, role => role.id, role => role.properties)
      }
    }
  }
]
