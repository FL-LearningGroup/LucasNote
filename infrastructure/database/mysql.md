```sql
show variables like 'char%';
select host,user,authentication_string from mysql.user;
GRANT ALL PRIVILEGES ON * . * TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON * . * TO 'wordpressuser'@'localhost';
```


```sql
/* In MySql8, Create user and grant privilege to remote login.*/
create user 'user'@'%' identity by 'password';
grant all privileges on *.* to 'user'@'%' with grant option;

```

为啥不能用uuid做MySQL的主键?: https://hollis.blog.csdn.net/article/details/108413818?spm=1001.2101.3001.6650.15&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7Edefault-15.no_search_link&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7Edefault-15.no_search_link