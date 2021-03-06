declare
ctn varchar2(100);
tablePrefixDwh varchar2(10);
deleteCallHistory varchar2(5000);
deleteMtr varchar2(5000);
deleteOsaHistory varchar2(5000);
deletePsTransaction varchar2(5000);
deleteRechargeHistory varchar2(5000);
deleteRoamingCalls varchar2(5000);
deleteUsersessions varchar2(5000);
deleteAccumulator varchar2(5000);
deleteScratchCardNew varchar2(5000);
deleteSubsAlcsHist varchar2(5000);
deleteRc varchar2(5000);
deleteNrc varchar2(5000);
deleteBalanceGrants varchar2(5000);
begin
ctn:='9030372222';
tablePrefixDwh:='URL';
deleteCallHistory:='delete from call_history_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and (call_date_time between trunc(sysdate)-30 and sysdate)';
deleteMtr:='delete from mtr_'||tablePrefixDwh||' where pps_account in('||ctn||',7'||ctn||') and (mtr_date_time between trunc(sysdate)-30 and sysdate)';
deleteOsaHistory:='delete from osa_history_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and (start_call_date_time between trunc(sysdate)-30 and sysdate)';
deletePsTransaction:='delete from ps_transaction_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and (transaction_date_time between trunc(sysdate)-30 and sysdate)';
deleteRechargeHistory:='delete from recharge_history_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and (recharge_date_time between trunc(sysdate)-30 and sysdate)';
deleteRoamingCalls:='delete from ROAMING_CALLS where subscriber_id in('||ctn||',7'||ctn||') and (call_date_time between trunc(sysdate)-30 and sysdate)';
deleteUsersessions:='delete from USERSESSIONS where CHRMSISDN in('||ctn||',7'||ctn||') and (dtmstartdate between trunc(sysdate)-30 and sysdate)';
deleteAccumulator:='delete from ACCUMULATOR where CHRMSISDN in('||ctn||',7'||ctn||') and (dtmsyscreationdate between trunc(sysdate)-30 and sysdate)';
deleteScratchCardNew:='delete from SCRATCH_CARD_NEW where phone_number in('||ctn||',7'||ctn||') and (operation_date between trunc(sysdate)-30 and sysdate)';
deleteSubsAlcsHist:='delete from SUBS_ALCS_HIST where subscriber_id in('||ctn||',7'||ctn||') and (alcs_action_date_time between trunc(sysdate)-30 and sysdate)';
deleteRc:='delete from rc_'||tablePrefixDwh||' where pps_account in('||ctn||',7'||ctn||') and (rc_date_time between trunc(sysdate)-30 and sysdate)';
deleteNrc:='delete from nrc_'||tablePrefixDwh||' where pps_account in('||ctn||',7'||ctn||') and (nrc_date_time between trunc(sysdate)-30 and sysdate)';
deleteBalanceGrants:='delete from balance_grants_'||tablePrefixDwh||' where external_id in('||ctn||',7'||ctn||') and (grant_date between trunc(sysdate)-30 and sysdate)';
execute immediate deleteCallHistory;
execute immediate deleteMtr;
execute immediate deleteOsaHistory;
execute immediate deletePsTransaction;
execute immediate deleteRechargeHistory;
execute immediate deleteRoamingCalls;
execute immediate deleteUsersessions;
execute immediate deleteAccumulator;
execute immediate deleteScratchCardNew;
execute immediate deleteSubsAlcsHist;
execute immediate deleteRc;
execute immediate deleteNrc;
execute immediate deleteBalanceGrants;
commit;
end;
