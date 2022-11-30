# Overview
自动Push code to repo.

# Require
* Install-Module PowerShellForGitHub

# 步骤
1. 比较
    + 比较Swagger的变化
2. 生成Module code
3. Push code

# 比较

## 比较swagger
需要比较的内容, 以API为单位进行比较
```json
{
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Databricks/workspaces/{workspaceName}": {
        "get": {
            "operationId": "Workspaces_Get",
            "parameters": [
                {
                    "$ref": "#/parameters/ResourceGroupName"
                },
                {
                    "$ref": "#/parameters/WorkspaceName"
                },
                {
                    "$ref": "#/parameters/ApiVersionParameter"
                },
                {
                    "$ref": "#/parameters/SubscriptionIdParameter"
                }
            ],
            "responses": {
                "200": {
                    "description": "OK - Returns the workspace.",
                    "schema": {
                    "$ref": "#/definitions/Workspace"
                    }
                },
                "default": {
                    "description": "Error response describing why the operation failed.",
                    "schema": {
                    "$ref": "#/definitions/ErrorResponse"
                    }
                }
            } 
    
        }
    }
}
```


## Model
APGitHubRepo
```json
{
    "repoUrl": "https://github.com/Azure/azure-powershell.git",
    "generateionBranch": "generation",
    "mainBranch": "main"
}

```

Module Information
```json
{
    "moduleName": "Az.Databricks",
    "type": "new|upgrade",
    "oldSwaggerFiles": [
        "https://raw.githubusercontent.com/Azure/azure-rest-api-specs/aafb0944f7ab936e8cfbad8969bd5eb32263fb4f/specification/databricks/resource-manager/Microsoft.Databricks/preview/2022-04-01-preview/databricks.json",
        "https://raw.githubusercontent.com/Azure/azure-rest-api-specs/aafb0944f7ab936e8cfbad8969bd5eb32263fb4f/databricks/resource-manager/Microsoft.Databricks/preview/2022-04-01-preview/vnetpeering.json",
        "https://raw.githubusercontent.com/Azure/azure-rest-api-specs/aafb0944f7ab936e8cfbad8969bd5eb32263fb4f/databricks/resource-manager/Microsoft.Databricks/preview/2022-04-01-preview/accessconnector.json"
    ],
    "newSwaggerFiles": [
        "https://raw.githubusercontent.com/Azure/azure-rest-api-specs/aafb0944f7ab936e8cfbad8969bd5eb32263fb4f/databricks/resource-manager/Microsoft.Databricks/preview/2022-04-01-preview/databricks.json",
        "https://raw.githubusercontent.com/Azure/azure-rest-api-specs/aafb0944f7ab936e8cfbad8969bd5eb32263fb4f/databricks/resource-manager/Microsoft.Databricks/preview/2022-04-01-preview/vnetpeering.json",
        "https://raw.githubusercontent.com/Azure/azure-rest-api-specs/aafb0944f7ab936e8cfbad8969bd5eb32263fb4f/databricks/resource-manager/Microsoft.Databricks/preview/2022-04-01-preview/accessconnector.json"
    ]
}
```

