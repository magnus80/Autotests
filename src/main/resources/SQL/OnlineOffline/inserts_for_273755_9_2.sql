declare
ctn varchar2(100);
iterator number; -- Счетчик
amountTransactions number; -- Количество транзакций
tablePrefixDwh varchar2(10);
--workTables
executeRc varchar2(5000);
begin
ctn:='9030371112';
amountTransactions:=6;
tablePrefixDwh:='URL';
iterator:=0;

loop
--RC
executeRc:='Insert into RC_'||tablePrefixDwh||'
   (ID, RC_COMMENT, CALL_ID, SLICE, RC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO, PCL_FLAG)
 Values
   (0, ''PC_RC_ROAMRLT'', 2513634258445, 125566859, sysdate-7+'||iterator||'/(24*60), 
    2, '||ctn||', ''RUR'', 2398, ''[1~1632.2200~10~0]'', 
    0)';
execute immediate executeRc;
iterator:=iterator+1;
exit when iterator>amountTransactions;

end loop;
commit;
end;
