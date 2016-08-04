declare
ctn varchar2(100); 
subscr_no varchar2(100);
account_no varchar2(100);
executeRechargeHistoryStmt varchar2(5000);
recharge_id number;
recharge_id2 number;
RechargeHistoryTablePrefix_AB varchar2(100);
iterator number;
exitStmt number;

begin
ctn:='79030371112';
exitStmt:=6;
select subscr_no into subscr_no from account_subscriber where range_map_external_id=ctn;
select account_no into account_no from account_subscriber where range_map_external_id=ctn;
select c.table_ab into RechargeHistoryTablePrefix_AB from INSERT_CONTROL c where table_name='RECHARGE_HISTORY' and  c.active_set='Y';

iterator:=0;
execute immediate 'select max(recharge_id) from RECHARGE_HISTORY_MAIN_'||RechargeHistoryTablePrefix_AB||'' into recharge_id;
execute immediate 'select max(recharge_id2) from RECHARGE_HISTORY_MAIN_'||RechargeHistoryTablePrefix_AB||'' into recharge_id2;
recharge_id:=NVL(recharge_id,1); 
recharge_id2:=NVL(recharge_id2,1);
recharge_id:=recharge_id+1;
recharge_id2:=recharge_id2+1;

loop

--RECHARGE_HISTORY
executeRechargeHistoryStmt:='Insert into RECHARGE_HISTORY_MAIN_'||RechargeHistoryTablePrefix_AB||' (SUBSCR_NO, SUBSCR_NO_RESETS, ACCOUNT_NO, RECHARGE_DATE_TIME, FACE_VALUE, CARD_NUMBER, VOUCHER_TYPE, EXPIRATION_OFFSET, RECHARGE_ID2, RECHARGE_ID, RECHG_OR_DIRECT_BAL, RCHG_SRC, UNIT_TYPE_ID, RECHARGE_COMMENT, BATCH_NUMBER, RCT_ID, RECHARGE_USER, SUB_ACCT_TYPE, RESELLER_ID, EXTRACT_FILE_ID, BILLING_SERVER_ID, VOUCHER_CURRENCY, SUBSCRIBER_CURRENCY, CURRENCY_CONV_RATE, CHARGE_CODE, BAL_INFO, ACCU_INFO, EXT_FIELD, MOG_ID)
Values ('||subscr_no||', 0, '||account_no||', sysdate+('||(iterator+1)||'/24/60), 40, ''non voucher'', 0, 0, '||recharge_id2||', '||recharge_id||', 2, 7, 1, ''XPB,Recharge_online'', -1, 253, ''test'', 1, 0, 3, 1, ''RUR'', ''RUR'', 1, ''1'', ''[1~115.15~40~~0~1]'', ''[4~0~0][8~29.85~0][12~0~0][14~29.85~0][16~0~0][17~0~0][27~0~0][57~9.95~0][58~40~-40][72~19.9~0][105~0~0][106~0~0][111~0~0][112~0~0][128~0~0][234~0~0][235~0~0][236~0~0][286~0~0]'', ''79039613810'', 4)';
iterator:=iterator+1;
recharge_id:=recharge_id+1;
recharge_id2:=recharge_id2+1;
exit when iterator>exitStmt;
execute immediate executeRechargeHistoryStmt;

end loop;
commit;
end;


