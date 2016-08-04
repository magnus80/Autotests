declare
ctn varchar2(100);
iterator number; -- Счетчик
amountTransactions number; -- Количество транзакций
tablePrefixDwh varchar2(10);
--workTables
executeReachargeHistory varchar2(5000);
begin
ctn:='9030371112';
amountTransactions:=6;
tablePrefixDwh:='URL';
iterator:=0;

loop

--RECHARGE_HISTORY
executeReachargeHistory:='Insert into RECHARGE_HISTORY_'||tablePrefixDwh||'
   (PART_KEY, SUBSCRIBER_ID, RECHARGE_DATE_TIME, CARD_NUMBER, RECHARGE_AMOUNT, EXPIRATION_OFFSET, NEW_BALANCE, VOUCHER_TYPE, BALANCE_TYPE, NEW_BALANCE_2, BATCH_NUMBER, SERIAL_NUMBER, P_BALANCE_1, P_BALANCE_1_EXPIRE, P_BALANCE_2, P_BALANCE_2_EXPIRE, RECHARGE_COMMENT, P_BALANCE_1_AMOUNT, P_BALANCE_2_AMOUNT, FREE_SECONDS_AMOUNT, FREE_SECONDS_BALANCE, CALL_ID, SLICE, BILLSYSTEM_CODE, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, FREE_SMS_EXPIRE, NEW_VAS_BALANCE, VAS_CHARGE, CURRENCY_CONV_RATE, ISO_CODE, VOUCHER_ISO_CODE, FACE_VALUE, NEW_BALANCE_6, RECHARGE_AMOUNT_6, NEW_BALANCE_10, RECHARGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, RECHARGE_AMOUNT_4, NEW_BALANCE_5, RECHARGE_AMOUNT_5, IDENTITY_ID, PCL_FLAG)
 Values
   (NULL, '||ctn||', sysdate-7+'||iterator||'/(24*60), ''non voucher'', 0, 
    30, 0, 0, 0, NULL, 
    -1, NULL, NULL, NULL, NULL, 
    NULL, ''XPA,6039818932,28,2,3177561'', NULL, NULL, NULL, 
    NULL, 2256029193381, 123862779, 24, NULL, 
    NULL, NULL, NULL, NULL, 1, 
    ''RUR'', ''RUR'', 300, NULL, NULL, 
    NULL, NULL, ''[1~318.966~300~~0~1]'', NULL, NULL, 
    NULL, NULL, NULL, NULL)';
execute immediate executeReachargeHistory;
iterator:=iterator+1;
exit when iterator>amountTransactions;

end loop;
commit;
end;
