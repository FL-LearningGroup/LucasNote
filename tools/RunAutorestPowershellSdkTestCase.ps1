class AutorestResult {
    [string]$TestcaseName
    [string]$Type
    [string]$Status
    [string]$Comment
}

$testcaseNameArrary = (Get-ChildItem -Path $PSScriptRoot -Directory -Exclude provider-*).Name | Sort-Object $_
$autorestPowerShellPath = Join-Path $PSScriptRoot "..\..\..\..\autorest.powershell"
$autorestCsharpPath = Join-Path $PSScriptRoot "..\..\..\..\autorest.csharp"
$autorestResultArray = @()

try {
    foreach($testcaseName in $testcaseNameArrary) {
        $generatePowerShellFolder = Join-Path $PSScriptRoot "$testcaseName\powershell"
        $generateCsharpFolder = Join-Path $PSScriptRoot "$testcaseName\csharp"
        Remove-Item -Path $generatePowerShellFolder -Recurse -Force -ErrorAction Ignore
        Remove-Item -Path $generateCsharpFolder -Recurse -Force -ErrorAction Ignore

        $autorestPowershellResult = [AutorestResult]::new()
        $autorestPowershellResult.TestcaseName = $testcaseName
        $autorestPowershellResult.Type = "powershell"
        Write-Host "generate $testcaseName sdk via autorest.powershell"
        $powershellResult = ((autorest --use:$autorestPowerShellPath --tag=$testcaseName.powershell) | Out-String)
        if(($powershellResult -match 'error') -or ($csharpResult -match 'exception') -or ($csharpResult -match 'fatal') -or ($csharpResult -match 'fail')) {
            $autorestPowershellResult.Status = "Failed"
            $autorestPowershellResult.Comment = $powershellResult
        } else {
            $autorestPowershellResult.Status = "Success"
        }
        $autorestResultArray += $autorestPowershellResult
        Write-Host "generate $testcaseName sdk via autorest.csharp"
        $autorestCsharpResult = [AutorestResult]::new()
        $autorestCsharpResult.TestcaseName = $testcaseName
        $autorestCsharpResult.Type = "csharp"
        $csharpResult = ((autorest --use:$autorestCsharpPath --tag=$testcaseName.csharp) | Out-String)
        if (($csharpResult -match 'error') -or ($csharpResult -match 'exception') -or ($csharpResult -match 'fatal') -or ($csharpResult -match 'fail')) {
            $autorestCsharpResult.Status = "Failed"
            $autorestCsharpResult.Comment = $csharpResult
        } else {
            $autorestCsharpResult.Status = "Success"
        }
        $autorestResultArray += $autorestCsharpResult
    }
} catch {
    Write-Error "An error occurred."
    Write-Error ($_ | Out-String)
} finally {
    $autorestResultArray | Export-Csv -Path (Join-Path $PSScriptRoot "autorest.powershell-sdk-$((Get-Date).ToString('yyyyMMddHHmmss')).csv")
}