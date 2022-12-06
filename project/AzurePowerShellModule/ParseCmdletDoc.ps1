class VariantParameter {
    [string]$Name
    [string]$Type
}

class Variant {
    [string]$Name
    [VariantParameter[]]$Parameters
}

class Sytanx {
    [string]$CmdletName
    [Variant[]]$Variant
}

# $docContent = Get-Content -Path './New-AzDatabricksWorkspace.md' -Raw
$sytanxContent = ($docContent.Substring($docContent.IndexOf('## SYNTAX'), $docContent.IndexOf('## DESCRIPTION') - $docContent.IndexOf('## SYNTAX'))) -replace '[\s|\n|\t]', ''
if ($sytanxContent.Contains('###')) {
    $variant = ($sytanxContent -split '###') | Where-Object {$_ -like '*``````*'}
    $variantName = ((($variant[0] -split ("``````"))[0]) -replace "\(.*", "").Trim(' ')
    $variantSytanx = ($variant[0] -split ("``````"))[1]
} else {
    $variantName = 'Default'
    $variantSytanx = ($sytanxContent -split ("``````")[1])
}

$variantSytanx = ($variant[0] -split ("``````"))[1]
Write-Host "test"