-- Detalisation postpaid, open cycle (Ensemble)
declare
TYPE feature_code IS TABLE OF VARCHAR2(30);	-- Расшифровки поля Сервис
feature_desc feature_code;					-- Расшифровки поля Сервис
TYPE oum IS TABLE OF VARCHAR2(2);			-- Oum, Объем услуг
oumEnv oum;									-- Oum, Объем услуг
TYPE balance IS TABLE OF VARCHAR2(30);		-- Баланс до и после
balanceEnv balance;							-- Баланс до и после
TYPE provider IS TABLE OF VARCHAR2(30);		-- Комментарий (отображается провайдер)
providerEnv provider;						-- Комментарий (отображается провайдер)
randomEnv int;								-- randomEnv поле CALL_ACTION_CODE
	/* условия для randomEnv
	1. Если поле callActionCode='1', то отображаем значение поля ctn (поле SUBSCRIBER_NO).
	2. Иначе отображаем значение поля msisdn (поле CALL_TO_TN).
	*/
randomCtn int;								-- случайный номер абонента
randomDur int;								-- случайная продолжительность
--providerId varchar2(100);					-- Поле комментарий (отображается провайдер)

ctn varchar2(100);							-- номер абонента
banId varchar2(100);						-- BAN абонента (номер договора)
billingCycleId varchar2(2);					-- номер биллинг-цикла
iterator number;							-- счетчик количества транзакций
amountTransactions number;					-- количество транзакций
dateStartBillingCycle varchar2(20);			-- дата начала биллинг-цикла
dateEndBillingCycle varchar2(20);			-- дата конца биллинг-цикла
physicalNameDB varchar2(10);				-- физическое имя БД
executeUsages varchar2(5000);				-- workTable

begin
ctn:='9060000000';
amountTransactions:=20;
iterator:=0;

feature_desc:=feature_code('00','00CC0','00    ','UVRP01','UVRP15','SS65','BP9ST3','PP13','VOICE','VMN_S9','SV025M','UVRPPO', 'UVMO  ', 'PRT010', 'USO   ');
oumEnv:=oum('SE','EV','SE','MB');
balanceEnv:=balance('D','D','D','D','P','P','P','P','P','P','P','P','P','E','E');
providerEnv:=provider('25099   ','72404   ','29001   ','31027   ','29505   ','43709   ','24201   ','62120   ','50219   ','405850  ','62501   ','27404   ','52099   ','2500783 ','25020281');

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


loop -- цикл выполняется, пока не достигнет значения, заданного в amountTransactions

for i in 1..feature_desc.count loop
randomEnv:=dbms_random.VALUE(1,4);						-- Случайное число от мин до макс
randomCtn:=dbms_random.VALUE(9030000000,9039999999);	-- Случайные номера
randomDur:=dbms_random.VALUE(10,120);					-- Случайное число от мин до макс

executeUsages:='Insert into VMPAPP114.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT,
   MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, SYS_UPDATE_DATE, OPERATOR_ID,
   APPLICATION_ID, DL_SERVICE_CODE, DL_UPDATE_STAMP, AT_SOC, AT_SOC_DATE,
   SOC_EXPIRATION_DATE, SOC_SEQ_NO, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL,
   RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, SERVICE_FTR_SEQ_NO, CALL_ACTION_CODE,
   AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_CALL_DUR_ROUND_MIN, AT_NUM_MINS_TO_RATE,
   AT_NUM_OF_IM, AT_CHARGE_AMT, AT_CHARGE_AMT_INCL_IU, AT_CALL_START_PERIOD, INCOMING_PERIOD_CODE,
   CALL_TO_TN, CALLING_NO, MPS_FILE_NUMBER, SPECIAL_NUM_TYPE, MESSAGE_TYPE,
   AIR_FREE_CODE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR,
   CYCLE_RUN_MONTH, BL_RERATE_CODE, BL_RERATE_DATE, ACTIVITY_RESOLVE_CD, SERVICE_FEATURE_CODE,
   DURATION, FREE_CALL_RSN, METERED_UNITS, DATA_VOLUME, WHOLESALE_PRICE,
   NON_DISC_WH_PRICE, ORIGINAL_AMT, ORIGINAL_AMT_GN, NW_CHARGE_ORIG, FORCE_PROC_IND,
   COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND,
   SERVICE_TYPE, INCOMING_SERVICE, INCOMING_FEATURE, TARIFF_PLAN_ID, INCOMING_ACCOUNT_ID,
   IMSI, IMEI, MSG_CHRG_TYPE_IND, EVENT_TYPE, THRESHOLD_CLASS,
   AT_GROSS_AMT, AC_AMT, CALL_FORWARD_IND, CELL_ID, DEFAULT_BEN,
   USAGE_PAC_CODE, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID,
   RM_TAX_AMT_AIR, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, DIALED_DIGITS,
   CALLED_COUNTRY_CODE, CALL_SOURCE, CALL_DEST, RECORD_ID, INITIAL_FEE_IND,
   CALL_CROSS_DT_IND, CALL_CROSS_IU_IND, MULTI_FTR_IND, PRODUCT_TYPE, CALL_SERVICE,
   TAX_IND, RATE_CODE1, RATE_CODE2, RATE_CODE3, RATE_CODE4,
   RATE_CODE5, RATE_CODE_IND1, RATE_CODE_IND2, RATE_CODE_IND3, RATE_CODE_IND4,
   RATE_CODE_IND5, LOGICAL_DATE, IU_LEVEL_CODE, ALLOCATION_IND, PREFIX_SHORT_CODE,
   AT_CHARGE_AMT_INCL_SGR, UOM, CALCULATE_UC_RATE_IND, SDR_AMOUNT, SUPPLEMENTRY_SRVC_CODE,
   HOME_CTN, TECHNOLOGY, NEW_BALANCE, ADVANCE_PAYM_IND, CALL_DESTINATION,
   SUB_STATUS, CUR_IND, MAIN_CTN, MAIN_SOCNO, COMVERSE_AMT,
   ALREADY_PAYD_IND, SERVICE_ID, ROAM_FLAG, DIRECTION, SPECIAL_FEATURE,
   SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID, DISCOUNT_SOCS, LOCAL_ZONE_ID,
   SESSION_START_DT, USAGE_SESSION_ID, DR_SOC, DR_SOC_SEQ_NO, DR_STEP,
   INCL_PACKS_AGR, EXT_SUBSCRIBER_NO, EXT_SUBSCRIBER_TYPE)
 Values
    ('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), 
    ''14500'', 1, sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), NULL, 
    ''BLPRRR'', ''US034'', 2543, ''RTIER    '', sysdate+('||iterator||'/24/60), 
    sysdate+('||iterator||'/24/60), 10, ''UVMO  '', sysdate+('||iterator||'/24/60), ''C'', 
    ''C'', ''RTIER    '', sysdate+('||iterator||'/24/60), 18, '||randomEnv||', 
    ''0'', sysdate+('||iterator||'/24/60), '||randomDur||', 10, '||(randomDur-5)||', 
    NULL, '||(randomDur-10)||', '||(randomDur-10)||', ''01'', NULL, 
    '||(randomCtn-1)||', '||randomCtn||', 443442, NULL, ''0'', 
    NULL, ''N'', ''N'', 1, 2012, 
    1, ''9'', sysdate+('||iterator||'/24/60), NULL, ''U_LCV '', 
    ''00001000'', NULL, NULL, NULL, NULL, 
    NULL, 28.7, NULL, NULL, NULL, 
    ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''C'', 
    ''P'', NULL, NULL, NULL, NULL, 
    ''250990000000217'', ''111111111111111'', NULL, 747, NULL, 
    43.1, NULL, NULL, ''000513'', 1, 
    ''RUS  '', ''00513'', ''I'', ''N'', ''43404   '', 
    NULL, ''N'', ''11'', ''V'', ''89039990055          '', 
    NULL, ''A'', NULL, ''00006'', NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, ''F<subst> '', NULL, NULL, NULL, 
    NULL, ''Y'', NULL, NULL, NULL, 
    NULL, sysdate+('||iterator||'/24/60), ''C'', NULL, ''NC     '', 
    14.4, ''SE'', ''Y'', NULL, NULL, 
    NULL, ''G'', NULL, ''N'', NULL, 
    ''A'', ''P'', NULL, NULL, NULL, 
    ''N'', ''ZZ'', ''Z'', ''ZZZ'', ''Z'', 
    ''ZZZ'', ''Y'', 45535, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL)';
	
/*
executeUsages:='Insert into VMPAPP14.'||physicalNameDB||'
   (BAN, BEN, BILL_SEQ_NO, SUBSCRIBER_NO, CHANNEL_SEIZURE_DT,
   MESSAGE_SWITCH_ID, US_SEQ_NO, SYS_CREATION_DATE, SYS_UPDATE_DATE, OPERATOR_ID,
   APPLICATION_ID, DL_SERVICE_CODE, DL_UPDATE_STAMP, AT_SOC, AT_SOC_DATE,
   SOC_EXPIRATION_DATE, SOC_SEQ_NO, AT_FEATURE_CODE, AT_RATE_EFF_DATE, AT_RATED_FTR_LVL,
   RATING_LEVEL_CODE, PRICE_PLAN_CODE, PRICE_PLAN_EFF_DATE, SERVICE_FTR_SEQ_NO, CALL_ACTION_CODE,
   AT_RATE_ACTION_CODE, FEATURE_SELECTION_DT, AT_CALL_DUR_SEC, AT_CALL_DUR_ROUND_MIN, AT_NUM_MINS_TO_RATE,
   AT_NUM_OF_IM, AT_CHARGE_AMT, AT_CHARGE_AMT_INCL_IU, AT_CALL_START_PERIOD, INCOMING_PERIOD_CODE,
   CALL_TO_TN, CALLING_NO, MPS_FILE_NUMBER, SPECIAL_NUM_TYPE, MESSAGE_TYPE,
   AIR_FREE_CODE, CALL_CROSS_PRD_IND, CALL_CROSS_STP_IND, CYCLE_CODE, CYCLE_RUN_YEAR,
   CYCLE_RUN_MONTH, BL_RERATE_CODE, BL_RERATE_DATE, ACTIVITY_RESOLVE_CD, SERVICE_FEATURE_CODE,
   DURATION, FREE_CALL_RSN, METERED_UNITS, DATA_VOLUME, WHOLESALE_PRICE,
   NON_DISC_WH_PRICE, ORIGINAL_AMT, ORIGINAL_AMT_GN, NW_CHARGE_ORIG, FORCE_PROC_IND,
   COUNTRY_OF_ORIG, AU_EFF_DATE, CYCLE_MONTH_START_DATE, CYCLE_START_DATE, MPS_RERATED_IND,
   SERVICE_TYPE, INCOMING_SERVICE, INCOMING_FEATURE, TARIFF_PLAN_ID, INCOMING_ACCOUNT_ID,
   IMSI, IMEI, MSG_CHRG_TYPE_IND, EVENT_TYPE, THRESHOLD_CLASS,
   AT_GROSS_AMT, AC_AMT, CALL_FORWARD_IND, CELL_ID, DEFAULT_BEN,
   USAGE_PAC_CODE, LOCATION_AREA, GUIDE_BY, OUTCOLLECT_IND, PROVIDER_ID,
   RM_TAX_AMT_AIR, WAIVED_CALL_IND, BASIC_SERVICE_CODE, BASIC_SERVICE_TYPE, DIALED_DIGITS,
   CALLED_COUNTRY_CODE, CALL_SOURCE, CALL_DEST, RECORD_ID, INITIAL_FEE_IND,
   CALL_CROSS_DT_IND, CALL_CROSS_IU_IND, MULTI_FTR_IND, PRODUCT_TYPE, CALL_SERVICE,
   TAX_IND, RATE_CODE1, RATE_CODE2, RATE_CODE3, RATE_CODE4,
   RATE_CODE5, RATE_CODE_IND1, RATE_CODE_IND2, RATE_CODE_IND3, RATE_CODE_IND4,
   RATE_CODE_IND5, LOGICAL_DATE, IU_LEVEL_CODE, ALLOCATION_IND, PREFIX_SHORT_CODE,
   AT_CHARGE_AMT_INCL_SGR, UOM, CALCULATE_UC_RATE_IND, SDR_AMOUNT, SUPPLEMENTRY_SRVC_CODE,
   HOME_CTN, TECHNOLOGY, NEW_BALANCE, ADVANCE_PAYM_IND, CALL_DESTINATION,
   SUB_STATUS, CUR_IND, MAIN_CTN, MAIN_SOCNO, COMVERSE_AMT,
   ALREADY_PAYD_IND, SERVICE_ID, ROAM_FLAG, DIRECTION, SPECIAL_FEATURE,
   SERVICE_FLAG, MPS_RERATE_IND, SUBSCRIBER_ID, DISCOUNT_SOCS, LOCAL_ZONE_ID,
   SESSION_START_DT, USAGE_SESSION_ID, DR_SOC, DR_SOC_SEQ_NO, DR_STEP,
   INCL_PACKS_AGR, EXT_SUBSCRIBER_NO, EXT_SUBSCRIBER_TYPE)
 Values	
	('||banId||', 1, 1, '||ctn||', sysdate+('||iterator||'/24/60), 
    ''14500'', 1, sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), NULL, 
    ''BLPRRR'', ''US034'', 2543, ''RTIER    '', sysdate+('||iterator||'/24/60), 
    sysdate+('||iterator||'/24/60), 10, '||feature_desc(i)||', sysdate+('||iterator||'/24/60), ''C'', 
    ''C'', ''RTIER    '', sysdate+('||iterator||'/24/60), 18, '||randomEnv||', 
    ''0'', sysdate+('||iterator||'/24/60), '||randomDur||', 10, '||(randomDur-5)||', 
    NULL, '||(randomDur-10)||', 14.4, ''01'', NULL, 
    '||(randomCtn-1)||', '||randomCtn||', 443442, NULL, ''0'', 
    NULL, ''N'', ''N'', 1, 2012, 
    1, ''9'', sysdate+('||iterator||'/24/60), NULL, ''U_LCV '', 
    ''00001000'', NULL, NULL, NULL, NULL, 
    NULL, 28.7, NULL, NULL, NULL, 
    ''VIP'', sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), sysdate+('||iterator||'/24/60), ''C'', 
    ''P'', NULL, NULL, NULL, NULL, 
    ''250990000000217'', ''111111111111111'', NULL, 747, NULL, 
    43.1, NULL, NULL, ''000513'', 1, 
    ''RUS  '', ''00513'', ''I'', ''N'', '||providerEnv(i)||', 
    NULL, ''N'', ''11'', ''V'', ''89039990055          '', 
    NULL, ''A'', NULL, ''00006'', NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, ''F<subst> '', NULL, NULL, NULL, 
    NULL, ''Y'', NULL, NULL, NULL, 
    NULL, sysdate+('||iterator||'/24/60), ''C'', NULL, ''NC     '', 
    14.4, '||oumEnv(randomEnv)||', ''Y'', NULL, NULL, 
    NULL, ''G'', NULL, ''N'', NULL, 
    ''A'', '||balanceEnv(i)||', NULL, NULL, NULL, 
    ''N'', ''ZZ'', ''Z'', ''ZZZ'', ''Z'', 
    ''ZZZ'', ''Y'', 45535, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL)';*/

iterator:=iterator+1;
exit when iterator>amountTransactions;
execute immediate executeUsages;
end loop;

exit when iterator>amountTransactions;
end loop;

commit;
end;