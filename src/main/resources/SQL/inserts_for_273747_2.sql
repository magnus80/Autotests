declare
ctn varchar2(100);
iterator number; -- �������
amountTransactions number; -- ���������� ����������
tablePrefixDwh varchar2(10);
--workTables
executeMtr varchar2(5000);
executeCallHistory varchar2(5000);
executePsTransaction varchar2(5000);
executeReachargeHistory varchar2(5000);
executeOsaHistory varchar2(5000);
executeRc varchar2(5000);
begin
ctn:='9030371111';
amountTransactions:=32;
tablePrefixDwh:='URL';
iterator:=0;

loop

insert into roaming_calls (SUBSCRIBER_ID, CALL_DATE_TIME, CALL_DURATION, CALLED_NUMBER, TOTAL_CHARGE, NEW_BALANCE, OPERATION_DATE_TIME, COS, ROAMING_PARTNER, T_O, CALL_ID, SLICE, BILLSYSTEM_CODE, VOLUME, MEASURE)
values ('7'||ctn||'', sysdate, 199, 'CCBOtest', -13.7979, 0, sysdate, '', 'GABCT', '2V', 19428494, 121943360, 27, 0, 'SE');
iterator:=iterator+1;
exit when iterator>amountTransactions;

Insert into USERSESSIONS
   (NUMCHARGEID, CHRMSISDN, VCHAPN, DTMSTARTDATE, NUMVOLUME, NUMRATEDVOLUME, DTMSYSCREATIONDATE, DTMSYSUPDATEDATE, BILLSYSTEM_CODE, SLICE)
 Values
   (564, ''||ctn||'', 'test', sysdate, 1024, 1633280, sysdate, NULL, 28, 7777400);
iterator:=iterator+1;
exit when iterator>amountTransactions;

--MTR
executeMtr:='insert into mtr_'||tablePrefixDwh||' (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
values (null, 0, ''ccboAutoTest'', null, null, 0, null,''XPB,sdf*,sd*'', null, null, null, null, null, null, 2009114048420, 121943617, sysdate-7+'||iterator||'/(24*60), 27, '||ctn||', null, null, null, null, ''RUR'', '''', null, null, null, null, null, null, null, ''[1~100~10~0]'', null, null, null, null, null)';
execute immediate executeMtr;
iterator:=iterator+1;
exit when iterator>amountTransactions;

--CALL_HISTORY
executeCallHistory:='Insert into CALL_HISTORY_'||tablePrefixDwh||'
   (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
 Values
   ('||ctn||', sysdate-7+'||iterator||'/(24*60), ''79030372222'', 360, ''OUTGOING_OPPS_CALL'', 0, 16, 0, 0, ''79281111111'', 784048896812, 49030797, 28, ''79038889987'', ''250991770305226'', ''94'', ''RUR'', ''[1~100~10~0]'', 108, 1)';
execute immediate executeCallHistory;
iterator:=iterator+1;
exit when iterator>amountTransactions;

--PS_TRANSACTION
executePsTransaction:='Insert into PS_TRANSACTION_'||tablePrefixDwh||'
   (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, REFUND_ID_1, REFUND_ID_2, CALL_ID, SLICE, BILLSYSTEM_CODE, TYPE_OF_CHARGE, ISO_CODE, BALANCES_INFO, IDENTITY_ID, SUBTYPE_ID, ORP_DATE,MSC_ID,charge_code)
 Values
   ('||ctn||', sysdate-7+'||iterator||'/(24*60), ''1'', ''4'', ''79030372222'', 833973252, 3256868758, ''Y'', 0, 0, 379918750951, 6170003, 28, ''1234'', ''RUR'', ''[1~100~10~0]'', 1, 4020, sysdate-7+'||iterator||'/(24*60),''1234'',1426)';
execute immediate executePsTransaction;
iterator:=iterator+1;
exit when iterator>amountTransactions;

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
--OSA_HISTORY
executeOsaHistory:='Insert into OSA_HISTORY_'||tablePrefixDwh||'
   (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, DESCRIPT, REASON_CODE, NEW_BALANCE_1, CHANGE_AMOUNT_1, NEW_BALANCE_2, CHANGE_AMOUNT_2, NEW_BALANCE_3, CHANGE_AMOUNT_3, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_7, CHANGE_AMOUNT_7, NEW_BALANCE_8, CHANGE_AMOUNT_8, NEW_BALANCE_9, CHANGE_AMOUNT_9, NEW_BALANCE_10, CHANGE_AMOUNT_10, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, PARAM_CONFIRM_ID, PARAM_CONTRACT, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, SERVICE_PARAMETER_5, LOCATION_A3, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, CURRENCY, IDENTITY_ID, GROUP_ID, CHARGE_CODE, SPENDING_LIMIT1, SPENDING_LIMIT2, SPENDING_LIMIT3, SPENDING_LIMIT4, SPENDING_LIMIT5, SPENDING_LIMIT6, SPENDING_LIMIT7, SPENDING_LIMIT8, SPENDING_LIMIT9, SPENDING_LIMIT10, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE)
 Values
   ('||ctn||',sysdate-7+'||iterator||'/(24*60), sysdate-7+'||iterator||'/(24*60),''unitBasedCharge'', 1000, 
    NULL, 400, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, 0, 224, 1806, 
    ''42'', 21, ''GPRS'', ''INT GPRS charging'', 12345, 
    2, 1, ''SGSN_IP_ADDRESS:193.152.100.38'',''''''Internet'''''', ''''''VOLUME_K'''''', 
    NULL, NULL, 86, -1, -1, 
    -1, -1, NULL, NULL, 2, 
    ''9030372222'', 2, ''240991420235429'', ''''''000000;000000;10000#GGSN6-5;3602306640;31728;1'''''', NULL, 
    NULL, NULL, 2490, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, sysdate-7+'||iterator||'/(24*60), 1, 
    ''RUR'', NULL, 1, 2029562997434, 122115318, 
    2, ''GPRS_BEELINE_ASIA'', ''[1~100~10~0]'', NULL, ''1424296704322'',1)';
execute immediate executeOsaHistory;
iterator:=iterator+1;
exit when iterator>amountTransactions;
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