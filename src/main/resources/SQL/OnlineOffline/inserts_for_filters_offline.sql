-- скрипт для добавления транзакций по всем фильтрам офлайн
declare
ctn varchar2(10);					/* номер абонента */
tablePrefixDwh varchar2(10);		/* префикс таблицы */
iterator number;					/* счетчик количества транзакций */
-- workTables
executeCallHistory varchar2(5000);
executeMtr varchar2(5000);
executeOsaHistory varchar2(5000);
executePsTransaction varchar2(5000);
executeRechargeHistory varchar2(5000);
executeRoamingCalls varchar2(5000);
executeUsersessions varchar2(5000);
executeAccumulator varchar2(5000);
executeScratchCardNew varchar2(5000);
executeSubsAlcsHist varchar2(5000);
executeRc varchar2(5000);
executeNrc varchar2(5000);

begin
ctn:='9030371112';
tablePrefixDwh:='URL';
iterator:=1;

-- Увеличение баланса (платежи и корректировки)
-- MTR
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''AUTO_TESTER'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 23, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;
-- RECHARGE_HISTORY
executeRechargeHistory:='Insert into recharge_history_'||tablePrefixDwh||' (PART_KEY, SUBSCRIBER_ID, RECHARGE_DATE_TIME, CARD_NUMBER, RECHARGE_AMOUNT, EXPIRATION_OFFSET, NEW_BALANCE, VOUCHER_TYPE, BALANCE_TYPE, NEW_BALANCE_2, BATCH_NUMBER, SERIAL_NUMBER, P_BALANCE_1, P_BALANCE_1_EXPIRE, P_BALANCE_2, P_BALANCE_2_EXPIRE, RECHARGE_COMMENT, P_BALANCE_1_AMOUNT, P_BALANCE_2_AMOUNT, FREE_SECONDS_AMOUNT, FREE_SECONDS_BALANCE, CALL_ID, SLICE, BILLSYSTEM_CODE, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, FREE_SMS_EXPIRE, NEW_VAS_BALANCE, VAS_CHARGE, CURRENCY_CONV_RATE, ISO_CODE, VOUCHER_ISO_CODE, FACE_VALUE, NEW_BALANCE_6, RECHARGE_AMOUNT_6, NEW_BALANCE_10, RECHARGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, RECHARGE_AMOUNT_4, NEW_BALANCE_5, RECHARGE_AMOUNT_5, IDENTITY_ID)
Values (null, '||ctn||', sysdate-7+'||iterator||'/(24*60), ''non voucher'', 0, 0, 0, 0, 0, null, null, 12070368844, null, null, null, null, ''12321asdfa3F3'', null, null, null, null, 279918750001, 6169981, 23, null, null, null, null, null, null, ''USD'', null, 10.000, null, null, null, null, ''[1~500~10]'', null, null, null, null, 1)';
iterator:=iterator+1;
execute immediate executeRechargeHistory;

-- Уменьшение баланса (платежи и корректировки)
-- MTR
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''ODS_AUTO_TESTER'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 28, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''RFC_AUTO_TESTER'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 28, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''XPA_AUTO_TESTER'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 28, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''PP Repayment on due date.123for PP ID.AUTO_TESTER'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 28, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''rezerv_AUTO_TESTER'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 28, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;

-- Транзакции Balance Transfer
-- MTR
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''XPB,MTR_offline'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 28, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;
-- RECHARGE_HISTORY
executeRechargeHistory:='Insert into recharge_history_'||tablePrefixDwh||' (PART_KEY, SUBSCRIBER_ID, RECHARGE_DATE_TIME, CARD_NUMBER, RECHARGE_AMOUNT, EXPIRATION_OFFSET, NEW_BALANCE, VOUCHER_TYPE, BALANCE_TYPE, NEW_BALANCE_2, BATCH_NUMBER, SERIAL_NUMBER, P_BALANCE_1, P_BALANCE_1_EXPIRE, P_BALANCE_2, P_BALANCE_2_EXPIRE, RECHARGE_COMMENT, P_BALANCE_1_AMOUNT, P_BALANCE_2_AMOUNT, FREE_SECONDS_AMOUNT, FREE_SECONDS_BALANCE, CALL_ID, SLICE, BILLSYSTEM_CODE, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, FREE_SMS_EXPIRE, NEW_VAS_BALANCE, VAS_CHARGE, CURRENCY_CONV_RATE, ISO_CODE, VOUCHER_ISO_CODE, FACE_VALUE, NEW_BALANCE_6, RECHARGE_AMOUNT_6, NEW_BALANCE_10, RECHARGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, RECHARGE_AMOUNT_4, NEW_BALANCE_5, RECHARGE_AMOUNT_5, IDENTITY_ID)
Values (null, '||ctn||', sysdate-7+'||iterator||'/(24*60), ''non voucher'', 0, 0, 0, 0, 0, null, null, 12070368844, null, null, null, null, ''XPB,Recharge_offline'', null, null, null, null, 279918750001, 6169981, 2, null, null, null, null, null, null, ''USD'', null, 10.000, null, null, null, null, ''[1~500~10]'', null, null, null, null, 1)';
iterator:=iterator+1;
execute immediate executeRechargeHistory;

-- Сессии и списания GPRS
-- USERSESSIONS
executeUsersessions:='Insert into usersessions (NUMCHARGEID, CHRMSISDN, VCHAPN, DTMSTARTDATE, NUMVOLUME, NUMRATEDVOLUME, DTMSYSCREATIONDATE, DTMSYSUPDATEDATE, BILLSYSTEM_CODE, SLICE)
Values (564, '||ctn||', ''test'', sysdate-7+'||iterator||'/(24*60), 1633118, 1633280, sysdate-7+'||iterator||'/(24*60), null, 2, 7777400)';
iterator:=iterator+1;
execute immediate executeUsersessions;
-- MTR
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''GPRST [mtr_offline]'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 28, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''GWRST [mtr_offline]'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 28, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;
-- OSA_HISTORY
executeOsaHistory:='Insert into osa_history_'||tablePrefixDwh||' (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, DESCRIPT, REASON_CODE, NEW_BALANCE_1, CHANGE_AMOUNT_1, NEW_BALANCE_2, CHANGE_AMOUNT_2, NEW_BALANCE_3, CHANGE_AMOUNT_3, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_7, CHANGE_AMOUNT_7, NEW_BALANCE_8, CHANGE_AMOUNT_8, NEW_BALANCE_9, CHANGE_AMOUNT_9, NEW_BALANCE_10, CHANGE_AMOUNT_10, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, PARAM_CONFIRM_ID, PARAM_CONTRACT, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, SERVICE_PARAMETER_5, LOCATION_A3, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, CURRENCY, IDENTITY_ID, GROUP_ID, CHARGE_CODE, SPENDING_LIMIT1, SPENDING_LIMIT2, SPENDING_LIMIT3, SPENDING_LIMIT4, SPENDING_LIMIT5, SPENDING_LIMIT6, SPENDING_LIMIT7, SPENDING_LIMIT8, SPENDING_LIMIT9, SPENDING_LIMIT10, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), sysdate-7+'||iterator||'/(24*60), ''unitBasedCharge'', 0, null, 407, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 2, 225, 1796, ''3'', null, ''GPRS'', ''GPRS charging'', 12345, 2, 1, ''SGSN_IP_ADDRESS:217.118.74.99'', ''''''vm2sms'''''', ''''''VOLUME_K'''''', null, null, 86, -1, -1, -1, -1, 0, null, 2, ''IP85.115.245.125'', 2, null, ''''''001296248399190667547;VOLUME_K'''''', null, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, 1, ''RUR'', null, null, 280400506825, 1, 2, ''GPRS_BEELINE_CENTER'', ''[1~500~10]'', null, null, null)';
iterator:=iterator+1;
execute immediate executeOsaHistory;
-- SUBS_ALCS_HIST (ALCO - для проверки фильтра в тех.детализации)
executeSubsAlcsHist:='Insert into SUBS_ALCS_HIST (USER_NAME, SUBSCRIBER_ID, BILLSYSTEM_CODE, IDENTITY_ID, SP_ID, ALCS_ID, ALCS_NAME, ALCS_ACTION, ALCS_ACTION_DATE_TIME, ALCS_ACTION_REASON, ALCS_SERVICE_START_DATE, ALCS_SERVICE_END_DATE, OFFER_TYPE, GROUP_ID, ACCOUNT_TYPE)
Values (''AUTO_TESTER'', '||ctn||', 23, 1, 1, 1, ''1'', 2, sysdate-7+'||iterator||'/(24*60), 8, sysdate-7+'||iterator||'/(24*60), sysdate-7+'||iterator||'/(24*60), 1, ''1'', 1)';
iterator:=iterator+1;
execute immediate executeSubsAlcsHist;

-- Сессии и списания GPRS-Internet
-- USERSESSIONS
executeUsersessions:='Insert into usersessions (NUMCHARGEID, CHRMSISDN, VCHAPN, DTMSTARTDATE, NUMVOLUME, NUMRATEDVOLUME, DTMSYSCREATIONDATE, DTMSYSUPDATEDATE, BILLSYSTEM_CODE, SLICE)
Values (564, '||ctn||', ''internet.beeline.ru'', sysdate-7+'||iterator||'/(24*60), 1633118, 1633280, sysdate-7+'||iterator||'/(24*60), null, 23, 7777400)';
iterator:=iterator+1;
execute immediate executeUsersessions;
-- OSA_HISTORY
executeOsaHistory:='Insert into OSA_HISTORY_'||tablePrefixDwh||' (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, INFO_PARAMETER, CHARGE_CODE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE, PCL_FLAG)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), sysdate-7+'||iterator||'/(24*60), ''unitBasedCharge'', 0, 407, 0, 225, 1796, ''3'', 21, ''GPRS'', ''GPRS charging'', 12345, 2, 1, ''SGSN_IP_ADDRESS:217.118.74.99'', ''''''Internet'''''', ''''''VOLUME_K'''''', 86, -1, -1, -1, -1, 2, ''IP85.115.245.125'', 2, ''''''001296248399190667547;VOLUME_K'''''', ''GYNYYYYY'', 1, ''RUR'', 1, 280400506825, 1, 23, ''GPRS_BEELINE_CENTER'', ''[1~500~10]'', ''111111'', 1, 0)';
iterator:=iterator+1;
execute immediate executeOsaHistory;

-- Сессии и списания GPRS-WAP
-- USERSESSIONS
executeUsersessions:='Insert into usersessions (NUMCHARGEID, CHRMSISDN, VCHAPN, DTMSTARTDATE, NUMVOLUME, NUMRATEDVOLUME, DTMSYSCREATIONDATE, DTMSYSUPDATEDATE, BILLSYSTEM_CODE, SLICE)
Values (564, '||ctn||', ''wap.beeline.ru'', sysdate-7+'||iterator||'/(24*60), 1633118, 1633280, sysdate-7+'||iterator||'/(24*60), null, 2, 7777400)';
iterator:=iterator+1;
execute immediate executeUsersessions;
-- OSA_HISTORY
executeOsaHistory:='Insert into OSA_HISTORY_'||tablePrefixDwh||' (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, INFO_PARAMETER, CHARGE_CODE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE, PCL_FLAG)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), sysdate-7+'||iterator||'/(24*60), ''unitBasedCharge'', 0, 407, 0, 225, 1796, ''3'', 21, ''GPRS'', ''GPRS charging'', 12345, 2, 1, ''SGSN_IP_ADDRESS:217.118.74.99'', ''''''WAP'''''', ''''''VOLUME_K'''''', 86, -1, -1, -1, -1, 2, ''IP85.115.245.125'', 2, ''''''001296248399190667547;VOLUME_K'''''', ''GYNYYYYY'', 1, ''RUR'', 1, 280400506825, 1, 23, ''GPRS_BEELINE_CENTER'', ''[1~500~10]'', ''111111'', 1, 0)';
iterator:=iterator+1;
execute immediate executeOsaHistory;

-- Доверительный платеж
-- MTR
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''A1U'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 28, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''pc_TRUSTEDPAYMENT'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 28, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;
-- RC
executeRc:='Insert into rc_'||tablePrefixDwh||' (ID, RC_COMMENT, CALL_ID, SLICE, RC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO)
Values (0, ''TRUSTEDPAYMENT'', 177755522, 10001, sysdate-7+'||iterator||'/(24*60), 28, '||ctn||', ''RUR'', 7777, ''[1~150~-10~]'')';
iterator:=iterator+1;
execute immediate executeRc;

-- Звонки
-- CALL_HISTORY
executeCallHistory:='Insert into call_history_'||tablePrefixDwh||' (PART_KEY, SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TERMINATION_REASON, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, SUBTYPE_ID, IDENTITY_ID, CHARGE_CODE, ORP_TIME, ADDITIONAL_GROUP_INFO, FUND_USAGE_TYPE, RECORD_SOURCE)
Values (null, '||ctn||', sysdate-7+'||iterator||'/(24*60), ''9031000910'', 10, ''IncomingCall'', null, 0, 17, 0, 0, null, null, null, null, null, null, null, null, 279923000515, 6169997, 2, ''79037032000'', ''250991283419802'', ''702'', null, null, ''USD'', null, null, null, null, null, null, ''[1~150.0~10]'', null, null, null, null, 107, 1, null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeCallHistory;

-- Прочие изменения баланса (MTR, RC, NRC: добавляем только NRC, остальные добавлены ранее)
-- NRC
executeNrc:='Insert into nrc_'||tablePrefixDwh||' (ID, NRC_COMMENT, CALL_ID, SLICE, NRC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO)
Values (0, ''TESTER_offline'', 286570344901, 6970000, sysdate-7+'||iterator||'/(24*60), 23, '||ctn||', ''RUR'', null, ''[1~180.2417~100][3~20~5]'')';
iterator:=iterator+1;
execute immediate executeNrc;

-- GPRS (То же самое, что "Сессии и списания GPRS" - добавлены ранее)

-- Карточное пополнение баланса (Транзакции RECHARGE_HISTORY - добавлены ранее)

-- SMS
-- PS_TRANSACTION
executePsTransaction:='Insert into ps_transaction_'||tablePrefixDwh||' (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, CHARGE_AMOUNT, NEW_BALANCE, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, REFUND_ID_1, REFUND_ID_2, BONUS_CONSUMED, CALL_ID, SLICE, BILLSYSTEM_CODE, TYPE_OF_CHARGE, SMS_CHARGE, SMS_NEW_BALANCE, FREE_SMS_CHARGE, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, CONVERSION_RATE, REQUESTED_ISO_CODE, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_10, CHANGE_AMOUNT_10, NY_NEW_BALANCE, NY_CHARGE, BALANCES_INFO, MSC_ID, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID, APPLICATION_ID, UNIT_TYPE_ID, CHARGE_CODE, SUBTYPE_ID, ORP_DATE, ADDITIONAL_GROUP_INFO, FUND_USAGE_TYPE, RECORD_SOURCE)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), null, null, ''1'', 4, ''CPA2809'', 1025, 3058098497, ''P'', null, null, null, 280318014569, 6172022, 28, null, null, null, null, null, null, null, ''RUR'', 1.000000, ''RUR'', null, null, null, null, null, null, ''[1~100~10]'', ''108079037012999'', null, null, null, null, null, null, null, ''MMNBLCN000'', 2579, null, null, 1, 1)';
iterator:=iterator+1;
execute immediate executePsTransaction;

-- Роуминг
-- ROAMING_CALLS
executeRoamingCalls:='Insert into roaming_calls (SUBSCRIBER_ID, CALL_DATE_TIME, CALL_DURATION, CALLED_NUMBER, TOTAL_CHARGE, NEW_BALANCE, OPERATION_DATE_TIME, COS, ROAMING_PARTNER, T_O, CALL_ID, SLICE, BILLSYSTEM_CODE, VOLUME, MEASURE)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), 137, ''79603040807'', -3, 0, sysdate-7+'||iterator||'/(24*60), null, ''CHEOR'', ''2V'', 579918751030, 1384563, 2, 0, ''SE'')';
iterator:=iterator+1;
execute immediate executeRoamingCalls;

-- Пересечение порога аккумулятора (ALCO, ACCUMULATOR)
-- ACCUMULATOR
executeAccumulator:='Insert into accumulator (CHRMSISDN, NUMID, DTMSYSCREATIONDATE, DTMNOTIFYDATE, BILLSYSTEM_CODE, SLICE, SMS_TYPE)
Values ('||ctn||', 905426593, sysdate-7+'||iterator||'/(24*60), sysdate-7+'||iterator||'/(24*60), 23, null, ''pink+30'')';
iterator:=iterator+1;
execute immediate executeAccumulator;

-- MMS (OSA) (Транзакции OSA_HISTORY - добавлены ранее)

-- Серийный номер карты
-- RECHARGE_HISTORY
executeRechargeHistory:='Insert into recharge_history_'||tablePrefixDwh||' (PART_KEY, SUBSCRIBER_ID, RECHARGE_DATE_TIME, CARD_NUMBER, RECHARGE_AMOUNT, EXPIRATION_OFFSET, NEW_BALANCE, VOUCHER_TYPE, BALANCE_TYPE, NEW_BALANCE_2, BATCH_NUMBER, SERIAL_NUMBER, P_BALANCE_1, P_BALANCE_1_EXPIRE, P_BALANCE_2, P_BALANCE_2_EXPIRE, RECHARGE_COMMENT, P_BALANCE_1_AMOUNT, P_BALANCE_2_AMOUNT, FREE_SECONDS_AMOUNT, FREE_SECONDS_BALANCE, CALL_ID, SLICE, BILLSYSTEM_CODE, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, FREE_SMS_EXPIRE, NEW_VAS_BALANCE, VAS_CHARGE, CURRENCY_CONV_RATE, ISO_CODE, VOUCHER_ISO_CODE, FACE_VALUE, NEW_BALANCE_6, RECHARGE_AMOUNT_6, NEW_BALANCE_10, RECHARGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, RECHARGE_AMOUNT_4, NEW_BALANCE_5, RECHARGE_AMOUNT_5, IDENTITY_ID)
Values (null, '||ctn||', sysdate-7+'||iterator||'/(24*60), ''123456'', 0, 0, 0, 0, 0, null, null, 12070368844, null, null, null, null, ''12321asdfa3F3'', null, null, null, null, 279918750001, 6169981, 2, null, null, null, null, null, null, ''USD'', null, 10.000, null, null, null, null, ''[1~500~100]'', null, null, null, null, 1)';
--iterator:=iterator+1;
execute immediate executeRechargeHistory;
-- Использовать только в паре!!!
executeScratchCardNew:='Insert into scratch_card_new (TIME, OPERATION_CODE, CARD_NUMBER, ERROR_CODE, STATUS, OPERATION_DATE, CARD_SUM, PHONE_NUMBER, CARD_DURATION, SECRET_CODE, FILE_DATE, FROM_SERVER, LOAD_DATE, CURRENCY)
Values (null, null, ''12070368844'', 0, 3, sysdate-7+'||iterator||'/(24*60), null, '||ctn||', null, ''123456'', null, null, null, ''USD'')';
iterator:=iterator+1;
execute immediate executeScratchCardNew;

-- CPA
-- PS_TRANSACTION
executePsTransaction:='Insert into ps_transaction_'||tablePrefixDwh||' (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, CHARGE_AMOUNT, NEW_BALANCE, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, REFUND_ID_1, REFUND_ID_2, BONUS_CONSUMED, CALL_ID, SLICE, BILLSYSTEM_CODE, TYPE_OF_CHARGE, SMS_CHARGE, SMS_NEW_BALANCE, FREE_SMS_CHARGE, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, CONVERSION_RATE, REQUESTED_ISO_CODE, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_10, CHANGE_AMOUNT_10, NY_NEW_BALANCE, NY_CHARGE, BALANCES_INFO, MSC_ID, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID, APPLICATION_ID, UNIT_TYPE_ID, CHARGE_CODE, SUBTYPE_ID, ORP_DATE, ADDITIONAL_GROUP_INFO, FUND_USAGE_TYPE, RECORD_SOURCE)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), null, null, ''1'', 4, ''CPA2809'', 1025, 3058098497, ''P'', null, null, null, 280318014569, 6172022, 28, ''C_test'', null, null, null, null, null, null, ''RUR'', 1.000000, ''RUR'', null, null, null, null, null, null, ''[1~100~100]'', ''79031111111'', null, null, null, null, null, null, null, ''MMNBLCN000'', 2579, null, null, 1, 1)';
iterator:=iterator+1;
execute immediate executePsTransaction;

-- Мобильная коммерция
-- OSA_HISTORY
executeOsaHistory:='Insert into OSA_HISTORY_'||tablePrefixDwh||' (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, INFO_PARAMETER, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), sysdate-7+'||iterator||'/(24*60), ''unitBasedCharge'', 0, 407, 0, 225, 1796, ''3'', 21, ''MC'', ''GPRS charging'', 12345, 2, 1, ''SGSN_IP_ADDRESS:217.118.74.99'', ''''''MC'''''', ''''''UNITS'''''', 86, -1, -1, -1, -1, 2, ''IP85.115.245.125'', 2, ''''''001296248399190667547;VOLUME_K'''''', 1, ''RUR'', 1, 280400506825, 1, 23, ''GPRS_BEELINE_CENTER'', ''[1~500~10]'', ''111111'')';
iterator:=iterator+1;
execute immediate executeOsaHistory;

-- Звонки на Билайн
-- CALL_HISTORY
executeCallHistory:='Insert into call_history_'||tablePrefixDwh||' (PART_KEY, SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TERMINATION_REASON, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, SUBTYPE_ID, IDENTITY_ID, CHARGE_CODE, ORP_TIME, ADDITIONAL_GROUP_INFO, FUND_USAGE_TYPE, RECORD_SOURCE)
Values (null, '||ctn||', sysdate-7+'||iterator||'/(24*60), ''79036145245'', 10, ''OutgoingCallAttempt'', null, 0, 17, 0, 0, null, null, null, null, null, null, null, null, 279923000515, 6169997, 2, ''qwe_D6499'', ''250991283419802'', ''702'', null, null, ''USD'', null, null, null, null, null, null, ''[1~150.0~10]'', null, null, null, null, 107, 1, null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeCallHistory;

-- Звонки на других операторов
-- CALL_HISTORY
executeCallHistory:='Insert into call_history_'||tablePrefixDwh||' (PART_KEY, SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TERMINATION_REASON, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, SUBTYPE_ID, IDENTITY_ID, CHARGE_CODE, ORP_TIME, ADDITIONAL_GROUP_INFO, FUND_USAGE_TYPE, RECORD_SOURCE)
Values (null, '||ctn||', sysdate-7+'||iterator||'/(24*60), ''79036145245'', 10, ''OutgoingCallAttempt'', null, 0, 17, 0, 0, null, null, null, null, null, null, null, null, 279923000515, 6169997, 2, ''sad_D5816'', ''250991283419802'', ''702'', null, null, ''USD'', null, null, null, null, null, null, ''[1~150.0~10]'', null, null, null, null, 107, 1, null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeCallHistory;

-- Скидки
-- MTR
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''ODS_TESTER_corr_1_03_01_015_000'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 23, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;

-- Корректировки
-- MTR
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''ODS_TESTER_corr_1_00_01_015_000'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 23, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;

-- Формальные корректировки
-- MTR
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''ODS_TESTER_corr_1_06_01_009_000'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 23, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;

-- Скидка по претензии абонента
-- MTR
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''ODS_TESTER_corr_1_02_03_040_000'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 23, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;

-- Роуминг, транзакции и списания (+ Все записи из ROAMING_CALLS)
-- MTR
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''RCH=offline'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 23, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;
-- PS_TRANSACTION
executePsTransaction:='Insert into ps_transaction_'||tablePrefixDwh||' (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, CONVERSION_RATE, REQUESTED_ISO_CODE, BALANCES_INFO, MSC_ID, CHARGE_CODE, SUBTYPE_ID, FUND_USAGE_TYPE, RECORD_SOURCE, PCL_FLAG)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), ''1'', 4, ''CPA2809'', 1025, 3058098497, ''P'', 280318014569, 6172022, 23, ''RUR'', 1, ''RUR'', ''[1~100~100]'', ''20031111111'', ''MMNBLCN000'', 2579, 1, 1, 0)';
iterator:=iterator+1;
execute immediate executePsTransaction;

-- Подключение SMS–пакетов
-- MTR
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''A@SMS_offline@CORE BALANCE@SMS@TEST'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 23, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''A@offline@SMS@offline@TEST'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 23, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;

-- Списания за сервис - CC
-- MTR
executeMtr:='Insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
Values (null, 0, ''SWITCHCONTROL'', null, null, 0, null, ''pc_CC'', null, null, null, null, null, null, 286571344963, 6225369, sysdate-7+'||iterator||'/(24*60), 23, '||ctn||', null, null, null, null, ''RUR'', null, null, null, null, null, 8803, null, null, ''[1~150~-10]'', null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeMtr;
-- RC
executeRc:='Insert into rc_'||tablePrefixDwh||' (ID, RC_COMMENT, CALL_ID, SLICE, RC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO)
Values (0, ''CC'', 177755522, 10001, sysdate-7+'||iterator||'/(24*60), 23, '||ctn||', ''RUR'', 7777, ''[1~150~10~]'')';
iterator:=iterator+1;
execute immediate executeRc;
-- NRC
executeNrc:='Insert into nrc_'||tablePrefixDwh||' (ID, NRC_COMMENT, CALL_ID, SLICE, NRC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO)
Values (0, ''CC'', 286570344901, 6970000, sysdate-7+'||iterator||'/(24*60), 23, '||ctn||', ''RUR'', null, ''[1~150~10][3~20~5]'')';
iterator:=iterator+1;
execute immediate executeNrc;

-- Voice Messaging (OSA-транзакции с OSA_ITEM = 'vm2sms' - добавлены ранее)

-- Без звонков с нулевой стоимостью (Вся детализация, исключая записи CALL_HISTORY с нулевым изменением баланса)
-- CALL_HISTORY
executeCallHistory:='Insert into call_history_'||tablePrefixDwh||' (PART_KEY, SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TERMINATION_REASON, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, SUBTYPE_ID, IDENTITY_ID, CHARGE_CODE, ORP_TIME, ADDITIONAL_GROUP_INFO, FUND_USAGE_TYPE, RECORD_SOURCE)
Values (null, '||ctn||', sysdate-7+'||iterator||'/(24*60), ''9031000910'', 10, ''IncomingCall'', null, 0, 17, 0, 0, null, null, null, null, null, null, null, null, 279923000515, 6169997, 2, ''79037032000'', ''250991283419802'', ''702'', null, null, ''USD'', null, null, null, null, null, null, ''[1~150~0]'', null, null, null, null, 107, 1, null, null, null, null, null)';
iterator:=iterator+1;
execute immediate executeCallHistory;

-- Клиентские агрегаты - Пополнения основного баланса (добавлены ранее)

-- Клиентские агрегаты - Списания основного баланса (добавлены ранее)

-- Клиентские агрегаты - Голосовые вызовы
-- CALL_HISTORY
executeCallHistory:='Insert into CALL_HISTORY_'||tablePrefixDwh||' (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID, CHARGE_CODE, PCL_FLAG)
Values ('||ctn||',  sysdate-7+'||iterator||'/(24*60), ''79000000000'', 360, ''OUTGOING_OPPS_CALL'', 0, 16, 0, 0, ''791111234123'', 784048896812, 49030797, 23, ''79030373333_D4603'', null, ''94'', ''RUR'', ''[1~150.0000~10.0~0]'', 108, 1, ''MOHYRYYY'', 0)';
iterator:=iterator+1;
execute immediate executeCallHistory;
executeCallHistory:='Insert into CALL_HISTORY_'||tablePrefixDwh||' (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID, CHARGE_CODE, PCL_FLAG)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), ''79000000000'', 360, ''INCOMING_TPPS_CALL'', 0, 16, 0, 0, ''791111234123'', 784048896812, 49030797, 23, ''79030373333_D4502'', null, ''94'', ''RUR'', ''[1~150.0000~10.0~0]'', 108, 1, ''MOHYHYYY'', 0)';
iterator:=iterator+1;
execute immediate executeCallHistory;

-- Клиентские агрегаты - SMS и MMS
-- PS_TRANSACTION (SMS-транзакция)
executePsTransaction:='Insert into PS_TRANSACTION_'||tablePrefixDwh||' (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, REFUND_FLAG, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, BALANCES_INFO, MSC_ID, IDENTITY_ID, CHARGE_CODE, FUND_USAGE_TYPE, PCL_FLAG)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), ''1'', 4, ''79030372222'', ''N'', 1234, 49030797, 23, ''RUR'', ''[1~150~10~0]'', ''79030372222'', 1, ''NYHYRYYY'', 1, 0)';
iterator:=iterator+1;
execute immediate executePsTransaction;
-- OSA_HISTORY (MMS-транзакция)
executeOsaHistory:='Insert into OSA_HISTORY_'||tablePrefixDwh||' (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, SERVICE_PARAMETER_3, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, GROUP_ID, CHARGE_CODE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE, PCL_FLAG)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), sysdate-7+'||iterator||'/(24*60), ''unitBasedCharge'', 1, 400, 0, 225, 1796, ''64'', 21, ''MMS'', ''INT GPRS charging'', 12345, 2, 1, ''SGSN_IP_ADDRESS:85.115.245.175'', ''MMS'', ''''''VOLUME_K'''''', -1, ''IP85.115.245.246'', 2, ''12345'', ''''''065005;054400;10000#GGSN6-5;3606337158;31732;5'''''', '''', ''SYHYRYYY'', 1, ''RUR'', 1, 12345, 12345, 23, ''GPRS_BEELINE_CENTER'', ''[1~150~10~0]'', '''', ''1234'', 1, 0)';
iterator:=iterator+1;
execute immediate executeOsaHistory;

-- Клиентские агрегаты - Мобильный интернет
-- OSA_HISTORY
executeOsaHistory:='Insert into OSA_HISTORY_'||tablePrefixDwh||' (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, SERVICE_PARAMETER_3, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, GROUP_ID, CHARGE_CODE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE, PCL_FLAG)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), sysdate-7+'||iterator||'/(24*60), ''unitBasedCharge'', 500, 400, 0, 225, 1796, ''64'', 21, ''GPRS'', ''INT GPRS charging'', 12345, 2, 1, ''SGSN_IP_ADDRESS:85.115.245.175'', ''''''Internet'''''', ''''''VOLUME_K'''''', -1, ''IP85.115.245.246'', 2, ''12345'', ''''''065005;054400;10000#GGSN6-5;3606337158;31732;5'''''', '''', ''GYNYYYYY'', 1, ''RUR'', 1, 12345, 12345, 23, ''GPRS_BEELINE_CENTER'', ''[1~150~10~0]'', '''', ''0'', 1, 0)';
iterator:=iterator+1;
execute immediate executeOsaHistory;

-- Клиентские агрегаты - Информационно-развлекательные услуги (добавлены ранее в фильтре CPA)

-- Клиентские агрегаты - Международные звонки
-- CALL_HISTORY
executeCallHistory:='Insert into CALL_HISTORY_'||tablePrefixDwh||' (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID, CHARGE_CODE, PCL_FLAG)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), ''79000000000'', 360, ''OUTGOING_OPPS_CALL'', 0, 16, 0, 0, ''791111234123'', 784048896812, 49030797, 23, ''79030373333_D0299'', null, ''94'', ''RUR'', ''[1~150~10~0]'', 108, 1, ''MOHYIYYY'', 0)';
iterator:=iterator+1;
execute immediate executeCallHistory;

-- Клиентские агрегаты - Международный роуминг
-- CALL_HISTORY
executeCallHistory:='Insert into CALL_HISTORY_'||tablePrefixDwh||' (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID, CHARGE_CODE, PCL_FLAG)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), ''79000000000'', 360, ''OUTGOING_OPPS_CALL'', 0, 16, 0, 0, ''791111234123'', 784048896812, 49030797, 23, ''79038889987'', null, ''94'', ''RUR'', ''[1~150~10~0]'', 108, 1, ''MTIYHYYY'', 0)';
iterator:=iterator+1;
execute immediate executeCallHistory;
-- OSA_HISTORY
executeOsaHistory:='Insert into OSA_HISTORY_'||tablePrefixDwh||' (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, SERVICE_PARAMETER_3, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, GROUP_ID, CHARGE_CODE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE, PCL_FLAG)
Values ('||ctn||', sysdate-7+'||iterator||'/(24*60), sysdate-7+'||iterator||'/(24*60), ''unitBasedCharge'', 1, 400, 0, 225, 1796, ''64'', 21, ''MMS'', ''INT GPRS charging'', 12345, 2, 1, ''SGSN_IP_ADDRESS:85.115.245.175'', ''MMS'', ''''''VOLUME_K'''''', -1, ''IP85.115.245.246'', 2, ''12345'', ''''''065005;054400;10000#GGSN6-5;3606337158;31732;5'''''', '''', ''MMNINTN000'', 1, ''RUR'', 1, 12345, 12345, 23, ''GPRS_BEELINE_CENTER'', ''[1~150~10~0]'', '''', ''1234'', 1, 0)';
iterator:=iterator+1;
execute immediate executeOsaHistory;

-- Клиентские агрегаты - Оплата услуг и мобильные переводы (добавлены ранее в фильтре Мобильная коммерция)

-- Клиентские агрегаты - Абонентская плата и подключение услуг
-- MTR
executeMtr:='Insert into MTR_'||tablePrefixDwh||' (ID, LOGIN_NAME, BALANCE_TYPE, MTR_COMMENT, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, PREV_COS_ID, CURRENT_COS_ID, BALANCES_INFO, IDENTITY_ID, PCL_FLAG)
Values (0, ''CCBO_AUTOTEST'', 0, ''A26'', sysdate-7+'||iterator||'/(24*60), 23, '||ctn||', ''RUR'', ''RUR'', 28.3, 2, 2, ''[1~150.0~10.0~0]'', 1, 0)';
iterator:=iterator+1;
execute immediate executeMtr;
commit;
end;


/*
-- скрипт для быстрой очистки всех таблиц, т.к. после выполнения автотеста удаление данных не предусмотрено
declare
ctn varchar2(100);					-- номер абонента
tablePrefixDwh varchar2(10);		-- префикс таблицы
deleteCallHistory varchar2(5000);
deleteMtr varchar2(5000);
deleteOsaHistory varchar2(5000);
deletePsTransaction varchar2(5000);
deleteRechargeHistory varchar2(5000);
deleteRoamingCalls varchar2(5000);
deleteUsersessions varchar2(5000);
deleteAccumulator varchar2(5000);
deleteScratchCardNew varchar2(5000);
deleteSubsAlcsHist varchar2(5000);
deleteRc varchar2(5000);
deleteNrc varchar2(5000);

begin
ctn:='9030371112';
tablePrefixDwh:='URL';
deleteCallHistory:='delete from call_history_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and (call_date_time between trunc(sysdate)-15 and sysdate)';
deleteMtr:='delete from mtr_'||tablePrefixDwh||' where pps_account in('||ctn||',7'||ctn||') and (mtr_date_time between trunc(sysdate)-15 and sysdate)';
deleteOsaHistory:='delete from osa_history_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and (start_call_date_time between trunc(sysdate)-15 and sysdate)';
deletePsTransaction:='delete from ps_transaction_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and (transaction_date_time between trunc(sysdate)-15 and sysdate)';
deleteRechargeHistory:='delete from recharge_history_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and (recharge_date_time between trunc(sysdate)-15 and sysdate)';
deleteRoamingCalls:='delete from ROAMING_CALLS where subscriber_id in('||ctn||',7'||ctn||') and (call_date_time between trunc(sysdate)-15 and sysdate)';
deleteUsersessions:='delete from USERSESSIONS where CHRMSISDN in('||ctn||',7'||ctn||') and (dtmstartdate between trunc(sysdate)-15 and sysdate)';
deleteAccumulator:='delete from ACCUMULATOR where CHRMSISDN in('||ctn||',7'||ctn||') and (dtmsyscreationdate between trunc(sysdate)-15 and sysdate)';
deleteScratchCardNew:='delete from SCRATCH_CARD_NEW where phone_number in('||ctn||',7'||ctn||') and (operation_date between trunc(sysdate)-15 and sysdate)';
deleteSubsAlcsHist:='delete from SUBS_ALCS_HIST where subscriber_id in('||ctn||',7'||ctn||') and (alcs_action_date_time between trunc(sysdate)-15 and sysdate)';
deleteRc:='delete from rc_'||tablePrefixDwh||' where pps_account in('||ctn||',7'||ctn||') and (rc_date_time between trunc(sysdate)-15 and sysdate)';
deleteNrc:='delete from nrc_'||tablePrefixDwh||' where pps_account in('||ctn||',7'||ctn||') and (nrc_date_time between trunc(sysdate)-15 and sysdate)';
execute immediate deleteCallHistory;
execute immediate deleteMtr;
execute immediate deleteOsaHistory;
execute immediate deletePsTransaction;
execute immediate deleteRechargeHistory;
execute immediate deleteRoamingCalls;
execute immediate deleteUsersessions;
execute immediate deleteAccumulator;
execute immediate deleteScratchCardNew;
execute immediate deleteSubsAlcsHist;
execute immediate deleteRc;
execute immediate deleteNrc;

commit;
end;
*/
