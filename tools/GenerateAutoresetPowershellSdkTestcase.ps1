try {
    $testcaseFolderPath = "C:\Users\v-diya\repository\AutorestSdkSupport\sdk-test\autorest.powershell\tests-upgrade\tests-sdk1-support"
    $testcaseTemplate = "### Tag: {testcase}.csharp
``````yaml `$(tag) == '{testcase}.csharp'
csharp: true
input-file:
    - .\{testcase}\swagger.json

namespace: Microsoft.Azure.Sample
output-folder: {testcase}\csharp
``````

### Tag: {testcase}.powershell

``````yaml `$(tag) == '{testcase}.powershell'
isSdkGenerator: true
powershell: true
input-file:
    - .\{testcase}\swagger.json

namespace: Microsoft.Azure.Sample
output-folder: {testcase}\powershell
``````"
    Clear-Content -Path ./autorest.powershell.test.md -Force
    $testcaseNameArrary = (Get-ChildItem -Path $testcaseFolderPath -Directory -Exclude provider-*).Name | Sort-Object $_
    foreach($testcaseName in $testcaseNameArrary) {
        $testcaseSytanx = $testcaseTemplate -replace "{testcase}", $testcaseName
        Add-Content -Path ./autorest.powershell.test.md -Value $testcaseSytanx
    }

} catch {
    Write-Error "An error been thrown"
    Write-Error ($_ | Out-String)
}