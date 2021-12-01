create function FUNC_GenerateRandomEnglish(len int)
returns varchar(45)
begin
declare englishSource text;
declare result varchar(45);

set englishSource = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";

set result = SUBSTRING(englishSource, FLOOR(rand() * CHAR_LENGTH(englishSource)), 1);
set len = len - 1;

while 0 <= len do

    set result = CONCAT(result, SUBSTRING(englishSource, FLOOR(rand() * CHAR_LENGTH(englishSource)), 1));
    set len = len - 1;
end while;

return result;
end;