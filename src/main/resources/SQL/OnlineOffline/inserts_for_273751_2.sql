declare
ctn varchar2(100);
iterator number; -- Счетчик
amountTransactions number; -- Количество транзакций
tablePrefixDwh varchar2(10);
--workTables
executeCallHistory varchar2(5000);

begin
ctn:='9030371112';
amountTransactions:=30;
tablePrefixDwh:='URL';
iterator:=0;

loop
--CALL_HISTORY
executeCallHistory:='Insert into CALL_HISTORY_'||tablePrefixDwh||'
   (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
 Values
   ('||ctn||', sysdate-7+'||iterator||'/(24*60), ''79030372222'', 360, ''OUTGOING_OPPS_CALL'', 0, 16, 0, 0, ''79281111111'', 784048896812, 49030797, 28, ''79038889987'', ''250991770305226'', ''94'', ''RUR'', ''[1~100~10.0'||iterator||'~0][19~100~10.0'||iterator||'~0]'', 108, 1)';
execute immediate executeCallHistory;
iterator:=iterator+1;
exit when iterator>amountTransactions;

end loop;
commit;
end;
