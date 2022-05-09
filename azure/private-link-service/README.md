Private Link Service: https://www.youtube.com/watch?v=PWKM5KXjWno

```powershell
Get-AzPrivateEndpointConnection -ResourceGroupName pl-rg-test -ServiceName webapp20220224

HTTP Method:
GET

Absolute Uri:
https://management.azure.com/subscriptions/9e223dbe-3399-4e19-88eb-0975f02ac87f/resourceGroups/pl-rg-test/providers/Microsoft.Network/privateLinkServices/webapp20220224/privateEndpointConnections?api-version=2021-05-01
```

```powershell
Get-AzPrivateEndpointConnection -PrivateLinkResourceId "/subscriptions/9e223dbe-3399-4e19-88eb-0975f02ac87f/resourceGroups/pl-rg-test/providers/Microsoft.Web/sites/webapp20220424" -Debug

HTTP Method:
GET

Absolute Uri:
https://management.azure.com/subscriptions/9e223dbe-3399-4e19-88eb-0975f02ac87f/resourceGroups/pl-rg-test/providers/Microsoft.Web/sites/webapp20220424/privateEndpointConnections?api-version=2019-08-01
```

```powershell
Get-AzPrivateEndpointConnection -ResourceId "/subscriptions/9e223dbe-3399-4e19-88eb-0975f02ac87f/resourceGroups/pl-rg-test/providers/Microsoft.Web/sites/webapp20220424/privateEndpointConnections/lucasprivateendpoint-2dd7aaea-da5d-458a-93b2-f265092efc8a" -Debug

HTTP Method:
GET

Absolute Uri:
https://management.azure.com/subscriptions/9e223dbe-3399-4e19-88eb-0975f02ac87f/resourceGroups/pl-rg-test/providers/Microsoft.Web/sites/webapp20220424/privateEndpointConnections/lucasprivateendpoint-2dd7aaea-da5d-458a-93b2-f265092efc8a?api-version=2019-08-01
```

```powershell
Get-AzPrivateLinkResource -ResourceGroupName pl-rg-test -ServiceName webapp20220424 -Debug

DEBUG: 3:30:12 PM - GetAzurePrivateLinkResourceCommand begin processing with ParameterSet 'ByResource'.
DEBUG: 3:30:12 PM - using account id 'v-diya@microsoft.com'...
Get-AzPrivateLinkResource: The method or operation is not implemented.
DEBUG: AzureQoSEvent: Module: Az.Network:4.15.0; CommandName: Get-AzPrivateLinkResource; PSVersion: 7.1.4; IsSuccess: False; Duration: 00:00:00.0335118; Exception: The method or operation is not implemented.;
DEBUG: Finish sending metric.
DEBUG: 3:30:13 PM - GetAzurePrivateLinkResourceCommand end processing.
```

```powershell
Get-AzPrivateLinkResource -PrivateLinkResourceId "/subscriptions/9e223dbe-3399-4e19-88eb-0975f02ac87f/resourceGroups/pl-rg-test/providers/Microsoft.Web/sites/webapp20220424" -Debug
HTTP Method:
GET

Absolute Uri:
https://management.azure.com/subscriptions/9e223dbe-3399-4e19-88eb-0975f02ac87f/resourceGroups/pl-rg-test/providers/Microsoft.Web/sites/webapp20220424/privateLinkResources?api-version=2019-08-01
```

-PrivateLinkResourceId "/subscriptions/9e223dbe-3399-4e19-88eb-0975f02ac87f/resourceGroups/pl-rg-test/providers/Microsoft.Network/privateLinkServices/webapp20220424"


Private Endpoint Connection
+ Get By Id
    - /subscriptions/9e223dbe-3399-4e19-88eb-0975f02ac87f/resourceGroups/pl-rg-test/providers/Microsoft.Web/sites/webapp20220424/privateEndpointConnections/lucasprivateendpoint
+ List By self
    - /subscriptions/9e223dbe-3399-4e19-88eb-0975f02ac87f/resourceGroups/pl-rg-test/providers/Microsoft.Web/sites/webapp20220424/privateEndpointConnections
+ List By owner
    - /subscriptions/9e223dbe-3399-4e19-88eb-0975f02ac87f/resourceGroups/pl-rg-test/providers/Microsoft.Web/sites/webapp20220424 (The endpoint connection is included in the returned object)

Private Link resource
+ Get By Id
    - /subscriptions/9e223dbe-3399-4e19-88eb-0975f02ac87f/resourceGroups/pl-rg-test/providers/Microsoft.Web/sites/webapp20220424/privatLinkResource/resourcename
+ List By self
    - /subscriptions/9e223dbe-3399-4e19-88eb-0975f02ac87f/resourceGroups/pl-rg-test/providers/Microsoft.Web/sites/webapp20220424/privatLinkResource