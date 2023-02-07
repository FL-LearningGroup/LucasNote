Write-Host "load logger script. Record log to $($args[0])"
if ([System.String]::IsNullOrEmpty($args[0])) {
    throw "Must specify logger file for loging to record log information"
}
if (Test-Path -Path $args[0]) {
    Clear-Content -Path $args[0]
} else {
     New-Item -Path $args[0]
}

function LogInfomation {
    param (
        [parameter(Mandatory)]
        [string]
        $Message
    )
    Write-Host -ForegroundColor Green  -Message "[Information] $Message"
    Add-Content -Path $args[0] -Value "[Information] $Message"
}

function LogError {
    param (
        [parameter(Mandatory)]
        [string]
        $Message
    )
    Write-Error -Message "[Error] $Message"
    Add-Content -Path $args[0] -Value "[Error] $Message"
}