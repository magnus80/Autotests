declare
ctn varchar2(100); 
subscr_no varchar2(100);
account_no varchar2(100);
executeRCStmt varchar2(5000);
executeRcBalanceStmt varchar2(5000);
rc_id number;
rc_id2 number;
iterator number;
exitStmt number;

begin
ctn:='79030371112';
exitStmt:=6;
select subscr_no into subscr_no from account_subscriber where range_map_external_id=ctn;
select account_no into account_no from account_subscriber where range_map_external_id=ctn;

select max(RC_TERM_INST_ID) into rc_id  from rc_balance;
select max(RC_TERM_INST_ID) into rc_id2  from rc;
rc_id:=NVL(rc_id,1);
rc_id2:=NVL(rc_id2,1);
if(rc_id>rc_id2) then rc_id:=rc_id+1;
else rc_id:=rc_id2+1; 
end if;
iterator:=0;

loop
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


