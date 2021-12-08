drop table if exists User;
create table if not exists User (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    Account varchar(45) not null unique,
    Password varchar(255) not null,
    Role enum('Admin', 'User') not null comment "admin allow to manage goods, user allow to only quer data.",
    index idx_account (Account)
)ENGINE=INNODB;

drop table if exists Customer;

create table if not exists Customer (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    PhoneNumber varchar(11) not null unique,
    Name varchar(45) not null,
    Points int unsigned not null default(0) comment "Customer's points after bought.",
    index idx_phoneNum (PhoneNumber)
)engine=INNODB;


drop table if exists CustomerBirthday;

create table if not exists CustomerBirthday (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    CustomerSysId binary(16) not null,
    BirthdayDate date,
    Relation varchar(45),
    index idx_usersysid (CustomerSysId)
)engine=INNODB;

drop table if exists CustomerDelivery;

create table if not exists CustomerDelivery (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    CustomerSysId binary(16) not null,
    ContactName varchar(45) not null,
    ContactNumber varchar(11) not null,
    Address varchar(255) not null,
    Role enum('default','optional') not null,
    index idx_usersysid (CustomerSysId)
)engine=INNODB;


drop table if exists Goods;

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

drop table if exists GoodsExtension;

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

drop table if exists GoodsSpec;

create table if not exists GoodsSpec (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    GoodsSysid binary(16) not null,
    Size int unsigned not null,
    Layer int unsigned not null default(1),
    Price decimal(5,2) not null,
    Dinnerware varchar(255) not null,
    index idx_goodssysid (GoodsSysid)
)engine=INNODB;


drop table if exists GoodsCategory;

create table if not exists GoodsCategory (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    Category varchar(45) not null unique,
    ParentSysId binary(16),
    index idx_parentSysId (ParentSysId)
)engine=INNODB;

drop table if exists OrderHistory;

create table if not exists OrderHistory (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    CreateDate datetime not null,
    CustomerPhoneNumber varchar(11) not null,
    CustomerName varchar(45) not null,
    DeliveryCustomerName varchar(45) not null,
    DeliveryPhoneNumber varchar(11) not null,
    DeliveryAddress varchar(255) not null,
    DeliveryDateTime timestamp not null,
    Receipt varchar(255) not null,
    Price float unsigned not null,
    Comments text,
    index idx_custome (CustomerPhoneNumber, CustomerName)
)engine=INNODB;

drop table if exists OrderGoodsHistory;

create table if not exists OrderGoodsHistory (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID())),
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    OrderSysId binary(16) not null,
    GoodsSysId binary(16) not null,
    GoodsZhName varchar(45) not null,
    GoodsSpec varchar(45) not null,
    GoodsPrice decimal(5,2) not null,
    GoodsCard varchar(45),
    index idx_goods (GoodsSysId, GoodsZhName)
)engine=INNODB;

drop table if exists Dev_SqlExecutedHistory;

create table if not exists Dev_SqlExecutedHistory(
    Id int unsigned AUTO_INCREMENT primary key,
    SysDate timestamp not null default CURRENT_TIMESTAMP,
    ExecuteId   varchar(36) not null,
    Name varchar(45) not null,
    Message text,
    index idx_01 (ExecuteId, Name)
)engine=INNODB;