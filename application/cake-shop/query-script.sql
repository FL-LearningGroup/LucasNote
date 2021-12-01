-- ('悉尼之风', 'Sydney wind'),
-- ('冰雪奇缘', 'Frozen'),
-- ('巧克力物语', 'Sydney wind'),
-- ('鲜果塔', 'Fruit Tower'),
--  ('甜蜜城堡', 'Sweet Castle'),
-- ('马卡龙の吻', 'Macarons kiss'),
-- ('梦の甜', 'Sweet dream'),
-- ('酥心', 'Crisp cake'),
-- ('永恒的心', 'my heart forever'),
-- ('粉红小猪', 'Pink pig'),
-- ('多啦A梦', 'doraemon'),
-- ('米奇', 'Mickey'),
-- ('佩奇', 'Hello Kitty'),
-- ('提拉米苏', 'Tiramisu'),
-- ('恋恋抹茶', "Green tea's love"),
-- ('红薯蛋糕', 'Sweet potato cake'),
-- ('爱的旋律', 'The melody of love'),
-- ('麦哲伦', 'The Magellan Galaxy'),
-- ('果蕾', 'Fruit flavor');

-- Generate mock data.
-- 200 Customer, 500 Goods
Call PROC_GenerateMockData(200, 500, 1,1);

select CHAR_LENGTH("啊实打实大苏打")；
select SUBSTRING("啊实打实大苏打", FLOOR(rand() * CHAR_LENGTH("啊实打实大苏打")), 1);
select (CAST(RAND() * (3-1) AS UNSIGNED) + 1);

select ROUND(RAND() * 1000, 2);
select RAND() LIMIT 1;
select DATE_SUB(CURDATE(), INTERVAL FLOOR(1 + RAND() * 29) YEAR);
select FUNC_GenerateRandomChinese(200);

select UUID_TO_BIN('7754df52-4041-11ec-9315-00155dab0400');

select DATE_FORMAT(SysDate, '%Y-%m-%d %H:%i:%s') sysdate from User;

SELECT * FROM Goods
where SysId = uuid_to_bin('836564e0-50e1-11ec-a36a-00155d2d9679');

select bin_to_uuid(GoodsSysId), Type , bin_to_uuid(TargetSysId) from GoodsExtension
where SysId = uuid_to_bin('9fd0ebc2-50e8-11ec-a36a-00155d2d9679');

select bin_to_uuid(a.sysid) uuid , a.* from GoodsSpec a;

select bin_to_uuid(o.sysid) uuid , o.* from OrderHistory o
where 1=1
and SysId = uuid_to_bin('530ae2cb-2a1a-4cda-8be1-d6c9421dc1d7')
;

select bin_to_uuid(o.sysid) uuid , o.* from OrderHistory o
ORDER BY sysdate;