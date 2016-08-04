declare
ctn varchar2(100); 
subscr_no varchar2(100);
account_no varchar2(100);
executePsTransactionStmt varchar2(5000);
PsTransactionTablePrefix_AB varchar2(100);
iterator number;
exitStmt number;

begin
ctn:='79030371112';
exitStmt:=6;
select subscr_no into subscr_no from account_subscriber where range_map_external_id=ctn;
select account_no into account_no from account_subscriber where range_map_external_id=ctn;
select c.table_ab into  PsTransactionTablePrefix_AB from INSERT_CONTROL c where table_name='PS_TRANSACTION' and  c.active_set='Y';
iterator:=0;
loop
--PS_TRANSACTION
executePsTransactionStmt:='Insert into PS_TRANSACTION_MAIN_'||PsTransactionTablePrefix_AB||' (SUBSCR_NO, SUBSCR_NO_RESETS, ACCOUNT_NO, TRANS_ID_1, TRANS_ID_2, DATE_TIME, USAGE_AMOUNT, REFUND_FLAG, CONTENT_TYPE, INITIAL_AUT_ID, FINAL_AUT_ID, SUB_ID2, MESSAGE_TYPE, SUBSCRIBER_TYPE, PARENT_ACCOUNT_NO, TARGET_ACCOUNT_NO, UNIT_TYPE_ID, SUBTYPE_ID, APPLICATION_ID, SPLIT_ROW_NUM, MSG_ID2, MSG_ID, SLU_ID, RESELLER_ID, EXTERNAL_ID_TYPE, EXTERNAL_ID, MSC_ID, REQUESTED_ISO_CODE, SUBSCRIBER_CURRENCY, ORP_DATE, SERVICE_CODE, CURR_CONV_RATE, CONV_RATE_BILLED_ACCOUNT, BILLED_ACCOUNT_CURRENCY, BILLED_ACCOUNT_TML_CHANGE, BILLED_ACCOUNT_TML_VALUE, LIABILITY_REDIRECT_INDICATOR, ACCU_INFO, BAL_INFO, TIMEZONE, ROUNDED_DURATION, RECORD_SOURCE, MOG_ID, TARIFF_PLAN_ID, USAGE_OFFER_ID, GROUP_ACCOUNT_TYPE, FUND_USAGE_TYPE)
Values ('||subscr_no||', 0, '||account_no||', 4106502161, 2119905857, sysdate+('||(iterator+1)||'/24/60), 1, ''N'', 2, 3, 793, ''9030371111'', 4, ''1'', 0, 0, 4, 928, 2, 0, 49610001, 317409045, ''17'', 0, 1, ''79645344024'', ''5294100077980'', ''RUR'', ''RUR'', sysdate+('||(iterator+1)||'/24/60), 0, 1, 1, ''RUR'', 0, 0, 0, ''[14~0.000000~0.000000][22~0.000000~0.000000][29~152.000000~0.000000][30~0.000000~0.000000][33~0.000000~0.000000][46~0.000000~0.000000][47~0.000000~0.000000][48~19.000000~19.000000][77~0.000000~0.000000][78~0.000000~0.000000][126~0.000000~0.000000][146~0.000000~0.000000][158~0.000000~0.000000][159~0.000000~0.000000][222~0.000000~0.000000][223~0.000000~0.000000][136~0.000000~0.000000][284~0.000000~0.000000][27~407.500000~0.000000][28~310.950000~0.000000][157~0.000000~0.000000][21~3.000000~0.000000][145~0.000000~0.000000]'', ''[1~573.9000~-19.0000~0]'', 1, 0, 1, 1, 5250, 638, 6, 1)';
iterator:=iterator+1;
exit when iterator>exitStmt;
execute immediate executePsTransactionStmt;

end loop;
commit;
end;


