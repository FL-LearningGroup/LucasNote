# Goods Api 

+ 获取所有产品 Get /api/gooods

+ 获取指定产品 Get /api/goods?id=[id]

## 购物车列表 

+ 添加已加入购物车的商品: post /api/cart

**resonse body:**
{
    goods:IGoods
    spec: IGoodsSpec
}

+ 获取已加入购物车的商品: Get /api/cart
+ 删除已加入购物车的商品: delete /api/cart?id=[goodsId]&specId=[specId]

# User Api

+ 用户登录 Post /api/user/login

+ 编辑和添加地址



