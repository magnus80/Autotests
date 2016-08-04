declare
ctn varchar2(100); 
subscr_no varchar2(100);
account_no varchar2(100);

deleteMtrStmt varchar2(5000);
deleteCallHistoryStmt varchar2(5000);
deleteOsaHistoryStmt varchar2(5000);
deletePsTransactionStmt varchar2(5000);
deleteRechargeHistoryStmt varchar2(5000);
--deleteSUBS_OFFERS_MAINStmt varchar2(5000);

begin
ctn:='79030372222';
select subscr_no  into subscr_no from account_subscriber where range_map_external_id=ctn;
select account_no into account_no from account_subscriber where range_map_external_id=ctn;

deleteMtrStmt:='DELETE FROM MTR_HIST where subscr_no='''||subscr_no||''' and (mod_date between trunc(sysdate)-1 and sysdate)';
deleteCallHistoryStmt:='DELETE FROM CALL_HISTORY_HIST where subscr_no='''||subscr_no||''' and (start_call_date_time between trunc(sysdate)-1 and sysdate)';
deleteOsaHistoryStmt:='DELETE FROM OSA_HISTORY_HIST where subscr_no='''||subscr_no||''' and (start_call_date_time between trunc(sysdate)-1 and sysdate)';
deletePsTransactionStmt:='DELETE FROM PS_TRANSACTION_HIST where subscr_no='''||subscr_no||''' and (date_time between trunc(sysdate)-1 and sysdate)';
deleteRechargeHistoryStmt:='DELETE FROM RECHARGE_HISTORY_HIST where subscr_no='''||subscr_no||''' and (recharge_date_time between trunc(sysdate)-1 and sysdate)';
--deleteSUBS_OFFERS_MAINStmt:='DELETE FROM SUBS_OFFERS_HIST where subscr_no='''||subscr_no||''' ';

execute immediate deleteMtrStmt;
execute immediate deleteCallHistoryStmt;
execute immediate deleteOsaHistoryStmt;
execute immediate deletePsTransactionStmt;
execute immediate deleteRechargeHistoryStmt;
--execute immediate deleteSUBS_OFFERS_MAINStmt;
  
commit;
end;
