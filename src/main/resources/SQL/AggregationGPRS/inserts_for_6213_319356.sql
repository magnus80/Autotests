-- offline: платные, списание во время транзакции
declare
ctn varchar2(100);
iterator number;
amountTransactions number;
tablePrefixDwh varchar2(10);
executeOsaHistory varchar2(5000);
executeRC varchar2(5000);
core_balance varchar2(10);

begin
ctn:='9030372222';
amountTransactions:=21;
tablePrefixDwh:='URL';
iterator:=0;
core_balance:=1000;

loop
-- OSA_HISTORY, MERCHANT_ID = GPRS (4 транзакции)
core_balance:=core_balance-10;
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
   ('||ctn||', sysdate-2+'||iterator||'/(24*60), sysdate-2+'||(iterator+2)||'/(24*60), ''unitBasedCharge'', 1000,
   400, 0, 225, 1541, ''49'',
   21, ''GPRS'', ''INT GPRS charging'', 12345, 2,
   1, ''SGSN_IP_ADDRESS:85.115.244.147'', ''''''Internet'''''', ''''''VOLUME_K'''''', 66,
   -1, -1, -1, -1, 2,
   ''IP85.115.241.7'', 2, ''250996671940230'', ''''''000000;000000;10000#ggsn7.huawei.com;360115520'''''', sysdate-2+'||iterator||'/(24*60),
   1, ''RUR'', 1, 2018635754085, 122024584,
   23, ''GPRS_BEELINE_VOLGA'', ''[1~'||core_balance||'~10~0][3~50~0~0]'', 12345, 1,
   0, -1)';
iterator:=iterator+2;
exit when iterator>8;
execute immediate executeOsaHistory;
end loop;

-- возвращаем переменные в значения на шаг назад, т.к. они изменились, но был выход из цикла
core_balance:=core_balance+10;
iterator:=iterator-2;

-- RC (1 транзакция списания абонентской платы)
core_balance:=core_balance-100;
executeRC:='Insert into RC_'||tablePrefixDwh||'
   (ID, RC_COMMENT, RC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, BALANCES_INFO, PCL_FLAG)
 Values
   (0, ''PC_EASY01_OR_PC'', sysdate-2+'||(iterator+1)||'/(24*60), 23, '||ctn||', ''RUR'', ''[1~'||core_balance||'~100~0]'', 0)';
execute immediate executeRC;
-- OSA_HISTORY, MERCHANT_ID = GPRS (1 транзакция мобильного интернета, во время которой будет происходить списание)
core_balance:=core_balance-10;
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
   ('||ctn||', sysdate-2+'||iterator||'/(24*60), sysdate-2+'||(iterator+2)||'/(24*60), ''unitBasedCharge'', 1000,
   400, 0, 225, 1541, ''49'',
   21, ''GPRS'', ''INT GPRS charging'', 12345, 2,
   1, ''SGSN_IP_ADDRESS:85.115.244.147'', ''''''Internet'''''', ''''''VOLUME_K'''''', 66,
   -1, -1, -1, -1, 2,
   ''IP85.115.241.7'', 2, ''250996671940230'', ''''''000000;000000;10000#ggsn7.huawei.com;360115520'''''', sysdate-2+'||iterator||'/(24*60),
   1, ''RUR'', 1, 2018635754085, 122024584,
   23, ''GPRS_BEELINE_VOLGA'', ''[1~'||core_balance||'~10~0][3~50~0~0]'', 12345, 1,
   0, -1)';
iterator:=iterator+2;
execute immediate executeOsaHistory;

loop
-- OSA_HISTORY, MERCHANT_ID = GPRS (4 транзакций)
core_balance:=core_balance-10;
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
   ('||ctn||', sysdate-2+'||iterator||'/(24*60), sysdate-2+'||(iterator+2)||'/(24*60), ''unitBasedCharge'', 1000,
   400, 0, 225, 1541, ''49'',
   21, ''GPRS'', ''INT GPRS charging'', 12345, 2,
   1, ''SGSN_IP_ADDRESS:85.115.244.147'', ''''''Internet'''''', ''''''VOLUME_K'''''', 66,
   -1, -1, -1, -1, 2,
   ''IP85.115.241.7'', 2, ''250996671940230'', ''''''000000;000000;10000#ggsn7.huawei.com;360115520'''''', sysdate-2+'||iterator||'/(24*60),
   1, ''RUR'', 1, 2018635754085, 122024584,
   23, ''GPRS_BEELINE_VOLGA'', ''[1~'||core_balance||'~10~0][3~50~0~0]'', 12345, 1,
   0, -1)';
iterator:=iterator+2;
exit when iterator>amountTransactions;
execute immediate executeOsaHistory;
end loop;

commit;
end;