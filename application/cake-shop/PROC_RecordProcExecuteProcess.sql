--DROP PROCEDURE IF EXISTS PROC_Dev_SqlExecutedHistory;
create procedure PROC_Dev_SqlExecutedHistory(in in_executeId varchar(36), in in_name varchar(45), in in_message text, in in_record int)
begin
if in_record then
    insert into Dev_SqlExecutedHistory(ExecuteId, Name, Message)
    values (in_executeId, in_name, in_message);
    COMMIT;
end if;
end;