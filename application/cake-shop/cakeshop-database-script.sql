CREATE TABLE IF NOT EXISTS User (
    Id int unsigned AUTO_INCREMENT primary key,
    SysId binary(16) not null unique default(UUID_TO_BIN(UUID(), TRUE)),
    SysDate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Account varchar(45) NOT NULL,
    Password varchar(255) NOT NULL,
    Role varchar(45) NOT NULL,
    index indx_account (Account)
)ENGINE=INNODB;

insert into User (Account, Password,Role) values('admin','admin123','admin');