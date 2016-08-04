-- online: change in balance amount=0
declare
ctn varchar2(100); 
subscr_no varchar2(100);
account_no varchar2(100);
executeOsaHistoryStmt varchar2(5000);
OsaHistoryTablePrefix_AB varchar2(100);
iterator number;
exitStmt number;
core_balance varchar2(10);

begin
ctn:='79030372222';
exitStmt:=10;
iterator:=0;
core_balance:=1000;
select subscr_no into subscr_no from account_subscriber where range_map_external_id=ctn;
select account_no into account_no from account_subscriber where range_map_external_id=ctn;
for  c in (select c.table_name,c.table_ab  from INSERT_CONTROL c where table_name='OSA_HISTORY' and c.active_set='Y')
loop
case(c.table_name)
when 'OSA_HISTORY' then OsaHistoryTablePrefix_AB:=c.table_ab;
end case;
end loop;

loop
-- OSA_HISTORY, MERCHANT_ID = GPRS, ACTUAL_SERVICE_PARAMETER3 = NULL, разные OSA_SUB_TYPE
core_balance:=core_balance-0;
executeOsaHistoryStmt:='Insert into OSA_HISTORY_MAIN_'||OsaHistoryTablePrefix_AB||'
   (SUBSCR_NO_RESETS, SUBSCR_NO, ACCOUNT_NO, PARENT_ACCOUNT_NO, TARGET_ACCOUNT_NO, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, SPLIT_ROW_NUM, DESCRIPT, REASON_CODE, INITIAL_AUT_ID, FINAL_AUT_ID, SUBTYPE_ID, APPLICATION_ID, UNIT_TYPE_ID, SLU_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, EXTERNAL_ID, EXTERNAL_ID_TYPE, APPLICATION_DESC, OSA_ITEM, OSA_SUB_TYPE, PARAM_CONFIRM_ID, PARAM_CONTRACT, QOS, SERVICE_PARAMETER1, SERVICE_PARAMETER2, SERVICE_PARAMETER3, SERVICE_PARAMETER4, SERVICE_PARAMETER5, LOCATION_A, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, CURRENCY, CHARGE_CODE, ORP_DATE, SUBSCRIBER_CURRENCY, RESELLER_ID, CONV_RATE_TO_BILLED_ACCT, BILLED_ACCOUNT_CURRENCY, BILLED_ACCOUNT_TML_CHANGE, BILLED_ACCOUNT_TML_VALUE, LIABILITY_REDIRECT_INDICATOR, USER_SUBSCR_NO_RESETS, USER_SUBSCR_NO, MSG_ID2, MSG_ID, PREV_ISO_CODE, CURR_CONV_RATE, GSM_PROVIDER_ID, PRE_CHARGE, MARKUP_PERCENT, ACCU_INFO, BAL_INFO, ACCT_ACCU_INFO, ACCT_BAL_INFO, EXT_FIELD, TIMEZONE, ROUNDED_DURATION, START_CALL_DATE_TIME_SUB_TZ, END_CALL_DATE_TIME_SUB_TZ, RECORD_SOURCE, SESSION_ID, MOG_ID, TARIFF_PLAN_ID, ORIG_TARIFF_PLAN_ID, USAGE_OFFER_ID, ACCOUNT_ID, GROUP_ACCOUNT_INFO, TARGET_SUBSCR_NO, TARGET_SUBSCR_NO_RESETS, GROUP_ACCOUNT_TYPE, FUND_USAGE_TYPE, ACTUAL_SERVICE_PARAMETER1, ACTUAL_SERVICE_PARAMETER2, ACTUAL_SERVICE_PARAMETER3, ACTUAL_SERVICE_PARAMETER4, CELL_ID, PCL_FLAG)
 Values
   (0, '||subscr_no||', '||account_no||', NULL, NULL, 
    sysdate+('||iterator||'/24/60), sysdate+('||(iterator+1)||'/24/60), ''unitBasedCharge'', 1000, NULL, 
    NULL, 414, 94, 891, 1801, 
    225, 21, ''1'', ''GPRS'', ''INT GPRS charging'', 
    10, 200, ''79031441273'', 1, ''CCBOtest'', 
    ''''''Internet'''''', ''''''VOLUME_K'||iterator||''''''', NULL, NULL, 86, 
    -1, -1, -1, -1, NULL, 
    ''GPRS_BEELINE_SIBERIA'', 2, ''IP71111111111'', 2, ''39031441273'', 
    NULL, NULL, ''2713'', sysdate+('||iterator||'/24/60), ''RUR'', 
    0, 0, ''RUR'', 0, 0, 
    NULL, NULL, NULL, 56860001, 496304706, 
    NULL, 0, NULL, NULL, NULL, 
    ''[5~0.000000~0.000000][14~0.000000~0.000000][21~0.000000~0.000000][22~0.000000~0.000000][25~0.000000~0.000000][27~0.000000~0.000000][28~0.000000~0.000000][29~0.000000~0.000000][30~0.000000~0.000000][33~0.000000~0.000000][34~0.000000~0.000000][77~0.000000~0.000000][78~0.000000~0.000000][96~0.000000~0.000000][135~0.000000~0.000000][136~0.000000~0.000000][137~0.000000~0.000000][145~0.000000~0.000000][146~0.000000~0.000000][233~0.000000~0.000000][318~0.000000~0.000000][330~0.000000~0.000000][331~0.000000~0.000000][370~0.000000~0.000000][457~0.000000~0.000000][506~0.000000~0.000000][591~0.000000~0.000000]'',
	''[1~'||core_balance||'~0.0000~0][2~0.0000~0.0000~0][3~0.0000~0.0000~0][4~0.0000~0.0000~0][5~0.0000~0.0000~0][6~0.0000~0.0000~0][7~0.0000~0.0000~0][8~0.0000~0.0000~0][9~0.0000~0.0000~0][10~0.0000~0.0000~0][11~0.0000~0.0000~0][12~0.0000~0.0000~0][13~0.0000~0.0000~0][14~0.0000~0.0000~0][15~0.0000~0.0000~0][16~0.0000~0.0000~0][17~0.0000~0.0000~0][18~0.0000~0.0000~0][19~0.0000~0.0000~0][20~0.0000~0.0000~0]'', NULL, NULL, NULL, 
    1, 0, sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), 1, 
    '||iterator||', 1, 5582, NULL, 2110, 
    1, NULL, NULL, NULL, 6, 
    1, ''1'', ''MIX'', NULL, ''900'', 
    NULL, 0)';
iterator:=iterator+1;
exit when iterator>exitStmt;
execute immediate executeOsaHistoryStmt;
end loop;

commit;
end;