-- delete postpaid, open cycle (Ensemble)
declare
ctn varchar2(100);							-- номер абонента
banId varchar2(100);						-- BAN абонента (номер договора)
billingCycleId varchar2(2);					-- номер биллинг-цикла
dateStartBillingCycle varchar2(20);			-- дата начала биллинг-цикла
dateEndBillingCycle varchar2(20);			-- дата конца биллинг-цикла
physicalNameDB varchar2(10);				-- физическое имя БД
deleteUsages varchar2(5000);				-- workTable

begin
ctn:='9060000000';

-- определяем биллинг-цикл:
select ba.bill_cycle into billingCycleId
FROM SUBSCRIBER su, BILLING_ACCOUNT ba
WHERE ba.ban = su.customer_id
AND su.sub_status IN ('A', 'S')
AND SU.SUBSCRIBER_NO = RPAD (ctn, 11);

-- определяем BAN абонента:
select customer_id into banId
FROM SUBSCRIBER
WHERE SUBSCRIBER_NO = RPAD (ctn, 11);

-- Определяем даты начала и конца биллинг-цикла:
select cycle_start_date into dateStartBillingCycle
from CYCLE_CONTROL 
where cycle_code=billingCycleId
and usage_write_lock_ind='N'
and cycle_run_month = EXTRACT(MONTH FROM SYSDATE)
and cycle_run_year = EXTRACT(YEAR FROM SYSDATE);

select cycle_close_date into dateEndBillingCycle
from CYCLE_CONTROL 
where cycle_code=billingCycleId
and usage_write_lock_ind='N'
and cycle_run_month = EXTRACT(MONTH FROM SYSDATE)
and cycle_run_year = EXTRACT(YEAR FROM SYSDATE);

-- определяем физическое имя базы:
select cc.US_PHYSICAL_NAME into physicalNameDB
FROM CYCLE_CONTROL cc
WHERE cc.CYCLE_CODE = billingCycleId
AND cc.CYCLE_START_DATE <= dateStartBillingCycle
AND cc.CYCLE_CLOSE_DATE >= dateEndBillingCycle;

deleteUsages:='DELETE FROM VMPAPP114.'||physicalNameDB||' where SUBSCRIBER_NO='''||ctn||'''';
execute immediate deleteUsages;

commit;
end;