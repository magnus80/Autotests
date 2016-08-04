-- inserts for filters, postpaid, open cycle (Ensemble)
declare
ctn varchar2(100);							-- номер абонента
banId varchar2(100);						-- BAN абонента (номер договора)
billingCycleId varchar2(2);					-- номер биллинг-цикла
iterator number;							-- счетчик количества транзакций
amountTransactions number;					-- количество транзакций
dateStartBillingCycle varchar2(20);			-- дата начала биллинг-цикла
dateEndBillingCycle varchar2(20);			-- дата конца биллинг-цикла
physicalNameDB varchar2(10);				-- физическое имя БД
executeUsages varchar2(5000);				-- workTable
randomCtn int;								-- случайный номер абонента
randomDur int;								-- случайная продолжительность

begin
ctn:='9060000000';
amountTransactions:=13; 					-- 13 транзакций за один цикл
iterator:=0;

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


loop
randomCtn:=dbms_random.VALUE(9030000000,9039999999);
randomDur:=dbms_random.VALUE(6,120);

-- Сессии и списания GPRS - Сессии и списания GPRS
executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, APPLICATION_ID, DL_SERVICE_CODE, AT_SOC, AT_SOC_DATE, SOC_EXPIRATION_DATE, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL, RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, CALL_ACTION_CODE, AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, AT_CALL_START_PERIOD, CALLING_NO, MPS_FILE_NUMBER, MESSAGE_TYPE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR, CYCLE_RUN_MONTH, SERVICE_FEATURE_CODE, DURATION, DATA_VOLUME, COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND, SERVICE_TYPE, IMSI, EVENT_TYPE, DEFAULT_BEN, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, CALL_SOURCE, RECORD_ID, TAX_IND, LOGICAL_DATE, IU_LEVEL_CODE, PREFIX_SHORT_CODE, UOM, CALCULATE_UC_RATE_IND, TECHNOLOGY, ADVANCE_PAYM_IND, SUB_STATUS, CUR_IND, ALREADY_PAYD_IND, SERVICE_ID, DIRECTION, SPECIAL_FEATURE, SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID)
 Values
   ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), ''14500'', 1, sysdate+('||iterator||'/24/60), ''BLPRRR'', ''US032'', ''RVIPDEF  '', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''GPRS  '', sysdate+('||iterator||'/24/60), ''M'', ''C'', ''RAG      '', sysdate+('||iterator||'/24/60), ''1'', ''0'', sysdate+('||iterator||'/24/60), '||randomDur||', '||(randomDur-5)||', 3.5, ''01'', '||randomCtn||', 504927, ''1'', ''N'', ''N'', 1, 2014, 8, ''GPRS  '', ''00000000'', 1024, ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''F'', ''R'', ''250990000005661'', 7, 1, ''59'', ''I'', ''N'', ''25002   '', ''N'', ''21'', ''S'', ''T'', ''00000'', ''Y'', sysdate+('||iterator||'/24/60), ''C'', ''NC     '', ''SE'', ''Y'', ''G'', ''N'', ''A'', ''P'', ''N'', ''ZZ'', ''ZZZ'', ''Z'', ''ZZZ'', ''Y'', 52952)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;
executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, APPLICATION_ID, DL_SERVICE_CODE, AT_SOC, AT_SOC_DATE, SOC_EXPIRATION_DATE, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL, RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, CALL_ACTION_CODE, AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, AT_CALL_START_PERIOD, CALLING_NO, MPS_FILE_NUMBER, MESSAGE_TYPE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR, CYCLE_RUN_MONTH, SERVICE_FEATURE_CODE, DURATION, DATA_VOLUME, COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND, SERVICE_TYPE, IMSI, EVENT_TYPE, DEFAULT_BEN, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, CALL_SOURCE, RECORD_ID, TAX_IND, LOGICAL_DATE, IU_LEVEL_CODE, PREFIX_SHORT_CODE, UOM, CALCULATE_UC_RATE_IND, TECHNOLOGY, ADVANCE_PAYM_IND, SUB_STATUS, CUR_IND, ALREADY_PAYD_IND, SERVICE_ID, DIRECTION, SPECIAL_FEATURE, SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID)
 Values
   ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), ''14500'', 1, sysdate+('||iterator||'/24/60), ''BLPRRR'', ''US032'', ''RVIPDEF  '', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''UWLID '', sysdate+('||iterator||'/24/60), ''M'', ''C'', ''RAG      '', sysdate+('||iterator||'/24/60), ''1'', ''0'', sysdate+('||iterator||'/24/60), '||randomDur||', '||(randomDur-5)||', 10.5, ''01'', '||randomCtn||', 504927, ''1'', ''N'', ''N'', 1, 2014, 8, ''UWLID '', ''00000000'', 1024, ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''F'', ''R'', ''250990000005661'', 7, 1, ''59'', ''I'', ''N'', ''25002   '', ''N'', ''21'', ''S'', ''T'', ''00000'', ''Y'', sysdate+('||iterator||'/24/60), ''C'', ''NC     '', ''SE'', ''Y'', ''G'', ''N'', ''A'', ''P'', ''N'', ''ZZ'', ''ZZZ'', ''Z'', ''ZZZ'', ''Y'', 52952)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;
executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, APPLICATION_ID, DL_SERVICE_CODE, AT_SOC, AT_SOC_DATE, SOC_EXPIRATION_DATE, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL, RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, CALL_ACTION_CODE, AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, AT_CALL_START_PERIOD, CALLING_NO, MPS_FILE_NUMBER, MESSAGE_TYPE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR, CYCLE_RUN_MONTH, SERVICE_FEATURE_CODE, DURATION, DATA_VOLUME, COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND, SERVICE_TYPE, IMSI, EVENT_TYPE, DEFAULT_BEN, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, CALL_SOURCE, RECORD_ID, TAX_IND, LOGICAL_DATE, IU_LEVEL_CODE, PREFIX_SHORT_CODE, UOM, CALCULATE_UC_RATE_IND, TECHNOLOGY, ADVANCE_PAYM_IND, SUB_STATUS, CUR_IND, ALREADY_PAYD_IND, SERVICE_ID, DIRECTION, SPECIAL_FEATURE, SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID)
 Values
   ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), ''14500'', 1, sysdate+('||iterator||'/24/60), ''BLPRRR'', ''US032'', ''RVIPDEF  '', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''09GPP0'', sysdate+('||iterator||'/24/60), ''M'', ''C'', ''RAG      '', sysdate+('||iterator||'/24/60), ''1'', ''0'', sysdate+('||iterator||'/24/60), '||randomDur||', '||(randomDur-5)||', 123.4567, ''01'', '||randomCtn||', 504927, ''1'', ''N'', ''N'', 1, 2014, 8, ''09GPP0'', ''00000000'', 1024, ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''F'', ''R'', ''250990000005661'', 7, 1, ''59'', ''I'', ''N'', ''25002   '', ''N'', ''21'', ''S'', ''T'', ''00000'', ''Y'', sysdate+('||iterator||'/24/60), ''C'', ''NC     '', ''SE'', ''Y'', ''G'', ''N'', ''A'', ''P'', ''N'', ''ZZ'', ''ZZZ'', ''Z'', ''ZZZ'', ''Y'', 52952)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;
-- Сессии и списания GPRS - Сессии и списания GPRS-Internet
executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, APPLICATION_ID, DL_SERVICE_CODE, AT_SOC, AT_SOC_DATE, SOC_EXPIRATION_DATE, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL, RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, CALL_ACTION_CODE, AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, AT_CALL_START_PERIOD, CALLING_NO, MPS_FILE_NUMBER, MESSAGE_TYPE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR, CYCLE_RUN_MONTH, SERVICE_FEATURE_CODE, DURATION, DATA_VOLUME, COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND, SERVICE_TYPE, IMSI, EVENT_TYPE, DEFAULT_BEN, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, CALL_SOURCE, RECORD_ID, TAX_IND, LOGICAL_DATE, IU_LEVEL_CODE, PREFIX_SHORT_CODE, UOM, CALCULATE_UC_RATE_IND, TECHNOLOGY, ADVANCE_PAYM_IND, SUB_STATUS, CUR_IND, ALREADY_PAYD_IND, SERVICE_ID, DIRECTION, SPECIAL_FEATURE, SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID)
 Values
   ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), ''14500'', 1, sysdate+('||iterator||'/24/60), ''BLPRRR'', ''US032'', ''RTIER    '', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''GPRSI '', sysdate+('||iterator||'/24/60), ''M'', ''C'', ''RAG      '', sysdate+('||iterator||'/24/60), ''1'', ''0'', sysdate+('||iterator||'/24/60), '||randomDur||', '||(randomDur-5)||', 3.5, ''01'', '||randomCtn||', 504927, ''1'', ''N'', ''N'', 1, 2014, 8, ''GPRSI '', ''00000000'', 1024, ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''F'', ''R'', ''250990000005661'', 7, 1, ''59'', ''I'', ''N'', ''53001   '', ''N'', ''21'', ''S'', ''T'', ''00000'', ''Y'', sysdate+('||iterator||'/24/60), ''C'', ''NC     '', ''SE'', ''Y'', ''G'', ''N'', ''A'', ''P'', ''N'', ''ZZ'', ''ZZZ'', ''Z'', ''ZZZ'', ''Y'', 52952)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;   
-- Сессии и списания GPRS - Сессии и списания GPRS_WAP
executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
  (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, APPLICATION_ID, DL_SERVICE_CODE, AT_SOC, AT_SOC_DATE, SOC_EXPIRATION_DATE, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL, RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, CALL_ACTION_CODE, AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, AT_CALL_START_PERIOD, CALLING_NO, MPS_FILE_NUMBER, MESSAGE_TYPE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR, CYCLE_RUN_MONTH, SERVICE_FEATURE_CODE, DURATION, DATA_VOLUME, COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND, SERVICE_TYPE, IMSI, EVENT_TYPE, DEFAULT_BEN, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, CALL_SOURCE, RECORD_ID, TAX_IND, LOGICAL_DATE, IU_LEVEL_CODE, PREFIX_SHORT_CODE, UOM, CALCULATE_UC_RATE_IND, TECHNOLOGY, ADVANCE_PAYM_IND, SUB_STATUS, CUR_IND, ALREADY_PAYD_IND, SERVICE_ID, DIRECTION, SPECIAL_FEATURE, SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID)
 Values
   ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), ''14500'', 1, sysdate+('||iterator||'/24/60), ''BLPRRR'', ''US032'', ''RTIER    '', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''GPRSW '', sysdate+('||iterator||'/24/60), ''M'', ''C'', ''RAG      '', sysdate+('||iterator||'/24/60), ''1'', ''0'', sysdate+('||iterator||'/24/60), '||randomDur||', '||(randomDur-5)||', 3.5, ''01'', '||randomCtn||', 504927, ''1'', ''N'', ''N'', 1, 2014, 8, ''GPRSW '', ''00000000'', 1024, ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''F'', ''R'', ''250990000005661'', 7, 1, ''59'', ''I'', ''N'', ''2502035 '', ''N'', ''21'', ''S'', ''T'', ''00000'', ''Y'', sysdate+('||iterator||'/24/60), ''C'', ''NC     '', ''SE'', ''Y'', ''G'', ''N'', ''A'', ''P'', ''N'', ''ZZ'', ''ZZZ'', ''Z'', ''ZZZ'', ''Y'', 52952)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;

-- Тип записи - Роуминг
executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, APPLICATION_ID, DL_SERVICE_CODE, AT_SOC, AT_SOC_DATE, SOC_EXPIRATION_DATE, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL, RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, CALL_ACTION_CODE, AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, AT_CALL_START_PERIOD, CALLING_NO, MPS_FILE_NUMBER, MESSAGE_TYPE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR, CYCLE_RUN_MONTH, SERVICE_FEATURE_CODE, DURATION, DATA_VOLUME, COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND, SERVICE_TYPE, IMSI, EVENT_TYPE, DEFAULT_BEN, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, CALL_SOURCE, RECORD_ID, TAX_IND, LOGICAL_DATE, IU_LEVEL_CODE, PREFIX_SHORT_CODE, UOM, CALCULATE_UC_RATE_IND, TECHNOLOGY, ADVANCE_PAYM_IND, SUB_STATUS, CUR_IND, ALREADY_PAYD_IND, SERVICE_ID, DIRECTION, SPECIAL_FEATURE, SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID)
 Values
   ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), ''14500'', 1, sysdate+('||iterator||'/24/60), ''BLPRRR'', ''US032'', ''RTIER    '', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''UVRVO '', sysdate+('||iterator||'/24/60), ''M'', ''C'', ''RAG      '', sysdate+('||iterator||'/24/60), ''1'', ''0'', sysdate+('||iterator||'/24/60), '||randomDur||', '||(randomDur-5)||', 14.44, ''01'', '||randomCtn||', 504927, ''1'', ''N'', ''N'', 1, 2014, 8, ''UVRVO '', ''00000000'', 1024, ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''F'', ''R'', ''250990000005661'', 7, 1, ''59'', ''I'', ''N'', ''62501   '', ''N'', ''21'', ''S'', ''T'', ''00000'', ''Y'', sysdate+('||iterator||'/24/60), ''C'', ''NC     '', ''SE'', ''Y'', ''G'', ''N'', ''A'', ''P'', ''N'', ''ZZ'', ''ZZZ'', ''Z'', ''ZZZ'', ''Y'', 52952)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;
executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, APPLICATION_ID, DL_SERVICE_CODE, AT_SOC, AT_SOC_DATE, SOC_EXPIRATION_DATE, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL, RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, CALL_ACTION_CODE, AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, AT_CALL_START_PERIOD, CALLING_NO, MPS_FILE_NUMBER, MESSAGE_TYPE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR, CYCLE_RUN_MONTH, SERVICE_FEATURE_CODE, DURATION, DATA_VOLUME, COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND, SERVICE_TYPE, IMSI, EVENT_TYPE, DEFAULT_BEN, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, CALL_SOURCE, RECORD_ID, TAX_IND, LOGICAL_DATE, IU_LEVEL_CODE, PREFIX_SHORT_CODE, UOM, CALCULATE_UC_RATE_IND, TECHNOLOGY, ADVANCE_PAYM_IND, SUB_STATUS, CUR_IND, ALREADY_PAYD_IND, SERVICE_ID, DIRECTION, SPECIAL_FEATURE, SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID)
 Values
   ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), ''14500'', 1, sysdate+('||iterator||'/24/60), ''BLPRRR'', ''US032'', ''RTIER    '', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''ROAMN '', sysdate+('||iterator||'/24/60), ''M'', ''C'', ''RAG      '', sysdate+('||iterator||'/24/60), ''1'', ''0'', sysdate+('||iterator||'/24/60), '||randomDur||', '||(randomDur-5)||', 167.9, ''01'', '||randomCtn||', 504927, ''1'', ''N'', ''N'', 1, 2014, 8, ''ROAMN '', ''00000000'', 1024, ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''F'', ''R'', ''250990000005661'', 7, 1, ''59'', ''I'', ''N'', ''99999   '', ''N'', ''21'', ''S'', ''T'', ''00000'', ''Y'', sysdate+('||iterator||'/24/60), ''C'', ''NC     '', ''SE'', ''Y'', ''G'', ''N'', ''A'', ''P'', ''N'', ''ZZ'', ''ZZZ'', ''Z'', ''ZZZ'', ''Y'', 52952)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;
executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, APPLICATION_ID, DL_SERVICE_CODE, AT_SOC, AT_SOC_DATE, SOC_EXPIRATION_DATE, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL, RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, CALL_ACTION_CODE, AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, AT_CALL_START_PERIOD, CALLING_NO, MPS_FILE_NUMBER, MESSAGE_TYPE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR, CYCLE_RUN_MONTH, SERVICE_FEATURE_CODE, DURATION, DATA_VOLUME, COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND, SERVICE_TYPE, IMSI, EVENT_TYPE, DEFAULT_BEN, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, CALL_SOURCE, RECORD_ID, TAX_IND, LOGICAL_DATE, IU_LEVEL_CODE, PREFIX_SHORT_CODE, UOM, CALCULATE_UC_RATE_IND, TECHNOLOGY, ADVANCE_PAYM_IND, SUB_STATUS, CUR_IND, ALREADY_PAYD_IND, SERVICE_ID, DIRECTION, SPECIAL_FEATURE, SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID)
 Values
   ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), ''14500'', 1, sysdate+('||iterator||'/24/60), ''BLPRRR'', ''US032'', ''RVIPDEF  '', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''U_R_LD'', sysdate+('||iterator||'/24/60), ''M'', ''C'', ''RAG      '', sysdate+('||iterator||'/24/60), ''1'', ''0'', sysdate+('||iterator||'/24/60), '||randomDur||', '||(randomDur-5)||', 1234.01, ''01'', '||randomCtn||', 504927, ''1'', ''N'', ''N'', 1, 2014, 8, ''U_R_LD'', ''00000000'', 1024, ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''F'', ''R'', ''250990000005661'', 7, 1, ''59'', ''I'', ''N'', ''25002   '', ''N'', ''21'', ''S'', ''T'', ''00000'', ''Y'', sysdate+('||iterator||'/24/60), ''C'', ''NC     '', ''EV'', ''Y'', ''G'', ''N'', ''A'', ''P'', ''N'', ''ZZ'', ''ZZZ'', ''Z'', ''ZZZ'', ''Y'', 52952)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;
executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, APPLICATION_ID, DL_SERVICE_CODE, AT_SOC, AT_SOC_DATE, SOC_EXPIRATION_DATE, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL, RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, CALL_ACTION_CODE, AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, AT_CALL_START_PERIOD, CALLING_NO, MPS_FILE_NUMBER, MESSAGE_TYPE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR, CYCLE_RUN_MONTH, SERVICE_FEATURE_CODE, DURATION, DATA_VOLUME, COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND, SERVICE_TYPE, IMSI, EVENT_TYPE, DEFAULT_BEN, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, CALL_SOURCE, RECORD_ID, TAX_IND, LOGICAL_DATE, IU_LEVEL_CODE, PREFIX_SHORT_CODE, UOM, CALCULATE_UC_RATE_IND, TECHNOLOGY, ADVANCE_PAYM_IND, SUB_STATUS, CUR_IND, ALREADY_PAYD_IND, SERVICE_ID, DIRECTION, SPECIAL_FEATURE, SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID)
 Values
   ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), ''14500'', 1, sysdate+('||iterator||'/24/60), ''BLPRRR'', ''US032'', ''RVIPDEF  '', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''U_R_IN'', sysdate+('||iterator||'/24/60), ''M'', ''C'', ''RAG      '', sysdate+('||iterator||'/24/60), ''1'', ''0'', sysdate+('||iterator||'/24/60), '||randomDur||', '||(randomDur-5)||', 10.5, ''01'', '||randomCtn||', 504927, ''1'', ''N'', ''N'', 1, 2014, 8, ''U_R_IN'', ''00000000'', 1024, ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''F'', ''R'', ''250990000005661'', 7, 1, ''59'', ''I'', ''N'', ''27404   '', ''N'', ''21'', ''S'', ''T'', ''00000'', ''Y'', sysdate+('||iterator||'/24/60), ''C'', ''NC     '', ''EV'', ''Y'', ''G'', ''N'', ''A'', ''P'', ''N'', ''ZZ'', ''ZZZ'', ''Z'', ''ZZZ'', ''Y'', 52952)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;
executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, APPLICATION_ID, DL_SERVICE_CODE, AT_SOC, AT_SOC_DATE, SOC_EXPIRATION_DATE, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL, RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, CALL_ACTION_CODE, AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, AT_CALL_START_PERIOD, CALLING_NO, MPS_FILE_NUMBER, MESSAGE_TYPE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR, CYCLE_RUN_MONTH, SERVICE_FEATURE_CODE, DURATION, DATA_VOLUME, COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND, SERVICE_TYPE, IMSI, EVENT_TYPE, DEFAULT_BEN, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, CALL_SOURCE, RECORD_ID, TAX_IND, LOGICAL_DATE, IU_LEVEL_CODE, PREFIX_SHORT_CODE, UOM, CALCULATE_UC_RATE_IND, TECHNOLOGY, ADVANCE_PAYM_IND, SUB_STATUS, CUR_IND, ALREADY_PAYD_IND, SERVICE_ID, DIRECTION, SPECIAL_FEATURE, SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID)
 Values
   ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), ''14500'', 1, sysdate+('||iterator||'/24/60), ''BLPRRR'', ''US032'', ''RVIPDEF  '', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''PCHGO4'', sysdate+('||iterator||'/24/60), ''M'', ''C'', ''RAG      '', sysdate+('||iterator||'/24/60), ''1'', ''0'', sysdate+('||iterator||'/24/60), '||randomDur||', '||(randomDur-5)||', 3.5, ''01'', '||randomCtn||', 504927, ''1'', ''N'', ''N'', 1, 2014, 8, ''PCHGO4'', ''00000000'', 1024, ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''F'', ''R'', ''250990000005661'', 7, 1, ''59'', ''I'', ''N'', ''27404   '', ''N'', ''21'', ''S'', ''T'', ''00000'', ''Y'', sysdate+('||iterator||'/24/60), ''C'', ''NC     '', ''SE'', ''Y'', ''G'', ''N'', ''A'', ''P'', ''N'', ''ZZ'', ''ZZZ'', ''Z'', ''ZZZ'', ''Y'', 52952)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;

-- Тип записи - CPA-подписки
executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, APPLICATION_ID, DL_SERVICE_CODE, AT_SOC, AT_SOC_DATE, SOC_EXPIRATION_DATE, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL, RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, CALL_ACTION_CODE, AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, AT_CALL_START_PERIOD, CALL_TO_TN, CALLING_NO, MPS_FILE_NUMBER, MESSAGE_TYPE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR, CYCLE_RUN_MONTH, SERVICE_FEATURE_CODE, DURATION, DATA_VOLUME, COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND, SERVICE_TYPE, IMSI, EVENT_TYPE, DEFAULT_BEN, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, CALL_SOURCE, RECORD_ID, TAX_IND, LOGICAL_DATE, IU_LEVEL_CODE, PREFIX_SHORT_CODE, UOM, CALCULATE_UC_RATE_IND, TECHNOLOGY, ADVANCE_PAYM_IND, SUB_STATUS, CUR_IND, ALREADY_PAYD_IND, SERVICE_ID, DIRECTION, SPECIAL_FEATURE, SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID)
 Values
   ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), ''78129600203'', 1, sysdate+('||iterator||'/24/60), ''BLPRRR'', ''US032'', ''RVIPDEF  '', sysdate, sysdate, ''PRO001'', sysdate, ''M'', ''C'', ''RAG      '', sysdate, ''1'', ''0'', sysdate, '||randomDur||', '||(randomDur-5)||', 0.5, ''01'', '||(randomCtn-1)||', '||randomCtn||', 504927, ''1'', ''N'', ''N'', 1, 2014, 8, ''PRO001'', ''00000000'', 1024, ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''F'', ''R'', ''250990000005661'', 7, 1, ''59'', ''I'', ''N'', ''25002   '', ''N'', ''21'', ''S'', ''T'', ''00000'', ''Y'', sysdate+('||iterator||'/24/60), ''C'', ''NC     '', ''EV'', ''Y'', ''G'', ''N'', ''A'', ''P'', ''N'', ''ZZ'', ''ZZZ'', ''Z'', ''ZZZ'', ''Y'', 52952)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;
executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, APPLICATION_ID, DL_SERVICE_CODE, AT_SOC, AT_SOC_DATE, SOC_EXPIRATION_DATE, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL, RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, CALL_ACTION_CODE, AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, AT_CALL_START_PERIOD, CALLING_NO, MPS_FILE_NUMBER, MESSAGE_TYPE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR, CYCLE_RUN_MONTH, SERVICE_FEATURE_CODE, DURATION, DATA_VOLUME, COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND, SERVICE_TYPE, IMSI, EVENT_TYPE, DEFAULT_BEN, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, CALL_SOURCE, RECORD_ID, TAX_IND, LOGICAL_DATE, IU_LEVEL_CODE, PREFIX_SHORT_CODE, UOM, CALCULATE_UC_RATE_IND, TECHNOLOGY, ADVANCE_PAYM_IND, SUB_STATUS, CUR_IND, ALREADY_PAYD_IND, SERVICE_ID, DIRECTION, SPECIAL_FEATURE, SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID)
 Values
   ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), ''14500'', 1, sysdate+('||iterator||'/24/60), ''BLPRRR'', ''US032'', ''RVIPDEF  '', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''PRO009'', sysdate+('||iterator||'/24/60), ''M'', ''C'', ''RAG      '', sysdate+('||iterator||'/24/60), ''1'', ''0'', sysdate+('||iterator||'/24/60), '||randomDur||', '||(randomDur-5)||', 0.09, ''01'', '||randomCtn||', 504927, ''1'', ''N'', ''N'', 1, 2014, 8, ''PRO009'', ''00000000'', 1024, ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''F'', ''R'', ''250990000005661'', 7, 1, ''59'', ''I'', ''N'', ''25002   '', ''N'', ''21'', ''S'', ''T'', ''00000'', ''Y'', sysdate+('||iterator||'/24/60), ''C'', ''NC     '', ''EV'', ''Y'', ''G'', ''N'', ''A'', ''D'', ''N'', ''ZZ'', ''ZZZ'', ''Z'', ''ZZZ'', ''Y'', 52952)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;
executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, APPLICATION_ID, DL_SERVICE_CODE, AT_SOC, AT_SOC_DATE, SOC_EXPIRATION_DATE, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL, RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, CALL_ACTION_CODE, AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, AT_CALL_START_PERIOD, CALL_TO_TN, CALLING_NO, MPS_FILE_NUMBER, MESSAGE_TYPE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR, CYCLE_RUN_MONTH, SERVICE_FEATURE_CODE, DURATION, DATA_VOLUME, COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND, SERVICE_TYPE, IMSI, EVENT_TYPE, DEFAULT_BEN, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, CALL_SOURCE, RECORD_ID, TAX_IND, LOGICAL_DATE, IU_LEVEL_CODE, PREFIX_SHORT_CODE, UOM, CALCULATE_UC_RATE_IND, TECHNOLOGY, ADVANCE_PAYM_IND, SUB_STATUS, CUR_IND, ALREADY_PAYD_IND, SERVICE_ID, DIRECTION, SPECIAL_FEATURE, SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID)
 Values
   ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), ''14500'', 1, sysdate+('||iterator||'/24/60), ''BLPRRR'', ''US032'', ''RTIER    '', sysdate, sysdate, ''PRO010'', sysdate, ''M'', ''C'', ''RAG      '', sysdate, ''2'', ''0'', sysdate, '||randomDur||', '||(randomDur-5)||', 0.1, ''01'', '||(randomCtn-1)||', '||randomCtn||', 504927, ''1'', ''N'', ''N'', 1, 2015, 9, ''PRO010'', ''00000000'', 1024, ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''F'', ''R'', ''250990000005661'', 7, 1, ''59'', ''I'', ''N'', ''25099   '', ''N'', ''21'', ''S'', ''T'', ''00000'', ''Y'', sysdate+('||iterator||'/24/60), ''C'', ''NC     '', ''SE'', ''Y'', ''G'', ''N'', ''A'', ''D'', ''N'', ''ZZ'', ''ZZZ'', ''Z'', ''ZZZ'', ''Y'', 52952)';
iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;

-- Роуминг, транзакции и списания (те же, что и "Тип записи - Роуминг")

end loop;

commit;
end;