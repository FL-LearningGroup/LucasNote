create table if not exists User (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    Account varchar(45) not null unique,
    Password varchar(255) not null,
    Role varchar(45) not null,
    index idx_account (Account)
)ENGINE=INNODB;

insert into User (Account, Password,Role) values('admin','admin123','admin');

select BIN_TO_UUID(SysId) as sysid from User;

-- drop table User;


create table if not exists Customer (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    PhoneNumber varchar(11) not null unique,
    Name varchar(45) not null,
    Points int unsigned not null default(0),
    index idx_phoneNum (PhoneNumber)
)engine=INNODB;

-- drop table Customer;
-- truncate table Customer;

select CONCAT('1',FLOOR(RAND() * 10000000000));

select FLOOR(RAND()*1000);

select substring(MD5(RAND()),1,20);

SELECT CHAR(0x0100 USING ucs2),CHAR(0x0101 USING ucs2),CHAR(0x0200 USING ucs2),CHAR(0x0201 USING ucs2);

insert into Customer(PhoneNumber, Name, Points) values (CONCAT('1',FLOOR(RAND() * 10000000000)),  concat(
    substring('赵钱孙李周吴郑王冯陈诸卫蒋沈韩杨朱秦尤许何吕施张孔曹严华金魏陶姜戚谢邹喻柏水窦章云苏潘葛奚范彭郎鲁韦昌马苗凤花方俞任袁柳酆鲍史唐费廉岑薛雷贺倪汤滕殷罗毕郝邬安常乐于时傅皮齐康伍余元卜顾孟平黄和穆萧尹姚邵堪汪祁毛禹狄米贝明臧计伏成戴谈宋茅庞熊纪舒屈项祝董粱杜阮蓝闵席季麻强贾路娄危江童颜郭梅盛林刁钟徐邱骆高夏蔡田樊胡凌霍虞万支柯咎管卢莫经房裘干解应宗丁宣贲邓郁单杭洪包诸左石崔吉钮龚',floor(1+190*rand()),1),
    substring('明国华建文平志伟东海强晓生光林小民永杰军金健一忠洪江福祥中正振勇耀春大宁亮宇兴宝少剑云学仁涛瑞飞鹏安亚泽世汉达卫利胜敏群波成荣新峰刚家龙德庆斌辉良玉俊立浩天宏子松克清长嘉红山贤阳乐锋智青跃元武广思雄锦威启昌铭维义宗英凯鸿森超坚旭政传康继翔栋仲权奇礼楠炜友年震鑫雷兵万星骏伦绍麟雨行才希彦兆贵源有景升惠臣慧开章润高佳虎根远力进泉茂毅富博霖顺信凡豪树和恩向道川彬柏磊敬书鸣芳培全炳基冠晖京欣廷哲保秋君劲轩帆若连勋祖锡吉崇钧田石奕发洲彪钢运伯满庭申湘皓承梓雪孟其潮冰怀鲁裕翰征谦航士尧标洁城寿枫革纯风化逸腾岳银鹤琳显焕来心凤睿勤延凌昊西羽百捷定琦圣佩麒虹如靖日咏会久昕黎桂玮燕可越彤雁孝宪萌颖艺夏桐月瑜沛诚夫声冬奎扬双坤镇楚水铁喜之迪泰方同滨邦先聪朝善非恒晋汝丹为晨乃秀岩辰洋然厚灿卓杨钰兰怡灵淇美琪亦晶舒菁真涵爽雅爱依静棋宜男蔚芝菲露娜珊雯淑曼萍珠诗璇琴素梅玲蕾艳紫珍丽仪梦倩伊茜妍碧芬儿岚婷菊妮媛莲娟一',floor(1+400*rand()),1),
    substring('明国华建文平志伟东海强晓生光林小民永杰军金健一忠洪江福祥中正振勇耀春大宁亮宇兴宝少剑云学仁涛瑞飞鹏安亚泽世汉达卫利胜敏群波成荣新峰刚家龙德庆斌辉良玉俊立浩天宏子松克清长嘉红山贤阳乐锋智青跃元武广思雄锦威启昌铭维义宗英凯鸿森超坚旭政传康继翔栋仲权奇礼楠炜友年震鑫雷兵万星骏伦绍麟雨行才希彦兆贵源有景升惠臣慧开章润高佳虎根远力进泉茂毅富博霖顺信凡豪树和恩向道川彬柏磊敬书鸣芳培全炳基冠晖京欣廷哲保秋君劲轩帆若连勋祖锡吉崇钧田石奕发洲彪钢运伯满庭申湘皓承梓雪孟其潮冰怀鲁裕翰征谦航士尧标洁城寿枫革纯风化逸腾岳银鹤琳显焕来心凤睿勤延凌昊西羽百捷定琦圣佩麒虹如靖日咏会久昕黎桂玮燕可越彤雁孝宪萌颖艺夏桐月瑜沛诚夫声冬奎扬双坤镇楚水铁喜之迪泰方同滨邦先聪朝善非恒晋汝丹为晨乃秀岩辰洋然厚灿卓杨钰兰怡灵淇美琪亦晶舒菁真涵爽雅爱依静棋宜男蔚芝菲露娜珊雯淑曼萍珠诗璇琴素梅玲蕾艳紫珍丽仪梦倩伊茜妍碧芬儿岚婷菊妮媛莲娟一',floor(1+400*rand()),1)),
    FLOOR(RAND()*1000));

select * from Customer;

create table if not exists CustomerBirthday (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    CustomerSysId binary(16) not null,
    BirthdayDate date,
    Relation varchar(45),
    index idx_usersysid (CustomerSysId)
)engine=INNODB;

create table if not exists CustomerDelivery (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    CustomerSysId binary(16) not null,
    ContactNumber varchar(11) not null,
    Address varchar(255) not null,
    Role enum('default','optional'),
    index idx_usersysid (CustomerSysId)
)engine=INNODB;


create table if not exists Goods (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    ZhName varchar(45) not null,
    EnName varchar(45) not null unique,
    Description text,
    Status enum('OnShelf', 'OffShelf'),
    index idx_enname (EnName) 
)engine=INNODB;

-- drop table Goods;
-- truncate table Goods;

insert into Goods(ZhName, EnName, Type, Description, Statue) values ();

create table if not exists GoodsExtension (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    GoodsSysId binary(16) not null,
    Type varchar(45) not null,
    TargetSysId binary(16) not null,
    index idx_goodsysid (GoodsSysId),
    index idx_targetsysid (TargetSysId)
)engine=INNODB;


create table if not exists GoodsSpec (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    GoodsSysid binary(16) not null,
    Size int unsigned not null,
    Layer int unsigned not null default(1),
    Price double unsigned not null,
    Dinnerware varchar(255) not null,
    index idx_goodssysid (GoodsSysid)
)engine=INNODB;


create table if not exists GoodsCategory (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    Category varchar(45) not null unique,
    ParentSysId binary(16),
    index idx_parentSysId (ParentSysId)
)engine=INNODB;


create table if not exists OrderHistory (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    CreateDate datetime not null,
    CustomerPhoneNumber varchar(11) not null,
    CustomerName varchar(45) not null,
    DeliveryPhoneNumber varchar(11) not null,
    DeliveryAddress varchar(255) not null,
    DeliveryDateTime timestamp not null,
    Receipt varchar(255) not null,
    Price double unsigned not null,
    Comments text,
    index idx_custome (CustomerPhoneNumber, CustomerName)
)engine=INNODB;

create table if not exists OrderGoodsHistory (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    OrderSysId binary(16) not null,
    GoodsSysId binary(16) not null,
    GoodsZhName varchar(45) not null,
    GoodsSpec varchar(45) not null,
    GoodsPrice double unsigned not null,
    GoodsCard varchar(45),
    index idx_goods (GoodsSysId, GoodsZhName)
)engine=INNODB;


-- Mock temporary table for test
create temporary table if not exists TempGoodsMockData (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    ZhName varchar(45) not null,
    EnName varchar(45) not null unique
);

-- drop table TempGoodsMockData;
select * from TempGoodsMockData;

-- insert into TempGoodsMockData(ZhName, EnName) values 
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

create table if not exists Dev_SqlExecutedHistory(
    Id int unsigned AUTO_INCREMENT primary key,
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    ExecuteId   varchar(36) not null,
    Name varchar(45) not null,
    Message text,
    index idx_01 (ExecuteId, Name)
)engine=INNODB;

select CHAR_LENGTH("啊实打实大苏打")；
select SUBSTRING("啊实打实大苏打", FLOOR(rand() * CHAR_LENGTH("啊实打实大苏打")), 1);
select (CAST(RAND() * (3-1) AS UNSIGNED) + 1);

select ROUND(RAND() * 1000, 2);
select RAND() LIMIT 1;
select DATE_SUB(CURDATE(), INTERVAL FLOOR(1 + RAND() * 29) YEAR);
select FUNC_GenerateRandomChinese(200);

Call PROC_GnerateMockData(200, 500, 1,1);

select SUBSTRING("蛋糕-安定哈达沙克", 1, 2);