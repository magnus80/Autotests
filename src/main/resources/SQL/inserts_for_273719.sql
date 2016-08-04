declare
ctn varchar2(100); 
subscr_no varchar2(100);
account_no varchar2(100);
executeMtrStmt varchar2(5000);
executeCallHistoryStmt varchar2(5000);
executeOsaHistoryStmt varchar2(5000);
executePsTransactionStmt varchar2(5000);
executeRechargeHistoryStmt varchar2(5000);
executeRCStmt varchar2(5000);
executeRcBalanceStmt varchar2(5000);
mtr_id number;
rc_id number;
rc_id2 number;
recharge_id number;
recharge_id2 number;
MtrTablePrefix_AB varchar2(100); 
CallHistoryTablePrefix_AB varchar2(100);
OsaHistoryTablePrefix_AB varchar2(100);
PsTransactionTablePrefix_AB varchar2(100);
RechargeHistoryTablePrefix_AB varchar2(100);
iterator number;
exitStmt number;
mtr_id_1a number;
mtr_id_1b number;
begin
ctn:='79030371111';
exitStmt:=50;
select subscr_no into subscr_no from account_subscriber where range_map_external_id=ctn;
select account_no into account_no from account_subscriber where range_map_external_id=ctn;
for  c in (select c.table_name,c.table_ab  from INSERT_CONTROL c where table_name in('MTR','CALL_HISTORY','OSA_HISTORY','PS_TRANSACTION','RECHARGE_HISTORY') and  c.active_set='Y')
loop
case(c.table_name)
when 'MTR' then MtrTablePrefix_AB:=c.table_ab;
when 'CALL_HISTORY' then CallHistoryTablePrefix_AB:=c.table_ab;
when 'OSA_HISTORY' then OsaHistoryTablePrefix_AB:=c.table_ab;
when 'PS_TRANSACTION' then PsTransactionTablePrefix_AB:=c.table_ab;
when 'RECHARGE_HISTORY' then RechargeHistoryTablePrefix_AB:=c.table_ab;
end case;
end loop;
begin
execute immediate 'select max(mtr_id) from mtr_main_1a' into mtr_id_1a;
EXCEPTION when  others
then
null;
end;
begin
execute immediate 'select max(mtr_id) from mtr_main_1b' into mtr_id_1b; 
EXCEPTION when  others
then
null;
end;
case (MtrTablePrefix_AB)
when '1A' then mtr_id:=mtr_id_1a ;
when '1B' then mtr_id:=mtr_id_1b ;
end case;
mtr_id:=NVL(mtr_id,1);
mtr_id:=mtr_id+1;
select max(RC_TERM_INST_ID) into rc_id  from rc_balance;
select max(RC_TERM_INST_ID) into rc_id2  from rc;
rc_id:=NVL(rc_id,1);
rc_id2:=NVL(rc_id2,1);
if(rc_id>rc_id2) then rc_id:=rc_id+1;
else rc_id:=rc_id2+1; 
end if;
iterator:=0;
execute immediate 'select max(recharge_id) from RECHARGE_HISTORY_MAIN_'||RechargeHistoryTablePrefix_AB||'' into recharge_id;
execute immediate 'select max(recharge_id2) from RECHARGE_HISTORY_MAIN_'||RechargeHistoryTablePrefix_AB||'' into recharge_id2;
recharge_id:=NVL(recharge_id,1); 
recharge_id2:=NVL(recharge_id2,1);
recharge_id:=recharge_id+1;
recharge_id2:=recharge_id2+1;
loop
--MTR
executeMtrStmt:='INSERT INTO MTR_MAIN_'||MtrTablePrefix_AB||'(subscr_no,subscr_no_resets,account_no,owning_account_no,mtr_id2,mtr_id,mtr_type,mtr_sub_type,
mtr_comment,mod_date,login_name,mtr_source,extract_file_id,subscriber_currency,reseller_id,bal_info,accu_info,offer_info,
mog_id,group_account_type,fund_usage_type,pcl_flag,ple_flag) 
VALUES ('||subscr_no||',0,'||account_no||',0,150,'||mtr_id||',14,1,''CCBOtest'',sysdate+('||iterator||'/24/60),
''sapiuser'',3,2,''RUR'',0,
''[1~150.0~10~~0~1][2~0.0~0.0~~0~1][3~0~0~0001-01-01 00:00:00~0~1][4~20.0~0.0~~0~1][5~0.0~0.0~2023-10-22 00:00:00~0~1][6~0.0~0.0~2023-10-22 00:00:00~0~1][7~0.0~0.0~~0~1][8~0.0~0.0~~0~1][9~0.0~0.0~~0~1][10~0.0~0.0~2023-10-22 00:00:00~0~1][11~0.0~0.0~~0~1][12~0.0~0.0~~0~1][13~0.0~0.0~~0~1][14~0.0~0.0~~0~1][15~0.0~0.0~~0~1][17~0.0~0.0~~0~1][16~0.0~0.0~~0~1][19~600.0~0.0~2014-11-05 00:00:00~0~1][18~0.0~0.0~2033-12-16 00:00:00~0~1][20~0.0~0.0~~0~1]'',
''[4~0.0~0.0][8~145.0~0.0][10~0.0~0.0][12~0.0~0.0][14~0.0~0.0][17~0.0~0.0][21~0.0~0.0][22~0.0~0.0][23~0.0~0.0][27~0.0~0.0][29~0.0~0.0][57~0.0~0.0][58~1612.38~0.0][72~0.0~0.0][105~0.0~0.0][106~0.0~0.0][112~0.0~0.0]'',
''[216]'',1,6,1,0,0)';
mtr_id:=mtr_id+1;
iterator:=iterator+1;
exit when iterator>exitStmt;
execute immediate executeMtrStmt;
--CALL_HISTORY
executeCallHistoryStmt:='Insert into CALL_HISTORY_MAIN_'||CallHistoryTablePrefix_AB||'
   (SUBSCR_NO_RESETS, SUBSCR_NO, ACCOUNT_NO, PARENT_ACCOUNT_NO, START_CALL_DATE_TIME, END_CALL_DATE_TIME, USAGE_AMOUNT, EXTERNAL_ID_TYPE, EXTERNAL_ID, RESELLER_ID, APN_ID, QOS_ID, UNIT_TYPE_ID, SLU_ID, CELL_ID, MSC_ID, SUBTYPE_ID, APPLICATION_ID, ADDITIONAL_NUMBER, REASON_CODE, DESCRIPT, FINAL_AUT_ID, INITIAL_AUT_ID, CALLED_NUMBER, TARGET_ACCOUNT_NO, ACTIVITY_TYPE, CIRCLE_ID, CONV_RATE_TO_BILLED_ACCOUNT, BILLED_ACCOUNT_CURRENCY, BILLED_ACCOUNT_TML_CHANGE, BILLED_ACCOUNT_TML_VALUE, CONVERSION_RATE_TO_SUB, RATE_CURRENCY, SUBSCRIBER_CURRENCY, CHARGE_CODE, ORP_TIME, CRN, LIABILITY_REDIRECT_INDICATOR, USER_SUBSCR_NO_RESETS, USER_SUBSCR_NO, SPLIT_ROW_NUM, MSG_ID2, MSG_ID, PRE_ISO_CODE, GSM_PROVIDER_ID, PRE_CHARGE, MARKUP_PERCENT, BAL_INFO, ACCU_INFO, ACCT_ACCU_INFO, ACCT_BAL_INFO, EXT_FIELD, TIMEZONE, NETWORK_PORTING_PREFIX, ACTUAL_ORIGINATING_NUMBER, ACTUAL_DESTINATION_NUMBER, ROUNDED_DURATION, START_CALL_DATE_TIME_SUB_TZ, END_CALL_DATE_TIME_SUB_TZ, INCOMING_CALL_ID, OUTGOING_CALL_ID, RECORD_SOURCE, EXT_USSD_RESP_USED, USSD_RESPONSE_CODE, MOG_ID, TARIFF_PLAN_ID, ORIG_TARIFF_PLAN_ID, USAGE_OFFER_ID, GROUP_ACCOUNT_INFO, TARGET_SUBSCR_NO, TARGET_SUBSCR_NO_RESETS, GROUP_ACCOUNT_TYPE, FUND_USAGE_TYPE, CA_EXTERNAL_ID, IS_SP_RATED_TRANSACTION, CHANGES_IN_BALS_CHARGED, PCL_FLAG)
 Values
   (0, '||subscr_no||', '||account_no||', NULL,sysdate+('||iterator||'/24/60), 
    sysdate+('||(iterator+1)||'/24/60), 360, 1, ''79031264060'', 0, 
    NULL, NULL, 2, ''4'', ''250996500803592'', 
    ''CCBOtest'', 418, 1, NULL, 407, 
    NULL, 394, 1, ''79031440050'', NULL, 
    ''OUTGOING_OPPS_CALL'', NULL, 1, ''RUR'', NULL, 
    NULL, 1, ''RUR'', ''RUR'', ''104'', 
    sysdate, 98371, NULL, NULL, NULL, 
    NULL, 56860001, 496304708, ''RUR'', NULL, 
    NULL, NULL, ''[1~100.0000~5.0000~0][2~0.0000~0.0000~0][3~0.0000~0.0000~0][4~0.0000~0.0000~0][5~0.0000~0.0000~0][6~0.0000~0.0000~0][7~0.0000~0.0000~0][8~0.0000~0.0000~0][9~0.0000~0.0000~0][10~0.0000~0.0000~0][11~0.0000~0.0000~0][12~0.0000~0.0000~0][13~0.0000~0.0000~0][14~0.0000~0.0000~0][15~0.0000~0.0000~0][16~0.0000~0.0000~0][17~0.0000~0.0000~0][18~0.0000~0.0000~0][19~0.0000~0.0000~0][20~0.0000~0.0000~0]'',
    ''[14~0.000000~0.000000][19~0.000000~0.000000][21~0.000000~0.000000][22~0.000000~0.000000][25~0.000000~0.000000][27~0.000000~0.000000][28~0.000000~0.000000][29~0.000000~0.000000][30~0.000000~0.000000][33~0.000000~0.000000][46~0.000000~0.000000][47~0.000000~0.000000][48~0.000000~0.000000][77~0.000000~0.000000][78~0.000000~0.000000][126~0.000000~0.000000][135~0.000000~0.000000][145~0.000000~0.000000][146~0.000000~0.000000][321~0.000000~0.000000][330~0.000000~0.000000][331~0.000000~0.000000][370~0.000000~0.000000][457~0.000000~0.000000][506~0.000000~0.000000][566~0.000000~0.000000]'', NULL, 
    NULL, NULL, 1, NULL, ''79031264060'', 
    ''79031440050'', 0, sysdate, sysdate, NULL, 
    NULL, 1, 0, NULL, 4, 
    5105, NULL, 62, NULL, NULL, 
    NULL, 6, 1, NULL, 0, 
    NULL, 0)';
iterator:=iterator+1;
exit when iterator>exitStmt;
execute immediate executeCallHistoryStmt;
--OSA_HISTORY
executeOsaHistoryStmt:='Insert into OSA_HISTORY_MAIN_'||OsaHistoryTablePrefix_AB||'
   (SUBSCR_NO_RESETS, SUBSCR_NO, ACCOUNT_NO, PARENT_ACCOUNT_NO, TARGET_ACCOUNT_NO, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, SPLIT_ROW_NUM, DESCRIPT, REASON_CODE, INITIAL_AUT_ID, FINAL_AUT_ID, SUBTYPE_ID, APPLICATION_ID, UNIT_TYPE_ID, SLU_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, EXTERNAL_ID, EXTERNAL_ID_TYPE, APPLICATION_DESC, OSA_ITEM, OSA_SUB_TYPE, PARAM_CONFIRM_ID, PARAM_CONTRACT, QOS, SERVICE_PARAMETER1, SERVICE_PARAMETER2, SERVICE_PARAMETER3, SERVICE_PARAMETER4, SERVICE_PARAMETER5, LOCATION_A, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, CURRENCY, CHARGE_CODE, ORP_DATE, SUBSCRIBER_CURRENCY, RESELLER_ID, CONV_RATE_TO_BILLED_ACCT, BILLED_ACCOUNT_CURRENCY, BILLED_ACCOUNT_TML_CHANGE, BILLED_ACCOUNT_TML_VALUE, LIABILITY_REDIRECT_INDICATOR, USER_SUBSCR_NO_RESETS, USER_SUBSCR_NO, MSG_ID2, MSG_ID, PREV_ISO_CODE, CURR_CONV_RATE, GSM_PROVIDER_ID, PRE_CHARGE, MARKUP_PERCENT, ACCU_INFO, BAL_INFO, ACCT_ACCU_INFO, ACCT_BAL_INFO, EXT_FIELD, TIMEZONE, ROUNDED_DURATION, START_CALL_DATE_TIME_SUB_TZ, END_CALL_DATE_TIME_SUB_TZ, RECORD_SOURCE, SESSION_ID, MOG_ID, TARIFF_PLAN_ID, ORIG_TARIFF_PLAN_ID, USAGE_OFFER_ID, ACCOUNT_ID, GROUP_ACCOUNT_INFO, TARGET_SUBSCR_NO, TARGET_SUBSCR_NO_RESETS, GROUP_ACCOUNT_TYPE, FUND_USAGE_TYPE, ACTUAL_SERVICE_PARAMETER1, ACTUAL_SERVICE_PARAMETER2, ACTUAL_SERVICE_PARAMETER3, ACTUAL_SERVICE_PARAMETER4, CELL_ID, PCL_FLAG)
 Values
   (0, '||subscr_no||', '||account_no||', NULL, NULL, 
    sysdate+('||iterator||'/24/60), sysdate+('||(iterator+1)||'/24/60), ''unitBasedCharge'', 1000, NULL, 
    NULL, 414, 94, 891, 1801, 
    225, 21, ''1'', ''GPRS'', NULL, 
    10, 200, ''79031441273'', 1, ''CCBOtest'', 
    ''Internet'', ''VOLUME_K'', NULL, NULL, 86, 
    -1, -1, -1, -1, NULL, 
    ''GPRS_BEELINE_SIBERIA'', 2, ''IP71111111111'', 2, ''39031441273'', 
    NULL, NULL, ''2713'', sysdate+('||iterator||'/24/60), ''RUR'', 
    0, 0, ''RUR'', 0, 0, 
    NULL, NULL, NULL, 56860001, 496304706, 
    NULL, 0, NULL, NULL, NULL, 
    ''[5~0.000000~0.000000][14~0.000000~0.000000][21~0.000000~0.000000][22~0.000000~0.000000][25~0.000000~0.000000][27~0.000000~0.000000][28~0.000000~0.000000][29~0.000000~0.000000][30~0.000000~0.000000][33~0.000000~0.000000][34~0.000000~0.000000][77~0.000000~0.000000][78~0.000000~0.000000][96~0.000000~0.000000][135~0.000000~0.000000][136~0.000000~0.000000][137~0.000000~0.000000][145~0.000000~0.000000][146~0.000000~0.000000][233~0.000000~0.000000][318~0.000000~0.000000][330~0.000000~0.000000][331~0.000000~0.000000][370~0.000000~0.000000][457~0.000000~0.000000][506~0.000000~0.000000][591~0.000000~0.000000]''
    ,''[1~10.0000~0.0000~0][2~0.0000~0.0000~0][3~0.0000~0.0000~0][4~0.0000~0.0000~0][5~0.0000~0.0000~0][6~0.0000~0.0000~0][7~0.0000~0.0000~0][8~0.0000~0.0000~0][9~0.0000~0.0000~0][10~0.0000~0.0000~0][11~0.0000~0.0000~0][12~0.0000~0.0000~0][13~0.0000~0.0000~0][14~0.0000~0.0000~0][15~0.0000~0.0000~0][16~0.0000~0.0000~0][17~0.0000~0.0000~0][18~0.0000~0.0000~0][19~0.0000~0.0000~0][20~0.0000~0.0000~0]'', NULL, NULL, NULL, 
    1, 0, sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), 1, 
    33554534, 1, 5582, NULL, 2110, 
    1, NULL, NULL, NULL, 6, 
    1, ''-1'', ''MIX'', ''-1'', ''900'', 
    NULL, 0)';
iterator:=iterator+1;
exit when iterator>exitStmt;
execute immediate executeOsaHistoryStmt;
--PS_TRANSACTION
executePsTransactionStmt:='Insert into PS_TRANSACTION_MAIN_'||PsTransactionTablePrefix_AB||' (SUBSCR_NO, SUBSCR_NO_RESETS, ACCOUNT_NO, TRANS_ID_1, TRANS_ID_2, DATE_TIME, USAGE_AMOUNT, REFUND_FLAG, CONTENT_TYPE, INITIAL_AUT_ID, FINAL_AUT_ID, SUB_ID2, MESSAGE_TYPE, SUBSCRIBER_TYPE, PARENT_ACCOUNT_NO, TARGET_ACCOUNT_NO, UNIT_TYPE_ID, SUBTYPE_ID, APPLICATION_ID, SPLIT_ROW_NUM, MSG_ID2, MSG_ID, SLU_ID, RESELLER_ID, EXTERNAL_ID_TYPE, EXTERNAL_ID, MSC_ID, REQUESTED_ISO_CODE, SUBSCRIBER_CURRENCY, ORP_DATE, SERVICE_CODE, CURR_CONV_RATE, CONV_RATE_BILLED_ACCOUNT, BILLED_ACCOUNT_CURRENCY, BILLED_ACCOUNT_TML_CHANGE, BILLED_ACCOUNT_TML_VALUE, LIABILITY_REDIRECT_INDICATOR, ACCU_INFO, BAL_INFO, TIMEZONE, ROUNDED_DURATION, RECORD_SOURCE, MOG_ID, TARIFF_PLAN_ID, USAGE_OFFER_ID, GROUP_ACCOUNT_TYPE, FUND_USAGE_TYPE)
Values ('||subscr_no||', 0, '||account_no||', 4106502161, 2119905857, sysdate+('||(iterator+1)||'/24/60), 1, ''N'', 2, 3, 793, ''9030371111'', 4, ''1'', 0, 0, 4, 928, 2, 0, 49610001, 317409045, ''17'', 0, 1, ''79645344024'', ''5294100077980'', ''RUR'', ''RUR'', sysdate+('||(iterator+1)||'/24/60), 0, 1, 1, ''RUR'', 0, 0, 0, ''[14~0.000000~0.000000][22~0.000000~0.000000][29~152.000000~0.000000][30~0.000000~0.000000][33~0.000000~0.000000][46~0.000000~0.000000][47~0.000000~0.000000][48~19.000000~19.000000][77~0.000000~0.000000][78~0.000000~0.000000][126~0.000000~0.000000][146~0.000000~0.000000][158~0.000000~0.000000][159~0.000000~0.000000][222~0.000000~0.000000][223~0.000000~0.000000][136~0.000000~0.000000][284~0.000000~0.000000][27~407.500000~0.000000][28~310.950000~0.000000][157~0.000000~0.000000][21~3.000000~0.000000][145~0.000000~0.000000]'', ''[1~573.9000~-19.0000~0]'', 1, 0, 1, 1, 5250, 638, 6, 1)';
iterator:=iterator+1;
exit when iterator>exitStmt;
execute immediate executePsTransactionStmt;
--RECHARGE_HISTORY
executeRechargeHistoryStmt:='Insert into RECHARGE_HISTORY_MAIN_'||RechargeHistoryTablePrefix_AB||' (SUBSCR_NO, SUBSCR_NO_RESETS, ACCOUNT_NO, RECHARGE_DATE_TIME, FACE_VALUE, CARD_NUMBER, VOUCHER_TYPE, EXPIRATION_OFFSET, RECHARGE_ID2, RECHARGE_ID, RECHG_OR_DIRECT_BAL, RCHG_SRC, UNIT_TYPE_ID, RECHARGE_COMMENT, BATCH_NUMBER, RCT_ID, RECHARGE_USER, SUB_ACCT_TYPE, RESELLER_ID, EXTRACT_FILE_ID, BILLING_SERVER_ID, VOUCHER_CURRENCY, SUBSCRIBER_CURRENCY, CURRENCY_CONV_RATE, CHARGE_CODE, BAL_INFO, ACCU_INFO, EXT_FIELD, MOG_ID)
Values ('||subscr_no||', 0, '||account_no||', sysdate+('||(iterator+1)||'/24/60), 40, ''non voucher'', 0, 0, '||recharge_id2||', '||recharge_id||', 2, 7, 1, ''XPB,Recharge_online'', -1, 253, ''test'', 1, 0, 3, 1, ''RUR'', ''RUR'', 1, ''1'', ''[1~115.15~40~~0~1]'', ''[4~0~0][8~29.85~0][12~0~0][14~29.85~0][16~0~0][17~0~0][27~0~0][57~9.95~0][58~40~-40][72~19.9~0][105~0~0][106~0~0][111~0~0][112~0~0][128~0~0][234~0~0][235~0~0][236~0~0][286~0~0]'', ''79039613810'', 4)';
iterator:=iterator+1;
recharge_id:=recharge_id+1;
recharge_id2:=recharge_id2+1;
exit when iterator>exitStmt;
execute immediate executeRechargeHistoryStmt;
--RC
executeRCStmt:='Insert into CBS_OWNER.RC (RC_TERM_INST_ID, BILLING_SEQUENCE_NUMBER, SPLIT_ROW_NUM, SPLIT_OVER_ACCTS, BILLING_ACCOUNT_NO, PARENT_ACCOUNT_NO, PARENT_SUBSCR_NO, PARENT_SUBSCR_NO_RESETS, OFFER_ID, CONTRACT_USE_CODE, FROM_DATE, TO_DATE, NUM_DAYS, CYCLE_FROM_DATE, CYCLE_TO_DATE, APPLY_DATE, CREATE_DATE, RC_INST_START_DATE, PCM_ACTIVE_DT, EXPECTED_CUTOFF_DT, PRORATE_CODE, BASE_AMT, PRORATED_AMOUNT, AMOUNT, AMOUNT_POSTPAID, AMOUNT_PREPAID, CURRENCY_CODE, HAS_OVERRIDES, RC_TERM_ID, BALANCE_COUNT, TAX_PKG_COUNT, TOTAL_TAX, TOTAL_TAX_POSTPAID, TOTAL_TAX_PREPAID, TOTAL_FEDERAL_TAX, TOTAL_STATE_TAX, TOTAL_COUNTY_TAX, TOTAL_CITY_TAX, TOTAL_OTHER_TAX, ALL_TAX_CALC, NUM_BILLED_LINES, NUM_TRUNK_LINES, PROVISIONED_AWARD_COUNT, RATED_CURRENCY_CODE, RATED_BY_SINGLE_VERSION, IS_BILLABLE, MOG_ID, FREQUENCY, BALANCE_INFO, ACCUMULATOR_INFO, RC_TERM_NAME, SERVICE_EXTERNAL_ID, IS_SERVICE_ITEM, IS_RC_RATED_SP_BAL,TARGET_SUBSCR_NO)
Values ('||rc_id||', 28, 0, 0, '||account_no||', '||account_no||', '||subscr_no||', 0, 1044, 12, sysdate + ('||(iterator+1)||'/24/60), sysdate + ('||(iterator+1)||'/24/60), 1, sysdate + ('||(iterator+1)||'/24/60), sysdate + ('||(iterator+1)||'/24/60), sysdate + ('||(iterator+1)||'/24/60), sysdate + ('||(iterator+1)||'/24/60), sysdate + ('||(iterator+1)||'/24/60), sysdate + ('||(iterator+1)||'/24/60), sysdate + ('||(iterator+1)||'/24/60), 4, 30000, 30000, 30000, 0, 30000, 3, 0, 549, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 1, 0, 4, 1,
''[1~27.0000~-2.7000~~0~1][2~0~0~0][3~3.0000~0~0][4~1.0000~0~0][5~300.0000~0~0][6~0~0~0][7~0~0~0][8~0~0~0][9~10.0000~0~0][10~0~0~0][11~0~0~0][12~0~0~0][13~0~0~0][14~0~0~0][15~0~0~0][17~0~0~0][16~0~0~0][19~0~0~0][18~0~0~0][20~10.0000~0~0]'', ''[14~0~0][16~0~0][17~0~0][27~0~0][57~0~0][58~0~0][105~0~0][106~0~0][111~0~0][112~0~0][286~0~0][236~0~0][235~0~0][234~0~0][72~0~0][128~0~0][4~0~0][8~0~0][12~0~0]'', ''TRUSTEDPAYMENT'', ''79030371111'', 0, 0,'||subscr_no||')';
executeRcBalanceStmt:='Insert into CBS_OWNER.RC_BALANCE (RC_TERM_INST_ID, BILLING_SEQUENCE_NUMBER, SPLIT_ROW_NUM, BALANCE_ID, BALANCE_AMOUNT, BALANCE_COUNTER, TARGET_ACCOUNT_NO, TARGET_BALANCE_ID, PAYMENT_MODE, TARGET_BALANCE_MODE, EXPECTED_CUTOFF_DT, IS_BILLABLE, FREQUENCY)
Values ('||rc_id||', 28, 0, 1, 27000, 1, '||account_no||', 1, 1, 1, sysdate + ('||(iterator+1)||'/24/60), 0, 3)';
iterator:=iterator+1;
rc_id:=rc_id+1;
exit when iterator>exitStmt;
execute immediate executeRCStmt;
execute immediate executeRcBalanceStmt;
end loop;
commit;
end;


