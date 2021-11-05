create procedure PROC_GnerateMockData(in customerCountParam int, in goodsCountParam int, in clearMockData int)
begin
declare count_goodsCategory int;
declare maxid_goods int unsigned;
declare goodsSysid binary(16);
declare loopCount int unsigned; 

-- For data plausibility
-- CustomerBirthday row count = customerCountParam * 2
-- CustomerDelivery row count = customerCountParam * 3
-- GoodsSpec row count  = goodsCountParam * 4
-- OrderHistory row count = goodsCountParam * 4
-- OrderGoodsHistory row count = goodsCountParam * 8

-- Clear mock data if the clearMockData greater to 0.
if clearMockData then
truncate table Customer;
truncate table CustomerBirthday;
truncate table CustomerDelivery;
truncate table Goods;
truncate table GoodsSpec;
truncate table GoodsCategory;
truncate table GoodsExtension;
truncate table OrderHistory;
truncate table OrderGoodsHistory;
end if;

-- Generate Table Customer data
set loopCount = 1;
while loopCount <= customerCountParam do
insert into Customer(PhoneNumber, Name, Points) values (CONCAT('1',FLOOR(RAND() * 10000000000)), FUNC_GenerateRandomChinese(FLOOR( 2 + RAND() * 2)), FLOOR(RAND() * 10000));
set loopCount = loopCount + 1;
end while;

-- Generate table CustomerBirthday
set loopCount = 1;
while loopCount <= customerCountParam * 2 do
insert into CustomerBirthday(CustomerSysId, BirthdayDate, Relation)
select SysId, DATE_SUB(CURDATE(), INTERVAL FLOOR(1 + RAND() * 29) YEAR), '亲人'
from Customer
order by RAND() LIMIT 1;
set loopCount = loopCount + 1;
end while;

-- Generate table CustomerDelivery
set loopCount = 1;
while loopCount <= customerCountParam * 3 do
insert into CustomerDelivery(CustomerSysId, ContactNumber, Address, Role)
select SysId, CONCAT('1',FLOOR(RAND() * 10000000000)), CONCAT(FUNC_GenerateRandomChinese(FLOOR(10 + RAND() * 10)),';',FUNC_GenerateRandomChinese(FLOOR(4 + RAND() * 4))), 'optional'
from Customer
order by RAND() LIMIT 1;
set loopCount = loopCount + 1;
end while;

-- Gnerate Table GoodsCategory data
select Count(*) into count_goodsCategory from GoodsCategory;
if count_goodsCategory = 0 or (count_goodsCategory is null) then
insert into GoodsCategory(Category) values 
('蛋糕'),
("面包");

insert into GoodsCategory( ParentSysId, Category) 
select Sysid, '鲜奶油蛋糕' from GoodsCategory 
where Category = "蛋糕";

insert into GoodsCategory( ParentSysId, Category) 
select Sysid, '水果蛋糕' from GoodsCategory 
where Category = "蛋糕";

insert into GoodsCategory( ParentSysId, Category) 
select Sysid, '巧克力蛋糕' from GoodsCategory 
where Category = "蛋糕";

insert into GoodsCategory( ParentSysId, Category) 
select Sysid, '黑森林蛋糕' from GoodsCategory 
where Category = "蛋糕";

insert into GoodsCategory( ParentSysId, Category) 
select Sysid, '慕斯蛋糕' from GoodsCategory 
where Category = "蛋糕";

insert into GoodsCategory( ParentSysId, Category) 
select Sysid, '芝士蛋糕' from GoodsCategory 
where Category = "蛋糕";

insert into GoodsCategory( ParentSysId, Category) 
select Sysid, '提拉米苏' from GoodsCategory 
where Category = "蛋糕";

insert into GoodsCategory( ParentSysId, Category) 
select Sysid, '吐司' from GoodsCategory 
where Category = "面包";

insert into GoodsCategory( ParentSysId, Category) 
select Sysid, '牛角面包' from GoodsCategory 
where Category = "面包";

insert into GoodsCategory( ParentSysId, Category) 
select Sysid, '全麦面包' from GoodsCategory 
where Category = "面包";

insert into GoodsCategory( ParentSysId, Category) 
select Sysid, '杂粮面包' from GoodsCategory 
where Category = "面包";

end if;

-- Gnerate Table Goods data
set loopCount = 1;
while loopCount <= goodsCountParam do
insert into Goods(ZhName, EnName, Description, Status) values 
(CONCAT("蛋糕-",FUNC_GenerateRandomChinese(FLOOR( 2 + RAND() * 2))), FUNC_GenerateRandomEnglish(FLOOR( 10 + RAND() * 3)), "{comments:\"美味蛋糕值得等待\", material: \"奶油;鸡蛋\",}", "OnShelf");

insert into Goods(ZhName, EnName, Description, Status) values 
(CONCAT("面包-",FUNC_GenerateRandomChinese(FLOOR( 2 + RAND() * 2))), FUNC_GenerateRandomEnglish(FLOOR( 10 + RAND() * 3)), "{comments:\"蓬松，美味的面包\", material: \"奶油;鸡蛋\",}", "OnShelf");
set loopCount = loopCount + 1;
end while;

-- Generate Table GoodsSpec
set loopCount = 1;
while loopCount <= goodsCountParam * 4 do
insert into GoodsSpec(GoodsSysid, Size, Layer, Price, Dinnerware) 
select SysId , CONCAT(FLOOR(6 + RAND() * 6)), FLOOR(1 + RAND() * 12), ROUND(RAND() * 1000, 2), CONCAT(FLOOR(1 + RAND() * 9),"套餐具")
from Goods order by RAND() limit 1;
set loopCount = loopCount + 1;
end while;

-- Generate Table GoodsExtension

select MAX(Id) into maxid_goods
from Goods;

while maxid_goods >= 1 do
    select SysId into goodsSysid
    from Goods
    where Id = maxid_goods;

    if goodsSysid is not null then
        insert into GoodsExtension(GoodsSysid, Type, TargetSysId)
        select goodsSysid, 'Category', SysId
        from GoodsCategory
        where ParentSysId is not null
        order by RAND() LIMIT 1;
    end if;
    set maxid_goods = maxid_goods - 1;
end while;

-- Generate Table OrderHistory
-- The customer may not has  delivery address.
set loopCount = 1;
while loopCount <= goodsCountParam * 4 do
    insert into OrderHistory(CreateDate, CustomerPhoneNumber, CustomerName, DeliveryAddress, DeliveryDateTime, Receipt, Price, Comments)
    select CURRENT_TIMESTAMP(), c.PhoneNumber, c.Name, cda.Address, DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL FLOOR(2 + RAND() * 5) DAY),
    CONCAT(FUNC_GenerateRandomChinese(FLOOR(10 + RAND() * 10)),';',FUNC_GenerateRandomChinese(FLOOR(4 + RAND() * 4))) Receipt,
    ROUND(RAND()*1000, 2), FUNC_GenerateRandomChinese(FLOOR(10 + RAND() * 100))
    from CustomerDelivery cda
    inner join Customer c
    on cda.CustomerSysId = c.SysId;
    set loopCount = loopCount + 1;
end while;


-- Genertae Table OrderGoodsHistory
set loopCount = 1;
while loopCount <= goodsCountParam * 8 do
insert into OrderGoodsHistory(OrderSysId, GoodsSysId, GoodsZhName, GoodsSpec, GoodsPrice, GoodsCard)
select UUID_TO_BIN(UUID()), g.SysId, g.ZhName, CONCAT(gs.Size,'寸', ';', gs.Layer, '层'), gs.Price, CONCAT('生日快乐',FUNC_GenerateRandomChinese(FLOOR(2 + RAND() * 10)))
from GoodsSpec gs
inner join Goods g
on gs.GoodsSysid = g.SysId;
set loopCount = loopCount + 1;
end while;

-- Associate and OrderHistory and OrderGoodsHistory
update OrderGoodsHistory
set OrderSysId = (select SysId from OrderHistory order by RAND() LIMIT 1);


-- Error: OrderHistory may be not exists in OrderGoodsHistory
-- update OrderHistory oh
-- set oh.Price = (select SUM(ogh.GoodsPrice), ogh.OrderSysId
--                     from OrderGoodsHistory ogh 
--                     inner join OrderHistory oh 
--                     on ogh.OrderSysId = oh.SysId
--                     group by ogh.OrderSysId) o
-- ;

COMMIT;
end;