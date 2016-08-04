declare
ctn varchar2(100); 
deleteUsersessionsStmt varchar2(5000);
deleteRoamingCallsStmt varchar2(5000);
begin
ctn:='9030371111'; -- Номер абонента на котором будем создавать транзакции
deleteUsersessionsStmt:='DELETE USERSESSIONS where CHRMSISDN='||ctn;
deleteRoamingCallsStmt:='DELETE roaming_calls where SUBSCRIBER_ID=7'||ctn;
execute immediate deleteUsersessionsStmt;
execute immediate deleteRoamingCallsStmt;
commit;
end;






