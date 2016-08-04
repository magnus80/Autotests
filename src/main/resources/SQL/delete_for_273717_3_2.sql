declare
ctn varchar2(100); 
deleteRoamingCallsStmt varchar2(5000);
deleteAccumulatorStmt varchar2(5000);
begin
ctn:='9030371111'; -- Номер абонента на котором будем создавать транзакции
deleteRoamingCallsStmt:='DELETE roaming_calls where SUBSCRIBER_ID=7'||ctn;
deleteAccumulatorStmt:='DELETE ACCUMULATOR where CHRMSISDN='||ctn;
execute immediate deleteRoamingCallsStmt;
execute immediate deleteAccumulatorStmt;
commit;
end;



