

declare
ctn varchar2(100); 
subscr_no varchar2(100);
account_no varchar2(100);
tablePrefix varchar2(100);
--??????? ? ????????????  ???????? Comverse
deleteMtrStmt varchar2(5000);
deleteCallHistoryStmt varchar2(5000);
deleteOsaHistoryStmt varchar2(5000);
deletePsTransactionStmt varchar2(5000);
deleteRechargeHistoryStmt varchar2(5000);
deleteSUBS_OFFERS_MAINStmt varchar2(5000);
deleteRCStmt varchar2(5000);
deleteRcBalanceStmt varchar2(5000);
deleteNRCStmt varchar2(5000);
deleteNRcBalanceStmt varchar2(5000);
--???????? ??????, ????? ???? ??????
MtrTablePrefix_AB varchar2(100); 
CallHistorytablePrefix_AB varchar2(100);
OsaHistorytablePrefix_AB varchar2(100);
PsTransactiontablePrefix_AB varchar2(100);
RechargeHistorytablePrefix_AB varchar2(100);
SubscOffersTablePrefix_AB varchar2(100);

begin
ctn:='79030371112';
select subscr_no  into subscr_no from account_subscriber where range_map_external_id=ctn;
select account_no into account_no from account_subscriber where range_map_external_id=ctn;
--?????????? ??????? ?????? Main_1a ??? MAIN_1b
/*
select table_AB into MtrTablePrefix_AB from INSERT_CONTROL  c where table_name='MTR' and active_set='Y';
select table_AB into CallHistoryTablePrefix_AB from INSERT_CONTROL  c where table_name='CALL_HISTORY' and active_set='Y';
select table_AB into OsaHistoryTablePrefix_AB from INSERT_CONTROL  c where table_name='OSA_HISTORY' and active_set='Y';
select table_AB into PsTransactionTablePrefix_AB from INSERT_CONTROL  c where table_name='PS_TRANSACTION' and active_set='Y';
select table_AB into RechargeHistoryTablePrefix_AB from INSERT_CONTROL  c where table_name='RECHARGE_HISTORY' and active_set='Y';
select table_AB into SubscOffersTablePrefix_AB from INSERT_CONTROL  c where table_name='SUBS_OFFERS' and active_set='Y';
*/
for  c in (select c.table_name,c.table_ab  from INSERT_CONTROL c where table_name in('MTR','SUBS_OFFERS','CALL_HISTORY','OSA_HISTORY','PS_TRANSACTION','RECHARGE_HISTORY') and  c.active_set='Y')
loop
case(c.table_name)
when 'MTR' then MtrTablePrefix_AB:=c.table_AB;
when 'CALL_HISTORY' then CallHistoryTablePrefix_AB:=c.table_AB;
when 'OSA_HISTORY' then OsaHistoryTablePrefix_AB:=c.table_AB;
when 'PS_TRANSACTION' then PsTransactionTablePrefix_AB:=c.table_AB;
when 'RECHARGE_HISTORY' then RechargeHistoryTablePrefix_AB:=c.table_AB;
when 'SUBS_OFFERS' then SubscOffersTablePrefix_AB:=c.table_AB;
end case;
end loop;



deleteMtrStmt:='DELETE FROM MTR_MAIN_'||MtrTablePrefix_AB||' where subscr_no='''||subscr_no||'''';
--deleteCallHistoryStmt:='DELETE FROM CALL_HISTORY_MAIN_'||CallHistoryTablePrefix_AB||' where subscr_no='''||subscr_no||'''';
deleteOsaHistoryStmt:='DELETE FROM OSA_HISTORY_MAIN_'||OsaHistoryTablePrefix_AB||' where subscr_no='''||subscr_no||'''';
deletePsTransactionStmt:='DELETE FROM PS_TRANSACTION_MAIN_'||PsTransactionTablePrefix_AB||' where subscr_no='''||subscr_no||'''';
deleteRechargeHistoryStmt:='DELETE FROM RECHARGE_HISTORY_MAIN_'||RechargeHistoryTablePrefix_AB||' where subscr_no='''||subscr_no||'''';
deleteSUBS_OFFERS_MAINStmt:='DELETE FROM SUBS_OFFERS_MAIN_'||SubscOffersTablePrefix_AB||' where subscr_no='''||subscr_no||'''';
deleteRCStmt:='DELETE FROM RC where PARENT_SUBSCR_NO='''||subscr_no||'''';
deleteRcBalanceStmt:='DELETE FROM RC_BALANCE where TARGET_ACCOUNT_NO='''||account_no||'''';
deleteNRCStmt:='DELETE FROM NRC where PARENT_SUBSCR_NO='''||subscr_no||'''';
deleteNRcBalanceStmt:='DELETE FROM NRC_BALANCE where TARGET_ACCOUNT_NO='''||account_no||'''';
execute immediate deleteMtrStmt;
--execute immediate deleteCallHistoryStmt;
execute immediate deleteOsaHistoryStmt;
execute immediate deletePsTransactionStmt;
execute immediate deleteRechargeHistoryStmt;
execute immediate deleteSUBS_OFFERS_MAINStmt;
execute immediate deleteRCStmt;
execute immediate deleteRcBalanceStmt;
execute immediate deleteNRcBalanceStmt;
execute immediate deleteNRCStmt;


commit;
end;
