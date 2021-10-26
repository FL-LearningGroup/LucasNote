# Requirements

The following prerequisites should be completed before contributing to the Azure PowerShell repository:

- [Install PowerShell(pwsh)](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.1)
> Need to use pwsh to call the command.

- [Install Pester](https://pester-docs.netlify.app/docs/v4/quick-start) v4 <br> use pwsh to execute `Install-Module -Name Pester -RequiredVersion 4.10.1` <br>&nbsp;

- [Install NodeJS LTS](https://nodejs.org) (14.x LTS preferred. Will not function with Node < 10.x. ) 
> if you want an easy way to install and update Node, I recommend [NVS - Node Version Switcher](../nodejs/installing-via-nvs.md) or [NVM - Node Version Manager](../nodejs/installing-via-nvm.md)

- [Install AutoRest](https://aka.ms/autorest) v3 <br> `npm install -g autorest ` <br>&nbsp;

# Environment Setup

## Az Module
If you don't have Az Module.Open powershell, and run the following command:

```powershell
PS C:\> Install-Module -Name Az
```

## Azure Certification

If you don't have sign in to Azure, Open powershell, and run the following command:

```powershell
PS C:\> Connect-AzAccount
PS C:\> Set-AzContext -SubscriptionId "your_subscriptionid
```

## GitHub Basics

If you don't have experience with Git and GitHub, some of the terminology and process can be confusing. [Here is a guide to understanding the GitHub flow](https://guides.github.com/introduction/flow/) and [here is a guide to understanding the basic Git commands](https://education.github.com/git-cheat-sheet-education.pdf).

 you need to clone branch to your local machine. To do so, run the following command:

```
git clone -b <name> https://github.com/Azure/azure-powershell.git
```

You now be able to commit changes, and push commits to branch.

## Generate and build Module

Take [Databricks](https://github.com/Azure/azure-powershell/tree/generation/src/Databricks) module as an example.

Open powershell, navigate to the directory of the Databricks, and run the following command:

```powershell
PS C:\azure-powershell\src\Databricks> autorest
PS C:\azure-powershell\src\Databricks> .\build-module.ps1
```

# Write examples for the commands

Take Databricks module as an example.

Open powershell, navigate to the directory of the Databricks, and run the following command, then enter interactive mode:

```powershell
PS C:\azure-powershell\src\Databricks> .\run-module.ps1
```

Take `Get-AzDatabricksWorkspace` command as an example.

Run `Get-AzDatabricksWorkspace` command and copy the result into the example file of the command. the path of the example is [`Databricks/examples/Get-AzDatabricksWorkspace.md`](https://github.com/Azure/azure-powershell/blob/generation/src/Databricks/examples/Get-AzDatabricksWorkspace.md) and don't forget to add title and description in the example file.

```powershell
PS C:\azure-powershell\src\Databricks [Az.Databricks]> Get-AzDatabricksWorkspace -Name databricks-test -ResourceGroupName testgroup

Location Name            Type
-------- ----            ----
eastus   databricks-test Microsoft.Databricks/workspaces
```

The same command may have different syntax, we need to provide examples for different syntax, we can use the documentation [Databricks/docs/Get-AzDatabricksWorkspace.md](https://github.com/Azure/azure-powershell/blob/generation/src/Databricks/docs/Get-AzDatabricksWorkspace.md) of the command to help see which syntax are provided by the command.

When the example is added for all commands, Run the following command to regenerate the docs help of the commands.

```powershell
PS C:\azure-powershell\src\Databricks> .\build-module.ps1
```

# Write test cases for the commands

Each command has a corresponding test file. The path of the test file is `Module/test/command.Tests.ps1`. All test scripts are in the test directory.

The `Get-AzDatabricksWorkspace` test file is [Databricks/test/Get-AzDatabricksWorkspace.Tests.ps1](https://github.com/Azure/azure-powershell/blob/generation/src/Databricks/test/Get-AzDatabricksWorkspace.Tests.ps1)

**How to Implement Tests**: https://github.com/Azure/azure-powershell/wiki/How-to-On-Board-New-RP-with-Azure-PowerShell-Generator#test

**Live Only Test**

```powershell
Describe 'New-AzDatabricksWorkspace' -Tag 'LiveOnly'{
}
```

**Run Specific Test Cases**

```powershell
./test-module.ps1 -TestName Get-AzDatabricksWorkspace,New-AzDatabricksWorkspace
```