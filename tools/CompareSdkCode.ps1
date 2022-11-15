class CompareResult {
    [string]$TestcaseName
    [int]$FileCount
    [string]$Status
    [string]$Result
}
$testcaseList = (Get-ChildItem -Path $PSScriptRoot -Directory).Name
$compareResultList = @()
$ignoreFile = @("SdkInfo_*.cs")

try {
    foreach($testcaseName in $testcaseList) {
        Write-Host "Compare $testcaseName-----------------"
        $powershellFolder = Join-Path $PSScriptRoot "$testcaseName\powershell"
        $csharpFolder = Join-Path $PSScriptRoot "$testcaseName\csharp"
        $compareResult = [CompareResult]::new()
        $compareResult.TestcaseName = $testcaseName
        $compareResult.FileCount = 0
        $isEqual = $true
        try {
            $csharpFiles = (Get-ChildItem -Path $csharpFolder -Recurse -File -Exclude $ignoreFile)
            $powershellFiles = (Get-ChildItem -Path $powershellFolder -Recurse -File)
        } catch {
            $compareResult.Status = "Failed"
            $compareResult.Result += ($_ | Out-String)
            continue
        }

        foreach($csharpFile in $csharpFiles) {
            $compareResult.FileCount++
            Write-Host "Compare $testcaseName -file $csharpFile-----------------"
            # check file of the csharp sdk code if exist in the powershell sdk code.
            $powershellFile = $powershellFiles | Where-Object {$_.Name -eq $csharpFile.Name}
            if ($powershellFile) {
                # Check whether cotent equal.
                # remove ALL whitespace -replace "\s+", ""
                $powershellFileContentList = ((Get-Content -Path $powershellFile.FullName) | ForEach-Object {($_ -replace "\s+", "")} `
                                            | Where-Object {(($_ -notlike "*//*") -and ($_ -ne "") -and ($_ -ne '{') -and ($_ -ne '}') -and ($_ -ne '};'))})
                $csharpFileContentList = ((Get-Content -Path $csharpFile.FullName) | ForEach-Object {($_ -replace "\s+", "")} `
                                            | Where-Object {(($_ -notlike "*//*") -and ($_ -ne "") -and ($_ -ne '{') -and ($_ -ne '}') -and ($_ -ne '};'))})
                if ($powershellFileContentList.Length -eq $csharpFileContentList.Length) {
                    $isContentEqual = $true
                    foreach($csharpFileContent in $csharpFileContentList) {
                        if ($powershellFileContentList -contains $csharpFileContent) {

                        } else {
                            $isContentEqual = $false
                        }
                        if (!$isContentEqual) {
                            $isEqual = $false
                            $compareResult.Result += "$($csharpFile.Name) is different`n"
                            break
                        }
                    }
                } else {
                    $isEqual = $false
                    $compareResult.Result += "$($csharpFile.Name) - file content not equal, csharp file has $($csharpFileContentList.Length) lines, powershell file has $($powershellFileContentList.Length) lines`n"
                }
            } else {
                $isEqual = $false
                $compareResult.Result += "$($csharpFile.Name)- file not exist`n"
            }
        }

        if (!$isEqual) {
            $compareResult.Status = "NotEqual"
        } else {
            $compareResult.Status = "Equal"
        }
        $compareResultList += $compareResult
    }
}
catch {
    Write-Error "An error ocurred."
    Write-Error ($_ | Out-String)
}
finally {
    $compareResultList | Export-Csv -Path (Join-Path $PSScriptRoot "autorest-powershell-sdk-compare.csv") -NoClobber
}