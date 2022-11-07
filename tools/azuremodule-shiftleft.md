# Usage 1
1. Clone the generation branch of the azure-powershell repo (https://github.com/Azure/azure-powershell.git).
2. Create module folder under the src folder.
3. Create README.md file in the folder created in the previous step.
4. Add the following configuration in README.md

### AutoRest Configuration
> see https://aka.ms/autorest

``` yaml
branch: commitId
require:
- $(this-folder)/../readme.azure.noprofile.md
- $(repo)/specification/xxx/resource-manager/readme.md
try-require:
- $(repo)/specification/xxx/resource-manager/readme.powershell.md
```

5. In powershell, execute autorest in the module folder to generate the code.
6. In powershell, execute build-module.ps1 build module in the module folder.

# Usage 2
1. Clone the generation branch of the azure-powershell repo (https://github.com/Azure/azure-powershell.git).
2. Create module folder under the src folder.
3. Create README.md file in the folder created in the previous step.
4. Add the following configuration in README.md. The `tag` is defined in each servie readme.powershell.md.

### AutoRest Configuration
> see https://aka.ms/autorest

``` yaml
branch: commitId
tag: TagName
require: 
  - $(this-folder)/../readme.azure.noprofile.md 
  - $(repo)\specification\service1\resource-manager\readme.md 
  - $(repo)\specification\service2\resource-manager\readme.md 
try-require: 
  - $(repo)\specification\service1\resource-manager\readme.powershell.md 
  - $(repo)\specification\service2\resource-manager\readme.powershell.md 
```

5. In powershell, execute autorest in the module folder to generate the code.
6. In powershell, execute build-module.ps1 build module in the module folder.