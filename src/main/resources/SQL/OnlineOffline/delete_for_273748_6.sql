declare
ctn varchar2(100); 
tablePrefixDwh varchar2(10);
deleteUsersessions varchar2(5000);
deleteRoamingCalls varchar2(5000);
deleteMtr varchar2(5000);
deleteRc varchar2(5000);
deleteNrc varchar2(5000);
deletePsTransaction varchar2(5000);
deleteCallHistory varchar2(5000);
deleteOsaHistory varchar2(5000);
deleteRechargeHistory varchar2(5000);

begin
ctn:='9030371112';
tablePrefixDwh:='URL';
deleteUsersessions:='DELETE from USERSESSIONS where CHRMSISDN='||ctn;
--deleteRoamingCalls:='DELETE from roaming_calls where SUBSCRIBER_ID in('||ctn||',7'||ctn||')';
deleteCallHistory:='delete from call_history_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and call_date_time between sysdate-30 and sysdate';
deleteMtr:='delete from mtr_'||tablePrefixDwh||' where pps_account in('||ctn||',7'||ctn||') and mtr_date_time between sysdate-30 and sysdate';
deleteOsaHistory:='delete from osa_history_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and start_call_date_time between sysdate-30 and sysdate';
deletePsTransaction:='delete from ps_transaction_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and transaction_date_time between sysdate-30 and sysdate';
deleteRechargeHistory:='delete from recharge_history_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and recharge_date_time between sysdate-30 and sysdate';
deleteRc:='delete from rc_'||tablePrefixDwh||' where pps_account in('||ctn||',7'||ctn||') and rc_date_time between sysdate-30 and sysdate';
deleteNrc:='delete nrc_'||tablePrefixDwh||' where pps_account in('||ctn||',7'||ctn||') and nrc_date_time between sysdate-30 and sysdate';
execute immediate deleteUsersessions;
--execute immediate deleteRoamingCalls;
execute immediate deleteCallHistory;
execute immediate deleteMtr;
execute immediate deleteOsaHistory;
execute immediate deletePsTransaction;
execute immediate deleteRechargeHistory;
execute immediate deleteRc;
execute immediate deleteNrc;
commit;
end;




