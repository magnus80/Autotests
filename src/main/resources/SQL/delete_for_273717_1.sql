declare
ctn varchar2(100); 
deleteUsersessionsStmt varchar2(5000);
deleteRoamingCallsStmt varchar2(5000);
deleteAccumulatorStmt varchar2(5000);
begin
ctn:='9030371111'; -- Номер абонента на котором будем создавать транзакции
deleteUsersessionsStmt:='DELETE USERSESSIONS where CHRMSISDN='||ctn;
deleteRoamingCallsStmt:='DELETE roaming_calls where SUBSCRIBER_ID=7'||ctn;
deleteAccumulatorStmt:='DELETE ACCUMULATOR where CHRMSISDN='||ctn;
execute immediate deleteUsersessionsStmt;
execute immediate deleteRoamingCallsStmt;
execute immediate deleteAccumulatorStmt;
commit;
end;






