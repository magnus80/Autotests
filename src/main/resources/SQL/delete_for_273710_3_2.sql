declare
ctn varchar2(100); 
deleteRoamingCallsStmt varchar2(5000);
begin
ctn:='79030371111'; -- Номер абонента на котором будем создавать транзакции
deleteRoamingCallsStmt:='DELETE roaming_calls where SUBSCRIBER_ID='||ctn;
execute immediate deleteRoamingCallsStmt;
commit;
end;