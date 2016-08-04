-- offline: бесплатные, платные между бесплатными, ACTUAL_SERVICE_PARAMETER3 != NULL и ACTUAL_SERVICE_PARAMETER3 = Default
declare
ctn varchar2(100);
iterator number;
amountTransactions number;
tablePrefixDwh varchar2(10);
executeOsaHistory varchar2(5000);
executeRechargeHistory varchar2(5000);
core_balance varchar2(10);

begin
ctn:='9030372222';
amountTransactions:=10;
tablePrefixDwh:='URL';
iterator:=0;
core_balance:=1000;

loop
-- OSA_HISTORY, MERCHANT_ID = GPRS, ACTUAL_SERVICE_PARAMETER3 != CCBO_SETTING.DEFAULT_ACTUAL_SERVICE_PARAMETER3 (5 транзакций)
core_balance:=core_balance-0;
executeOsaHistory:='Insert into OSA_HISTORY_'||tablePrefixDwh||'
   (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT,
   REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID,
   UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE,
   ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS,
   SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE,
   LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE,
   FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE,
   BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE,
   PCL_FLAG, ACTUAL_SERVICE_PARAMETER3)
 Values
   ('||ctn||', sysdate-2+'||iterator||'/(24*60), sysdate-2+'||iterator||'/(24*60)+1/1440, ''unitBasedCharge'', 1000,
   400, 0, 225, 1541, ''49'',
   21, ''GPRS'', ''INT GPRS charging'', 12345, 2,
   1, ''SGSN_IP_ADDRESS:85.115.244.147'', ''''''Internet'''''', ''''''VOLUME_K'''''', 66,
   -1, -1, -1, -1, 2,
   ''IP85.115.241.7'', 2, ''250996671940230'', ''''''000000;000000;10000#ggsn7.huawei.com;360115520'''''', sysdate-2+'||iterator||'/(24*60),
   1, ''RUR'', 1, 2018635754085, 122024584,
   23, ''GPRS_BEELINE_VOLGA'', ''[1~'||core_balance||'~0~0][3~50~0~0]'', 12345, 1,
   0, -1)';
iterator:=iterator+1;
exit when iterator>(amountTransactions/2);
execute immediate executeOsaHistory;
end loop;

-- возвращаем переменные в значения на шаг назад, т.к. они изменились, но был выход из цикла
iterator:=iterator-1;


-- RECHARGE_HISTORY (1 транзакция пополнения)
core_balance:=core_balance+10;
executeRechargeHistory:='Insert into RECHARGE_HISTORY_'||tablePrefixDwh||'
   (SUBSCRIBER_ID, RECHARGE_DATE_TIME, CARD_NUMBER, RECHARGE_AMOUNT, EXPIRATION_OFFSET,NEW_BALANCE, VOUCHER_TYPE, BALANCE_TYPE, SERIAL_NUMBER, RECHARGE_COMMENT, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, FACE_VALUE, BALANCES_INFO, IDENTITY_ID)
 Values
   ('||ctn||', sysdate-2+'||iterator||'/(24*60), ''non vouche'', 65, 0, 0, 0, 0, 12070368844, ''XPA,6039818932,1008,2,1111'', 279918750002, 6169982, 23, ''RUR'', 10, ''[1~'||core_balance||'~10.0~0]'', 1)';
iterator:=iterator+1;
execute immediate executeRechargeHistory;


loop
-- OSA_HISTORY, MERCHANT_ID = GPRS, ACTUAL_SERVICE_PARAMETER3 != CCBO_SETTING.DEFAULT_ACTUAL_SERVICE_PARAMETER3 (4 транзакции)
core_balance:=core_balance-0;
executeOsaHistory:='Insert into OSA_HISTORY_'||tablePrefixDwh||'
   (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT,
   REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID,
   UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE,
   ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS,
   SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE,
   LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE,
   FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE,
   BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE,
   PCL_FLAG, ACTUAL_SERVICE_PARAMETER3)
 Values
   ('||ctn||', sysdate-2+'||iterator||'/(24*60), sysdate-2+'||iterator||'/(24*60)+1/1440, ''unitBasedCharge'', 1000,
   400, 0, 225, 1541, ''49'',
   21, ''GPRS'', ''INT GPRS charging'', 12345, 2,
   1, ''SGSN_IP_ADDRESS:85.115.244.147'', ''''''Internet'''''', ''''''VOLUME_K'''''', 66,
   -1, -1, -1, -1, 2,
   ''IP85.115.241.7'', 2, ''250996671940230'', ''''''000000;000000;10000#ggsn7.huawei.com;360115520'''''', sysdate-2+'||iterator||'/(24*60),
   1, ''RUR'', 1, 2018635754085, 122024584,
   23, ''GPRS_BEELINE_VOLGA'', ''[1~'||core_balance||'~0~0][3~50~0~0]'', 12345, 1,
   0, -1)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeOsaHistory;
end loop;

commit;
end;