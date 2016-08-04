declare
ctn varchar2(100); 
subscr_no varchar2(100);
account_no varchar2(100);
executeNRCStmt varchar2(5000);
executeNRcBalanceStmt varchar2(5000);
nrc_id number;
nrc_id2 number;
iterator number;
exitStmt number;

begin
ctn:='79030371112';
exitStmt:=6;
select subscr_no into subscr_no from account_subscriber where range_map_external_id=ctn;
select account_no into account_no from account_subscriber where range_map_external_id=ctn;

select max(RC_TERM_INST_ID) into nrc_id  from rc_balance;
select max(RC_TERM_INST_ID) into nrc_id2  from rc;
nrc_id:=NVL(nrc_id,1);
nrc_id2:=NVL(nrc_id2,1);
if(nrc_id>nrc_id2) then nrc_id:=nrc_id+1;
else nrc_id:=nrc_id2+1; 
end if;
iterator:=0;

loop
executeNRCStmt:='Insert into NRC (NRC_TERM_INST_ID, INSTALLMENT_NUMBER, SPLIT_ROW_NUM, SPLIT_OVER_ACCTS, BILLING_ACCOUNT_NO, PARENT_ACCOUNT_NO, PARENT_SUBSCR_NO, PARENT_SUBSCR_NO_RESETS, TRANSACT_DATE, APPLY_DATE, CREATE_DATE, EXPECTED_CUTOFF_DT, AMOUNT, AMOUNT_POSTPAID, AMOUNT_PREPAID, BASE_AMT, CURRENCY_CODE, HAS_OVERRIDES, NRC_TERM_ID, BALANCE_COUNT, TAX_PKG_COUNT, TOTAL_TAX, TOTAL_TAX_POSTPAID, TOTAL_TAX_PREPAID, TOTAL_FEDERAL_TAX, TOTAL_STATE_TAX, TOTAL_COUNTY_TAX, TOTAL_CITY_TAX, TOTAL_OTHER_TAX, ALL_TAX_CALC, DATE_NRC_JOURNALABLE, RATE_DT, IS_BILLABLE, MOG_ID, BALANCE_INFO, NRC_TERM_NAME,TARGET_SUBSCR_NO)
Values ('||nrc_id||', 0, 0, 0, '||account_no||', '||account_no||', '||subscr_no||', 0, sysdate, sysdate, sysdate, sysdate, 0, 0, 0, 0, 3, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, sysdate, sysdate, 0, 4, ''[1~285.0000~5.0000~0][2~0~0~0][3~3.0000~0~0][4~1.0000~0~0][5~300.0000~0~0][6~0~0~0][7~0~0~0][8~0~0~0][9~10.0000~0~0][10~0~0~0][11~0~0~0][12~0~0~0][13~0~0~0][14~0~0~0][15~0~0~0][17~0~0~0][16~0~0~0][19~0~0~0][18~0~0~0][20~10.0000~0~0]'', ''PC_TEST_CCBO'','||subscr_no||')';
executeNRcBalanceStmt:='Insert into NRC_BALANCE (NRC_TERM_INST_ID, INSTALLMENT_NUMBER, SPLIT_ROW_NUM, BALANCE_ID, BALANCE_AMOUNT, BALANCE_COUNTER, TARGET_ACCOUNT_NO, TARGET_BALANCE_ID, PAYMENT_MODE, TARGET_BALANCE_MODE, EXPECTED_CUTOFF_DT, IS_BILLABLE)
Values ('||nrc_id||', 0, 0, 1,50, 1,  '||account_no||', 1, 1, 1,sysdate, 0)';
iterator:=iterator+1;
nrc_id:=nrc_id+1;
exit when iterator>exitStmt;
execute immediate executeNRCStmt;
execute immediate executeNRcBalanceStmt;
end loop;
commit;
end;


