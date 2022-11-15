# Entity Model
```json
{
    "sysId": {
        "type": "text",
        "description": "system unique indetity.",
        "readyOnly": true
    },
    "createTime": {
        "type":"datetime",
        "description": "system create time.",
        "readyOnly": true
    },
    "updateTime": {
        "type":"datetime",
        "description": "system create time.",
        "readyOnly": true
    },
}

```
# Dress Model
```json
{
    "name": {
        "type": "text",
        "description": "dress name."
    },
    "images": {
        "type": "array",
        "description": "collection includes dress images."
    },
    "description": {
        "type": "text",
        "description": "dress detail information."
    },
    "price": {
        "type":"number",
        "description":"dress price."
    },
    "DressSize": {
        "type": "array",
        "description": "dress size and dress inventory.",
        "items": {
            "$ref": "#/DressSize
        }
    }
}
```

# DressSize model
```json
{
    "size": {
        "type":"number",
        "description":"dress szie, for example, X,XXl"
    },
    "inventory": {
        "type": "number",
        "description": "size inventory"
    }
}

```

# User model
```json
{
    "id" : {
        "type": "string",
        "description": "user unique identity."
    },
    "name": {
        "type": "text",
        "description":"user name"
    },
    "phone": {
        "type": "text",
        "description": "user phone number",
    },
    "webxinId": {
        "type": "text",
        "description": "user weixin id" 
    },
    "address": {
        "type": "array",
        "items": {
            "type": "string"
        }
    }
}
```

# Order model
```json
{
    "orderNumber": {
        "type": "string",
        "description": "order serial number"
    },
    "userId": {
        "type": "string",
        "description": "user unique identity."
    },
    "userPhone": {

    },
    "
}
```