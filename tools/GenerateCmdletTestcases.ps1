# Design
# 1. Geneterate test cases of the cmdlet base on the cmdlet doc.
# 2. Get variations and examples of cmdlets. They must be guaranteed to be in the same order.
# 4. Parse example, include parameter value.
class CmdletItem {
    [string]$Variant
    [string]$TestItemScript
    [string[]]$Examples
    [string[]]$TestCases
}

class Cmdlet {
    [string]$Name
    [string]$TestScript
    [CmdletItem[]]$Items
}

$cmdletCollection = @()

$variableConfigurations = @{
    Tenant = '$env.Tenant';
    Subscription = '$env.SubscriptionId';
    ResourceGroupName = '$env.resourceGroupName';
    Location = '$env.location';
}

$testScriptFormat = "Describe 'cmdlet' {`ntest`n}"
$testCaseScriptFormat = "`tIt 'variant' {`n`t`t{`ntestcases`n`t`t} | Should -Not -Throw`n`t}"

foreach($file in (Get-ChildItem -Path (Join-Path $PSScriptRoot ./docs) -Exclude 'Az.*','README.md')) {
    $cmdlet = [Cmdlet]::new()
    $cmdlet.Name = $file.Name.Split('.')[0]
    $cmdletDocText = (Get-Content -Path $file.FullName) | Out-String
    $cmdletSytanxs = $cmdletDocText.Substring($cmdletDocText.IndexOf('## SYNTAX'), $cmdletDocText.IndexOf('## DESCRIPTION') - $cmdletDocText.IndexOf('## SYNTAX')).Split([System.Environment]::NewLine,[System.StringSplitOptions]::RemoveEmptyEntries)
    $cmdletExamples = $cmdletDocText.Substring($cmdletDocText.IndexOf('## EXAMPLES'), $cmdletDocText.IndexOf('## PARAMETERS') - $cmdletDocText.IndexOf('## EXAMPLES')).Split([System.Environment]::NewLine,[System.StringSplitOptions]::RemoveEmptyEntries)
    # Get variant for the cmdlet sytanx
    $isExistVaruant = $false
    foreach($sytanx in $cmdletSytanxs) {
        if ($sytanx -match '###') {
            $isExistVaruant = $true
            $cmdletItem = [CmdletItem]::new()
            $cmdletItem.Variant = $sytanx.Split(' ')[1]
            $cmdlet.Items += $cmdletItem
        }
    }
    # Only default variant. But not display in doc file. This scenario exists in the New cmdlet
    if(!$isExistVaruant) {
        $cmdletItem = [CmdletItem]::new()
        $cmdletItem.Variant = 'default'
        $cmdlet.Items += $cmdletItem
    }
    # variant index for keep vaiant and example keep in same order.
    $variantIndex = 0
    for($index=0; $index -lt $cmdletExamples.Length; $index++) {
        if($cmdletExamples[$index] -match '```powershell') {
            $index++ # Skip ```powershell line
            do {
                Write-Warning $cmdlet.Name
                $cmdlet.Items[$variantIndex].Examples += $cmdletExamples[$index]
            }until ($cmdletExamples[++$index] -match '```')
            $variantIndex++
            if ($variantIndex -ge $cmdlet.Items.Length) {
                break
            }
        }
    }

    $cmdletCollection += $cmdlet
}

# Convert example to test case and generate test script
foreach($cmdlet in $cmdletCollection) {
    foreach($item in $cmdlet.Items) {
        for($index = 0; $index -lt $item.Examples.Length; $index++) {
            $item.TestCases += $item.Examples[$index] # TODO: Later add convert logicl.
        }
        # Add three Tab(`t`t`t) when generate test item script for file format
        $item.TestItemScript = $testCaseScriptFormat.Replace('variant', $item.Variant).Replace('testcases', ($item.Examples | ForEach-Object {"`t`t`t$_"}) -join "$([System.Environment]::NewLine)")
    }

    $cmdlet.TestScript = $testScriptFormat.Replace('cmdlet', $cmdlet.Name).Replace('test', ($cmdlet.Items.TestItemScript -join "$([System.Environment]::NewLine)$([System.Environment]::NewLine)"))
}

# Insert cmdlet test to cmdlet test ps1 file.
foreach($cmdlet in $cmdletCollection) {
    $cmdletTestPs1File = (Join-Path $PSScriptRoot "./test/$($cmdlet.Name).Tests.ps1")
    $cmdletTestPs1Content = Get-Content -Path $cmdletTestPs1File  | Out-String
    $cmdletTestPs1Content -replace "Describe((.|`n)*)", $cmdlet.TestScript | Set-Content -Path $cmdletTestPs1File
}

$cmdletCollection.Items | Format-Table -AutoSize