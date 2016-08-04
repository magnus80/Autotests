-- offline: балансы не мен€ютс€
declare
ctn varchar2(100);					/* номер абонента */
iterator number;					/* счетчик количества транзакций */
amountTransactions number;			/* количество транзакций */
tablePrefixDwh varchar2(10);		/* префикс таблицы */
executeOsaHistory varchar2(5000);	/* workTable */

begin
ctn:='79030372222';
amountTransactions:=10;
tablePrefixDwh:='URL';
iterator:=1;

loop
-- OSA_HISTORY, MERCHANT_ID = GPRS
executeOsaHistory:='Insert into OSA_HISTORY_'||tablePrefixDwh||'
   (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE, PCL_FLAG, ACTUAL_SERVICE_PARAMETER3)
 Values
   ('||ctn||', sysdate-2+'||iterator||'/(24*60), sysdate-2+'||iterator||'/(24*60), ''unitBasedCharge'', 1000, 400, 0, 225, 1541, ''49'', 21, ''GPRS'', ''INT GPRS charging'', 12345, 2, 1, ''SGSN_IP_ADDRESS:85.115.244.147'', ''''''Internet'''''', ''''''VOLUME_K'''''', 66, -1, -1, -1, -1, 2, ''IP85.115.241.7'', 2, ''250996671940230'', ''''''000000;000000;10000#ggsn7.huawei.com;360115520'''''', sysdate-2+'||iterator||'/(24*60), 1, ''RUR'', 1, 2018635754085, 122024584, 23, ''GPRS_BEELINE_VOLGA'', ''[1~1000~0~0]'', '||iterator||', 1, 0, '||iterator||')';
execute immediate executeOsaHistory;
iterator:=iterator+1;
exit when iterator>amountTransactions;
-- OSA_HISTORY, MERCHANT_ID <> GPRS (MERCHANT_ID = MMS_MESSAGE)
executeOsaHistory:='Insert into OSA_HISTORY_'||tablePrefixDwh||'
   (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE, PCL_FLAG, ACTUAL_SERVICE_PARAMETER3)
 Values
   ('||ctn||', sysdate-3+'||iterator||'/(24*60), sysdate-3+'||iterator||'/(24*60), ''unitBasedCharge'', 1, 400, 0, 225, 1541, ''49'', 21, ''MMS_MESSAGE'', ''MMSMO:79645768036'', 12345, 2, 1, ''SGSN_IP_ADDRESS:85.115.244.147'', ''''''mms'''''', ''''''VOLUME_K'''''', 66, -1, -1, -1, -1, 2, ''IP85.115.241.7'', 2, ''250996671940230'', ''''''000000;000000;10000#ggsn7.huawei.com;360115520'''''', sysdate-3+'||iterator||'/(24*60), 1, ''RUR'', 1, 2018635754085, 122024584, 23, ''GPRS_BEELINE_VOLGA'', ''[1~1000~0~0]'', '||iterator||', 1, 0, '||iterator||')';
execute immediate executeOsaHistory;
iterator:=iterator+1;
exit when iterator>amountTransactions;
end loop;

commit;
end;