
## Function exception
+ Function的目标是功能正确，结果是预期的。我们应该假设Function执行是正确的，执行结果是预期的。所以function本身不需要处理异常。
+ 调用者应该假设Function是有异常的，需要处理异常。这种所以应用调用，一个应用调用可能是有多个function组成的。
+ Function直接相互调用不属于应用调用
```javascript
async function PostAsync(url = '', data = {}) {
    //url = url.concat(`?api-version=ApiVersion`)
    url = WEBHOST + url;
    const response = await fetch(url, {
        method: 'POST',
        cache: 'no-cache',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    });
    return response;
}

async function DressCreateAsync(newDress = {}) {
        return await PostAsync('/dress', newDress);
}
  //异常在调用者中处理
 function createDress() {
      let dressObject = {
          "name": $('#name').val(),
          "description": $('#description').val(),
          "inventory": $('#inventory').val(),
          "remaining": $('#remaining').val(),
          "category": $('#category').val(),
          "size": $('#size').val(),
      }
     DressCreateAsync(dressObject).then((response) => {
         if (!response.ok) {
             console.log("Create failed");
         } else {
             console.log("Create successful")
         }
     }).catch((error) => {
         console.log("error")
     });
  }
```

## Service response
```json
{
    "status": "success"|"failed",
    "message": "operation information for use",
    "data": object
}
```
```csharp
    public class HttpResponseBodySchema
    {
        public HttpResponseBodyType Status { get; set; }
        public string? Message { get; set; }
        public object? Data { get; set; }
    }

    public enum HttpResponseBodyType
    {
        Failed = 0,
        Success
    }
```

## Database
### Data operations 
+ Create
+ Update
+ Read
+ Delete

### EF Core
只使用与数据操作相关的特性

# 应用错误
应用错误应分为用户操作错误和程序异常
+ 用户操作错误，应提示正确的操作
+ 程序异常，输入程序Bug, 应修复

## 序列化
+ 属性为空，就是没有包含该属性，清空属性值使用空字符串。

# 淘宝产品图片尺寸规定？多少才是最佳？
商品图片的尺寸：宽500*高500像素，大小在120KB以内，要求JPG或GIF格式，到发布宝贝页面上上传图片。

https://www.maijia.com/article/524136