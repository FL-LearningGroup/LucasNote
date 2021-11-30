--DROP PROCEDURE IF EXISTS PROC_GenerateMockData;
create procedure PROC_GenerateMockData(in in_customerCountParam int, in in_goodsCountParam int, in in_clearMockData int, in in_debug int)
begin
declare var_goodsCategoryCount int;
declare var_loopCount int unsigned; 

declare var_customerSysId binary(16);
declare var_customerDeliveryName varchar(45);
declare var_customerDeliveryAddress varchar(255);
declare var_customerDeliveryPhone varchar(11);

declare var_goodsCategorySysId binary(16);
declare var_goodsMaxId int unsigned;
declare var_goodsSysId binary(16);
declare var_goodsZhName varchar(45);

declare var_goodsSpec varchar(45);
declare var_goodsPrice double unsigned;

declare var_orderSysId binary(16);
declare var_orderMaxId int;
declare var_orderPrice double unsigned;

declare var_procName varchar(45);
declare var_executeId varchar(36);
set var_procName = 'PROC_GnerateMockData';
set var_executeId = UUID();

-- For data plausibility
-- CustomerBirthday row count = in_customerCountParam * 2
-- CustomerDelivery row count = in_customerCountParam * 3
-- GoodsSpec row count  = in_goodsCountParam * 4
-- OrderHistory row count = in_goodsCountParam * 4
-- OrderGoodsHistory row count = OrderHistory + in_goodsCountParam * 7

-- Clear mock data if the in_clearMockData greater to 0.
if in_clearMockData then
CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Clear all mock data va Truncate all table ', in_debug);
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

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate Table Customer data', in_debug);
set var_loopCount = 1;
while var_loopCount <= in_customerCountParam do
    insert into Customer(PhoneNumber, Name, Points) values (CONCAT('1',FLOOR(RAND() * 10000000000)), FUNC_GenerateRandomChinese(FLOOR( 2 + RAND() * 2)), FLOOR(RAND() * 10000));
    set var_loopCount = var_loopCount + 1;
end while;
CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate Table Customer data completed', in_debug); 

-- Generate table CustomerBirthday
-- The customer may be exists not has brithday.

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table CustomerBirthday idata', in_debug);
set var_loopCount = 1;
while var_loopCount <= in_customerCountParam * 2 do
    insert into CustomerBirthday(CustomerSysId, BirthdayDate, Relation)
    select SysId, DATE_SUB(CURDATE(), INTERVAL FLOOR(1 + RAND() * 29) YEAR), '亲人'
    from Customer
    order by RAND() LIMIT 1;
    set var_loopCount = var_loopCount + 1;
end while;
CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table CustomerBirthday data completed', in_debug); 

-- Generate table CustomerDelivery
-- The customer may be exists not has delivery.

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table CustomerDelivery idata', in_debug);

set var_loopCount = 1;
while var_loopCount <= in_customerCountParam * 3 do
    insert into CustomerDelivery(CustomerSysId,  ContactName, ContactNumber, Address, Role)
    select SysId, FUNC_GenerateRandomChinese(FLOOR(2 + RAND() * 5)), CONCAT('1',FLOOR(RAND() * 10000000000)), CONCAT(FUNC_GenerateRandomChinese(FLOOR(10 + RAND() * 10)),';',FUNC_GenerateRandomChinese(FLOOR(4 + RAND() * 4))), 'optional'
    from Customer
    order by RAND() LIMIT 1;
    set var_loopCount = var_loopCount + 1;
end while;
CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table CustomerDelivery data completed', in_debug); 

-- Gnerate Table GoodsCategory data

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table GoodsCategory idata', in_debug);
select Count(*) into var_goodsCategoryCount from GoodsCategory;
if var_goodsCategoryCount = 0 or (var_goodsCategoryCount is null) then
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

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table GoodsCategory data completed', in_debug); 

-- Gnerate Table Goods data


CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table Goods idata', in_debug);
set var_loopCount = 1;
while var_loopCount <= in_goodsCountParam do
    -- Constraint: The vaue of the coulum Category of the table GoodsCategory as prefix string of the ZhName value. 
    if var_loopCount < in_goodsCountParam * 0.8 then
        insert into Goods(ZhName, EnName, Description, Status) values 
        (CONCAT("蛋糕-",FUNC_GenerateRandomChinese(FLOOR( 2 + RAND() * 2))), FUNC_GenerateRandomEnglish(FLOOR( 10 + RAND() * 3)), "{comments:\"美味蛋糕值得等待\", material: \"奶油;鸡蛋\",}", "OnShelf");

    else
        insert into Goods(ZhName, EnName, Description, Status) values 
        (CONCAT("面包-",FUNC_GenerateRandomChinese(FLOOR( 2 + RAND() * 2))), FUNC_GenerateRandomEnglish(FLOOR( 10 + RAND() * 3)), "{comments:\"蓬松，美味的面包\", material: \"奶油;鸡蛋\",}", "OnShelf");
    end if;
    set var_loopCount = var_loopCount + 1;
end while;


CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table Goods data completed', in_debug); 

select MAX(Id) into var_goodsMaxId
from Goods;

-- Associate Goods and GoodsCategory via GoodsExtension.
-- Each Goods at least one  GoodsCategory.

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table GoodsExtension data', in_debug); 
set var_loopCount = 1;
while var_loopCount <= var_goodsMaxId do

    Select SysId into var_goodsCategorySysId
    from GoodsCategory
    order by RAND() limit 1;

    insert into GoodsExtension(GoodsSysId, Type, TargetSysId) 
    select SysId, 'Category', var_goodsCategorySysId
    from Goods 
    where Id = var_loopCount;
    set var_loopCount = var_loopCount + 1;
end while;
CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table GoodsExtension data completed', in_debug); 

-- Generate Table GoodsSpec
-- Each goods should has one goods spec;

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table GoodsSpec data', in_debug);
set var_loopCount = 1;
while var_loopCount <= var_goodsMaxId do
    insert into GoodsSpec(GoodsSysid, Size, Layer, Price, Dinnerware) 
    select SysId , CONCAT(FLOOR(6 + RAND() * 6)), FLOOR(1 + RAND() * 12), ROUND(RAND() * 1000, 2), CONCAT(FLOOR(1 + RAND() * 9),"套餐具")
    from Goods 
    where Id = var_loopCount;
    set var_loopCount = var_loopCount + 1;
end while;

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table GoodsSpec data - 2', in_debug);

set var_loopCount = 1;
while var_loopCount <= in_goodsCountParam * 3 do
    insert into GoodsSpec(GoodsSysid, Size, Layer, Price, Dinnerware) 
    select SysId , CONCAT(FLOOR(6 + RAND() * 6)), FLOOR(1 + RAND() * 12), ROUND(RAND() * 1000, 2), CONCAT(FLOOR(1 + RAND() * 9),"套餐具")
    from Goods order by RAND() limit 1;
    set var_loopCount = var_loopCount + 1;
end while;


CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table GoodsSpec data completed', in_debug);  

--Generate Table OrderHistory
--The customer may not has delivery address.

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table OrderHistory idata', in_debug); 
set var_loopCount = 1;
while var_loopCount <= in_goodsCountParam * 4 do
    select cd.CustomerSysId, cd.ContactNumber, cd.ContactNumber, cd.Address into var_customerSysId, var_customerDeliveryName, var_customerDeliveryPhone, var_customerDeliveryAddress
    from CustomerDelivery cd
    order by RAND() LIMIT 1;

    insert into OrderHistory(CreateDate, CustomerPhoneNumber, CustomerName, DeliveryCustomerName, DeliveryPhoneNumber, DeliveryAddress, DeliveryDateTime, Receipt, Price, Comments)
    select DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL FLOOR(1 + RAND() * 99) DAY), c.PhoneNumber, c.Name, var_customerDeliveryName, var_customerDeliveryPhone, var_customerDeliveryAddress, DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL FLOOR(2 + RAND() * 5) DAY),
    CONCAT(FUNC_GenerateRandomChinese(FLOOR(10 + RAND() * 10)),';',FUNC_GenerateRandomChinese(FLOOR(4 + RAND() * 4))),
    ROUND(RAND()*1000, 2), FUNC_GenerateRandomChinese(FLOOR(10 + RAND() * 100))
    from Customer c 
    where c.SysId = var_customerSysId;
    set var_loopCount = var_loopCount + 1;
end while;

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table OrderHistory data completed', in_debug); 

-- Genertae Table OrderGoodsHistory
-- Each Order must has one OrderGoodsHistory

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table OrderGoodsHistory', in_debug); 
select MAX(Id) into var_orderMaxId from OrderHistory;
set var_loopCount = 1;
while var_loopCount <= var_orderMaxId do
    select GoodsSysId, CONCAT(Size,'寸', ';', Layer, '层'), Price into var_goodsSysId, var_goodsSpec, var_goodsPrice
    from GoodsSpec
    order by RAND() LIMIT 1;

    select ZhName into var_goodsZhName
    from Goods
    where SysId = var_goodsSysId;

    insert into OrderGoodsHistory(OrderSysId, GoodsSysId, GoodsZhName, GoodsSpec, GoodsPrice, GoodsCard)
    select oh.SysId, var_goodsSysId, var_goodsZhName, var_goodsSpec, var_goodsPrice, CONCAT('生日快乐',FUNC_GenerateRandomChinese(FLOOR(2 + RAND() * 10)))
    from OrderHistory oh
    where Id = var_loopCount;

    set var_loopCount = var_loopCount + 1;
end while;

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table OrderGoodsHistory data completed - 2', in_debug);
set var_loopCount = 1;
while var_loopCount <= in_goodsCountParam * 7 do
    select GoodsSysId, CONCAT(Size,'寸', ';', Layer, '层'), Price into var_goodsSysId, var_goodsSpec, var_goodsPrice
    from GoodsSpec
    order by RAND() LIMIT 1;

    select ZhName into var_goodsZhName
    from Goods
    where SysId = var_goodsSysId;

    select SysId into var_orderSysId
    from OrderHistory
    order by RAND() LIMIT 1;

    insert into OrderGoodsHistory(OrderSysId, GoodsSysId, GoodsZhName, GoodsSpec, GoodsPrice, GoodsCard)
    values(var_orderSysId, var_goodsSysId, var_goodsZhName, var_goodsSpec, var_goodsPrice, CONCAT('生日快乐',FUNC_GenerateRandomChinese(FLOOR(2 + RAND() * 10))));

    set var_loopCount = var_loopCount + 1;
end while;

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Generate table OrderGoodsHistory data completed', in_debug); 

-- update total price of the OrderHistory


CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Update price OrderHistory', in_debug);
set var_loopCount = 1;
while var_loopCount <= var_orderMaxId do
    select SysId into var_orderSysId
    from OrderHistory
    where Id = var_loopCount;

    select SUM(GoodsPrice) into var_orderPrice 
    from OrderGoodsHistory
    where OrderSysId = var_orderSysId
    group by OrderSysId;

    update OrderHistory
    set Price = var_orderPrice
    where SysId = var_orderSysId;

    set var_loopCount = var_loopCount + 1;
end while;

CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Update price OrderHistory completed', in_debug); 

COMMIT;
CALL PROC_Dev_SqlExecutedHistory(var_executeId,var_procName, 'Commited, Generate mock data compeleted.', in_debug);
end;