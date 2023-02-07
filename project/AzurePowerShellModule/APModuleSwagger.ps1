# $token = ConvertTo-SecureString -String "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" -AsPlainText
# Invoke-RestMethod -Uri "https://raw.githubusercontent.com/Azure/azure-rest-api-specs/aafb0944f7ab936e8cfbad8969bd5eb32263fb4f/specification/databricks/resource-manager/Microsoft.Databricks/preview/2022-04-01-preview/databricks.json" `
# -Authentication Bearer -Token $token -Debug

filter  Get-AzPwshModuleSwaggerFile {
    param (
        # Parameter help description
        [Parameter(Mandatory)]
        [string]
        $Uri,

        [Parameter(Mandatory)]
        [securestring]
        $Token,

        [parameter(Mandatory)]
        [string]
        $OutFile
    )
    LogInfomation -Message "Download file from $Uri into $OutFile"
    Invoke-RestMethod -Uri $Uri -Authentication Bearer -Token $Token -OutFile $OutFile
}


function  Compare-AzPwshModuleSwaggerFile {
    param (
        [parameter(Mandatory)]
        [string]
        $OldFilePath,

        [parameter(Mandatory)]
        [string]
        $NewFilePath
    )
    $oldSwagger = Get-Content -Path $OldFilePath | ConvertFrom-Json -AsHashtable -Depth 100
    $newSwagger = Get-Content -Path $newFilePath | ConvertFrom-Json -AsHashtable  -Depth 100

    # compare path

    # compare api operation 
}

function Get-AzPwshModuleResourceTypeFile {
    param (
        [parameter(Mandatory)]
        [string]
        $ResourceType,

        [parameter(Mandatory)]
        [string]
        $Uri,

        [Parameter(Mandatory)]
        [securestring]
        $Token,

        [parameter(Mandatory)]
        [string]
        $OutDirectory
    )
    $file = $Uri.Split('/')[-1]
    $outFile = (Join-Path $OutDirectory $file)
    Get-AzPwshModuleSwaggerFile -Uri $Uri -Token $Token -OutFile $outFile
    $fileContent = (Get-Content -Path $outFile -Raw)
    
}

. .\logger.ps1 (Join-Path $PSScriptRoot 'AzPwshShellModule.log.txt')

try {
    $config = (Get-Content -Path (Join-Path $PSScriptRoot 'configuration.json'))
    $azurePwshModule = $config.azurePwshModule
    $modulePath = (Join-Path $PSScriptRoot $azurePwshModule.moduleName)
    if (Test-Path -Path $modulePath) {
        Remove-Item -Path $modulePath
    } else {
        New-Item -Path $modulePath
    }

    $oldSwaggerFiles = $config.azPwshModuleSwagger.oldFiles
    $newSwaggerFiles = $config.azPwshModuleSwagger.newFiles
    foreach($oldSwaggerFile in $oldSwaggerFiles) {
        $oldSwaggerFiles.resourceType
        
    }


} catch {
    LogError -Message "An error ocurred"
    LogError -Message ($_ | Out-String)
}