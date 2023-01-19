class VariantParameter {
    [string]$Name
    [string]$Type
}

class Variant {
    [string]$Name
    [string]$CmdletSytanx
    [VariantParameter[]]$Parameters
}

class Sytanx {
    [string]$CmdletName
    [Variant[]]$Variants
}
$skipParameterName = @('DefaultProfile','AsJob','NoWait','Confirm','WhatIf','CommonParameters')
[Sytanx]$sytanx = [Sytanx]::new()
$sytanx.CmdletName = 'New-AzRelayNamespace'
# $docContent = Get-Content -Path './New-AzDatabricksWorkspace.md' -Raw
$docContent = Get-Content -Path './New-AzRelayNamespace.md' -Raw
$sytanxContent = ($docContent.Substring($docContent.IndexOf('## SYNTAX'), $docContent.IndexOf('## DESCRIPTION') - $docContent.IndexOf('## SYNTAX'))) -replace '[\s|\n|\t]', ''
if ($sytanxContent.Contains('###')) {
    $variants = ($sytanxContent -split '###') | Where-Object {$_ -like '*``````*'}
    foreach($variant in $variants) {
        [Variant]$variantObject = [Variant]::new()
        $variantObject.Name = ((($variant -split ("``````"))[0]) -replace "\(.*", "").Trim(' ')
        $variantObject.CmdletSytanx = (($variant -split ("``````"))[1])
        $sytanx.Variants += $variantObject
    }
} else {
    [Variant]$variantObject = [Variant]::new()
    $variantObject.Name = 'Default'
    $variantObject.CmdletSytanx = ($sytanxContent -split ("``````"))[1]
    $sytanx.Variants += $variantObject
}
foreach($variant in $sytanx.Variants) {
    $paras = ((($variant.CmdletSytanx -replace '\[\]','()') -replace '[\[|\]|>]','') -split '-' | Where-Object {$_ -like '*<*'})
    $paras = $paras -replace '\(\)','[]'
    foreach($para in $paras) {
        [VariantParameter]$variantPara = [VariantParameter]::new()
        $paraArray = ($para -split '<')
        $variantPara.Name = $paraArray[0]
        $variantPara.Type = $paraArray[1]
        if ($skipParameterName -contains $variantPara.Name) {
            continue
        }
        $variant.Parameters += $variantPara
    }
}
Write-Host "test"