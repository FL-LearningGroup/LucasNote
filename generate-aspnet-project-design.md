model
  - property
    - type
DataBase
  - model
    - tableName: name
    - columns
      - property
        - columnName
        - key
Web
  - model

```json
{
  "models": {
    "entity: " {
      "properties": {
        "sysId":{
          "type":"string",
          "support-op": "create",
          "format":"strLength_36",
        },
        "createTime": {
          "type": "string",
          "support-op": "create",
          "format": "regex_[0-9]{4}/[0-9]{2}/[0-9]{2}\s[0-4]{2}:[0-9]{2}:[0-9]{2}"
        },
        "updateTime": {
          "type": "string",
          "support-op": "create_update",
          "format": "regex_[0-9]{4}/[0-9]{2}/[0-9]{2}\s[0-4]{2}:[0-9]{2}:[0-9]{2}"
        }
      },
      "require": [
        "sysid",
        "createTime",
        "updateTime"
      ]
    },
    "dress": {
      "inherit": "./entity",
      "properties": {
        "name": {
          "type": "string",
          "support-op":"create_update"
        },
        "category": {
          "type": "string",
          "support-op":"create_update"
        },
      }
    }
  }
}
```