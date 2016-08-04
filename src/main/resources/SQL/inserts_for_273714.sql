declare
ctn varchar2(100); 
subscr_no varchar2(100);
account_no varchar2(100);
executeMtrStmt varchar2(5000);
executeCallHistoryStmt varchar2(5000);
mtr_id number;
--tablePrefixComverse varchar2(100);
MtrTablePrefix_AB varchar2(100); 
CallHistoryTablePrefix_AB varchar2(100);
iterator number;
exitStmt number;
mtr_id_1a number;
mtr_id_1b number;
begin
ctn:='79030371111'; -- Номер абонента на котором будем создавать транзакции
--tablePrefixComverse:='MAIN_1A';
exitStmt:=50; --Число транзакций 
select subscr_no into subscr_no from account_subscriber where range_map_external_id=ctn;
select account_no into account_no from account_subscriber where range_map_external_id=ctn;

for  c in (select c.table_name,c.table_ab  from INSERT_CONTROL c where table_name in('MTR','CALL_HISTORY') and  c.active_set='Y')
loop
case(c.table_name)
when 'MTR' then MtrTablePrefix_AB:=c.table_AB;
when 'CALL_HISTORY' then CallHistoryTablePrefix_AB:=c.table_AB;
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

iterator:=0;
loop
--MTR
executeMtrStmt:='INSERT INTO MTR_MAIN_'||MtrTablePrefix_AB||'(subscr_no,subscr_no_resets,account_no,owning_account_no,mtr_id2,mtr_id,mtr_type,mtr_sub_type,
mtr_comment,mod_date,login_name,mtr_source,extract_file_id,subscriber_currency,reseller_id,bal_info,accu_info,offer_info,
mog_id,group_account_type,fund_usage_type,pcl_flag,ple_flag) 
VALUES ('||subscr_no||',0,'||account_no||',0,150,'||mtr_id||',14,1,''CCBOtest'',sysdate+('||iterator||'/24/60),
''sapiuser'',3,2,''RUR'',0,
''[1~150.0~0~~0~1][2~0.0~0.0~~0~1][3~50~5~0001-01-01 00:00:00~0~1][4~20.0~0.0~~0~1][5~0.0~0.0~2023-10-22 00:00:00~0~1][6~0.0~0.0~2023-10-22 00:00:00~0~1][7~0.0~0.0~~0~1][8~0.0~0.0~~0~1][9~0.0~0.0~~0~1][10~0.0~0.0~2023-10-22 00:00:00~0~1][11~0.0~0.0~~0~1][12~0.0~0.0~~0~1][13~0.0~0.0~~0~1][14~0.0~0.0~~0~1][15~0.0~0.0~~0~1][17~0.0~0.0~~0~1][16~0.0~0.0~~0~1][19~600.0~0.0~2014-11-05 00:00:00~0~1][18~0.0~0.0~2033-12-16 00:00:00~0~1][20~0.0~0.0~~0~1]'',
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
    NULL, NULL, ''[1~30.5'||iterator||'00~5.5'||iterator||'00~0][2~0.0000~0.0000~0][3~0.0000~0.0000~0][4~0.0000~0.0000~0][5~0.0000~0.0000~0][6~0.0000~0.0000~0][7~0.0000~0.0000~0][8~0.0000~0.0000~0][9~0.0000~0.0000~0][10~0.0000~0.0000~0][11~0.0000~0.0000~0][12~0.0000~0.0000~0][13~0.0000~0.0000~0][14~0.0000~0.0000~0][15~0.0000~0.0000~0][16~0.0000~0.0000~0][17~0.0000~0.0000~0][18~0.0000~0.0000~0][19~0.0000~0.0000~0][20~0.0000~0.0000~0]'',
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
end loop;
commit;
end;




