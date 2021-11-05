create function FUNC_GenerateRandomChinese(len int)
returns text
begin
declare chineseSource text;
declare result text;

set chineseSource = "静静的心里都有一道最美丽的风景尽管世事繁杂此心依然情怀依然尽管颠簸流离脚步依然追求依然尽管岁月沧桑世界依然生命依然守住最美风景成为一种风度宁静而致远守住最美风景成为一种境界悠然而豁达守住最美风景成为一种睿智淡定而从容带着前世的印记心怀纯净身披霞带踏一水清盈今生寻美好而来海浪无声将夜幕深深淹没漫过天空尽头的角落大鱼在梦境的缝隙里游过凝望你沉睡的轮廓看海天一色听风起雨落执子手吹散苍茫茫烟波大鱼的翅膀已经太辽阔我松开时间的绳索怕你飞远去怕你离我而去更怕你永远停留在这里每一滴泪水都向你流淌去倒流进天空的海底海浪无声将夜幕深深淹没漫过天空尽头的角落大鱼在梦境的缝隙里游过凝望你沉睡的轮廓看海
天一色听风起雨落执子手吹散苍茫茫烟波大鱼的翅膀已经太辽阔我松开时间的绳索看你飞远去看你离我而去原来你生来就属于天际每一滴泪水都向你流淌去倒流回最初的相遇";

set result = SUBSTRING(chineseSource, FLOOR(rand() * CHAR_LENGTH(chineseSource)), 1);
set len = len - 1;

while 0 <= len do

    set result = CONCAT(result, SUBSTRING(chineseSource, FLOOR(rand() * CHAR_LENGTH(chineseSource)), 1));
    set len = len - 1;
end while;

return result;
end;