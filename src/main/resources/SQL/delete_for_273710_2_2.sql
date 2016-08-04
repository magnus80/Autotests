declare
ctn varchar2(100); 
deleteUsersessionsStmt varchar2(5000);
begin
ctn:='9030371111';
deleteUsersessionsStmt:='DELETE USERSESSIONS where CHRMSISDN='||ctn;
execute immediate deleteUsersessionsStmt;
commit;
end;
