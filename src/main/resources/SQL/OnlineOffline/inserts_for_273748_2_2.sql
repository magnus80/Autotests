declare
ctn varchar2(100);
iterator number; -- Счетчик
amountTransactions number; -- Количество транзакций
tablePrefixDwh varchar2(10);
--workTables
executeMtr varchar2(5000);
begin
ctn:='9030371112';
amountTransactions:=6;
tablePrefixDwh:='URL';
iterator:=0;

loop

--MTR
executeMtr:='insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
values (null, 0, ''ccboAutoTest'', null, null, 0, null,''XPB,sdf*,sd*'', null, null, null, null, null, null, 2009114048420, 121943617, sysdate-7+'||iterator||'/(24*60), 27, '||ctn||', null, null, null, null, ''RUR'', '''', null, null, null, null, null, null, null, ''[1~100~10~0]'', null, null, null, null, null)';
execute immediate executeMtr;
iterator:=iterator+1;
exit when iterator>amountTransactions;



end loop;
commit;
end;
