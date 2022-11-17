param(
    [string]
    $TestName
)

enum GeneratedStatus {
    Failed
    Success
}

enum ComparedStatus {
    Equal
    NotEqual
}

class TestSdkModel {
    [string]$TestName
    [GeneratedStatus]$CsharpGeneratedStatus
    [GeneratedStatus]$PowerShellGeneratedStatus
    [ComparedStatus]$SdkComparedStatus
    [string]$CsharpSdkFolder
    [string]$PowerShellSdkFolder
    [string[]]$Result
    [string]$Comment
}

function GenerateAutorestCshapSdkCode {
    param (
        [TestSdkModel]
        $TestSdk
    )
    $result = (autorest --use:$script:autorestCsharp --tag=$($TestSdk.TestName).csharp) | Out-String
    if (($result -match 'error') -or ($result -match 'exception') -or ($result -match 'fatal') -or ($result -match 'fail')) {
        return $false
    } elseif(!(Test-Path -Path $TestSdk.CsharpSdkFolder)) {
        return $false
    } else {
        return $true
    }
}

function GenerateAutorestPowerShellSdkCode {
    param (
        [TestSdkModel]
        $TestSdk
    )
    $result = (autorest --use:$script:autorestPowerShell --tag=$($TestSdk.TestName).powershell) | Out-String
    if (($result -match 'error') -or ($result -match 'exception') -or ($result -match 'fatal') -or ($result -match 'fail')) {
        return $false
    } elseif(!(Test-Path -Path $TestSdk.PowerShellSdkFolder)) {
        return $false
    }else {
        return $true
    }
}

function  GenerateSdkCode {
    param (
        [TestSdkModel]
        $TestSdk
    )
    if ((GenerateAutorestCshapSdkCode -TestSdk $TestSdk)) {
        $TestSdk.CsharpGeneratedStatus = [GeneratedStatus]::Success
    } else {
        $TestSdk.SdkComparedStatus = [ComparedStatus]::NotEqual
        $TestSdk.CsharpGeneratedStatus = [GeneratedStatus]::Failed
        $TestSdk.Result += $TestSdk.CsharpGeneratedStatus ? $null : "Csharp sdk code failed generated"
    }
    
    if ((GenerateAutorestPowerShellSdkCode -TestSdk $TestSdk)) {
        $TestSdk.PowerShellGeneratedStatus = [GeneratedStatus]::Success
    } else {
        $TestSdk.SdkComparedStatus = [ComparedStatus]::NotEqual
        $TestSdk.PowerShellGeneratedStatus = [GeneratedStatus]::Failed
        $TestSdk.Result += $TestSdk.PowerShellGeneratedStatus ? $null : "PowerShell sdk code failed generated"
    }
}

function CompareSdkGenerateFileCount {
    param (
        [string[]]
        $CsharpSdkFileNames,

        [string[]]
        $PowerShellSdkFileNames
    )
    $result = @{"result" = $null; "files" = @()}

    foreach($csharpFileName in $CsharpSdkFileNames) {
        if ($PowerShellSdkFileNames -notcontains $csharpFileName) {
            $result["result"] += "$csharpFileName not extis" 
        } else {
            $result["files"] += $csharpFileName
        }
    }
    return $result
}

function CompareSingleSdkFile {
    param (
        [string]
        $CsharpFilePath,

        [string]
        $PowerShellFilePath
    )
    $fileName = Split-Path -Path $CsharpFilePath -Leaf
    $validCsharpContent = ((Get-Content -Path $CsharpFilePath) | ForEach-Object {($_ -replace "\s+", "")} `
        | Where-Object {(($_ -notlike "*//*") -and ($_ -ne "") -and ($_ -ne '{') -and ($_ -ne '}') -and ($_ -ne '};'))})

    $validPowerShellContent = ((Get-Content -Path $PowerShellFilePath)| ForEach-Object {($_ -replace "\s+", "")} `
        | Where-Object {(($_ -notlike "*//*") -and ($_ -ne "") -and ($_ -ne '{') -and ($_ -ne '}') -and ($_ -ne '};'))})
    
    if ($validCsharpContent.Length -ne $validPowerShellContent.Length) {
        return @{"compared" = $false; "result" = "$fileName - content different"}
    }
    foreach($csharpContent in $validCsharpContent) {
        if ($validPowerShellContent -notcontains $csharpContent)
        {
            return @{"compared" = $false; "result" = "$fileName - content different"}
        }
    }

    return @{"compared" = $true; "result" = $null}

}

function CompareTestSdkCode { 
    param (
        [TestSdkModel]
        $TestSdk,
        
        [string[]]
        $ignoreFiles
    )
    if (($TestSdk.PowerShellGeneratedStatus -eq [GeneratedStatus]::Failed) -or ($TestSdk.CsharpGeneratedStatus -eq [GeneratedStatus]::Failed)) {
        return
    } else {
        $csharpFiles = Get-ChildItem -Path $TestSdk.CsharpSdkFolder -Recurse -File -Exclude $ignoreFiles
        $powershellFiles = Get-ChildItem -Path $TestSdk.PowerShellSdkFolder -Recurse -File -Exclude $ignoreFiles
        $compareResult = (CompareSdkGenerateFileCount -CsharpSdkFileNames $csharpFiles.Name -PowerShellSdkFileNames $powershellFiles.Name)
        $isFileContentEqual = $true
        if ($null -ne $compareResult["result"]) {
            $TestSdk.Result +=  $compareResult["result"]
            $isFileContentEqual = $false
        }
        # Get files that exist in csharp and powershell
        $existCsharpFiles = $csharpFiles | Where-Object {$compareResult["files"] -contains $_.Name}

        foreach($existFile in $existCsharpFiles)
        {
            $powershellFile = $powershellFiles | Where-Object {$_.Name -eq $existFile.Name}
            $fileCompareResult = CompareSingleSdkFile -CsharpFilePath $existFile.FullName -PowerShellFilePath $powershellFile.FullName
            if (!$fileCompareResult["compared"]) {
                $TestSdk.Result +=  $fileCompareResult["result"]
                $isFileContentEqual = $false
            }
        }

        if ($isFileContentEqual) {
            $TestSdk.SdkComparedStatus = [ComparedStatus]::Equal
        } else {
            $TestSdk.SdkComparedStatus = [ComparedStatus]::NotEqual
        }
    } 
}

try 
{
    $script:autorestCsharp = Join-Path $PSScriptRoot "..\..\..\..\autorest.csharp"
    $script:autorestPowerShell = Join-Path $PSScriptRoot "..\..\..\..\autorest.powershell"
    $configuration = (Get-Content -Path (Join-Path $PSScriptRoot "configuration.json") | ConvertFrom-Json)
    $ignoreTests =  $configuration.blackList
    # Some folder are test folder.
    $ignoreFolder =  $configuration.ignoreFolder
    # Skip no need compare file.
    $ignoreCompareFiles = $configuration.ignoreFile
    $testSdkSummary = @()
    if($TestName) {
        $testFolder = Join-Path $PSScriptRoot $TestName
        if ((Test-Path -Path $testFolder)) {
            $tests +=  (Get-Item -Path $testFolder)
        } else {
            Throw "Test $TestName folder not exist."
        }
    } else {
        $tests = (Get-ChildItem -Path $PSScriptRoot -Directory -Exclude ($ignoreTests + $ignoreFolder)) | Sort-Object {$_.Name}
    }
    foreach($test in $tests) {
        $testSdk = [TestSdkModel]::new()
        $testSdk.TestName = $test.Name
        $testSdk.CsharpGeneratedStatus = [GeneratedStatus]::Failed
        $testSdk.PowerShellGeneratedStatus = [GeneratedStatus]::Failed
        $testSdk.SdkComparedStatus = [ComparedStatus]::NotEqual
        $testSdk.CsharpSdkFolder = (Join-Path $test.FullName 'csharp')
        $testSdk.PowerShellSdkFolder = (Join-Path $test.FullName 'powershell')
        $testSdkSummary += $testSdk
    }
    
    foreach($testSdk in $testSdkSummary) {
        Write-Host "test $($testSdk.TestName) testing...."
        GenerateSdkCode -TestSdk $testSdk
        CompareTestSdkCode -TestSdk $testSdk -ignoreFiles $ignoreCompareFiles
    }
    # Convert result to comment for dispaly in csv file.
    foreach ($testSdk in $testSdkSummary) {
        $testSdk.Comment = ($testSdk.Result | Out-String)
    }
    $testSdkSummary | Format-Table
    $testSdkSummary | Select-Object -Property TestName, CsharpGeneratedStatus, PowerShellGeneratedStatus, SdkComparedStatus, Comment | Export-Csv -Path (Join-Path $PSScriptRoot "autorest-powershell-sdk.csv") -NoClobber -Force
    if ($testSdkSummary.SdkComparedStatus -contains [ComparedStatus]::NotEqual) {
        throw 'The code generated by the autorest.powershell file is different from the code generated by the autorest.csharp.'
    } else
    {
        Write-Host 'All generated codes are the same'
    }
} catch {
    Write-Error "An error occurred"
    Write-Error ($_ | Out-String)
}