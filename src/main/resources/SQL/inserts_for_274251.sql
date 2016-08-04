declare
TYPE dnames_tab IS TABLE OF VARCHAR2(40);			-- Массив под переменные (для SUB_ID2, CALL_TYPE, LOCATION_A, MTR_COMMENT)
dept_names dnames_tab;								-- Массив под переменные (для SUB_ID2, CALL_TYPE, LOCATION_A, MTR_COMMENT)
TYPE charge_code_massive IS TABLE OF VARCHAR2(40);	-- Новые условия для агрегатов, используется charge_code
charge_code_massiveEnv charge_code_massive;			-- Новые условия для агрегатов, используется charge_code

trn_date date;						/*Date*/
start_balance varchar2(100);		/*Core Balance*/
balance_name varchar2(100);			/*String balance*/
time int;							/*Shifting time*/
ctn varchar2(100);
rounds int;
--SMS
checking_sms int :=1;				/*Need for put another balance each 10 (condition in IF)*/
SMS int :=1;						/*Counter MMS (счетчик СМС)*/
balance_3 int:=10000;				/*Amount Balance 3*/
--SMS end
--MMS
balance_19 int:=30000;
checking_mms int:=1;
MMS int :=1;
--MMS end
--Calls
Calls int :=1;
checking_calls int :=1;
--Calls end
--CallsRoam
CallsRoam int :=1;
checking_callsRoam int :=1;
--CallsRoam end
--CallsOutcoming
CallsOut int :=1;
checking_callsOut int :=1;
--CallsOutcoming end
--CallsRoamOutcomming
CallsRoamOut int :=1;
checking_callsRoamOut int :=1;
--CallsRoam end
--MobileInternet
mobInternet int :=1;
checking_mobInternet int :=1;
balance_18 int :=2000;
--MobileInternet end
--MobileInternet Roaming
mobInternetRoam int :=1;
checking_mobInternetRoam int :=1;
--MobileInternet end
--SMS short
SMSshort int:=1;
checking_SMSshort int:=1;
balance_11 int :=1000;
--SMS short end
begin
ctn:='9030372222';
trn_date := trunc(sysdate)-2;
start_balance:=5000;
time:=1;
rounds:=0;

-- all aggregators (DWH)

-- LOCAL_MMS 2 (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && matches(o.getChargeCode(),"N.(H|\\*).(H|\\*)..."))
--Количество транзакций=2
-- INTERNATIONAL_MMS 2(Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && matches(o.getChargeCode(),"N.(H|\\*).(I|S)..."))
--Количество транзакций=2
dept_names := dnames_tab('79641223322','79030375544','59412542','773245121');
charge_code_massiveEnv:=charge_code_massive('NaHaHaaa','Na*a*aaa','NaHaIaaa','Na*aSaaa');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
IF((MMS/10)=checking_mms) then balance_19:=balance_19-10; balance_name:='[19~'||balance_19||'~10~0]';checking_mms:=checking_mms+1;
ELSE balance_name:='[3~100~0~~0~1]';
end if;
insert into osa_history_url (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, DESCRIPT, REASON_CODE, NEW_BALANCE_1, CHANGE_AMOUNT_1, NEW_BALANCE_2, CHANGE_AMOUNT_2, NEW_BALANCE_3, CHANGE_AMOUNT_3, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_7, CHANGE_AMOUNT_7, NEW_BALANCE_8, CHANGE_AMOUNT_8, NEW_BALANCE_9, CHANGE_AMOUNT_9, NEW_BALANCE_10, CHANGE_AMOUNT_10, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, PARAM_CONFIRM_ID, PARAM_CONTRACT, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, SERVICE_PARAMETER_5, LOCATION_A3, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, CURRENCY, IDENTITY_ID, GROUP_ID, CHARGE_CODE, SPENDING_LIMIT1, SPENDING_LIMIT2, SPENDING_LIMIT3, SPENDING_LIMIT4, SPENDING_LIMIT5, SPENDING_LIMIT6, SPENDING_LIMIT7, SPENDING_LIMIT8, SPENDING_LIMIT9, SPENDING_LIMIT10, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE)
values (ctn, trn_date+time/1440, trn_date+time/1440, 'unitBasedCharge', 1, null, 400, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, 285, 2389, '3', 5, 'MMS_MESSAGE', 'MMSMO:79645768036', 90100215, 3, 17, null, '''mms''', '''-1''', null, null, null, 25, null, null, null, null, null, 2, dept_names(i), 2, '250997100072863', null, null, null, null, charge_code_massiveEnv(i), null, null, null, null, null, null, null, null, null, null,trn_date+time/1440, 1, 'RUR', null, 1.000000, 2039438909494, 122197191, 2, '79036608929', '[1~'||start_balance||'~10~0]'||balance_name, null, '101005696', 1);
MMS:=MMS+1;
end loop;
start_balance:=start_balance-10;

--INTERNATIONAL_ROAMING_MMS 1(Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && inSet(o.getSrcEntity(),"OSA_HISTORY") && inSet(o.getChargeCode(),"MMNINTN000"))
--Количество транзакций=1
 Insert into osa_history_url (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, DESCRIPT, REASON_CODE, NEW_BALANCE_1, CHANGE_AMOUNT_1, NEW_BALANCE_2, CHANGE_AMOUNT_2, NEW_BALANCE_3, CHANGE_AMOUNT_3, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_7, CHANGE_AMOUNT_7, NEW_BALANCE_8, CHANGE_AMOUNT_8, NEW_BALANCE_9, CHANGE_AMOUNT_9, NEW_BALANCE_10, CHANGE_AMOUNT_10, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, PARAM_CONFIRM_ID, PARAM_CONTRACT, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, SERVICE_PARAMETER_5, LOCATION_A3, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, CURRENCY, IDENTITY_ID, GROUP_ID, CHARGE_CODE, SPENDING_LIMIT1, SPENDING_LIMIT2, SPENDING_LIMIT3, SPENDING_LIMIT4, SPENDING_LIMIT5, SPENDING_LIMIT6, SPENDING_LIMIT7, SPENDING_LIMIT8, SPENDING_LIMIT9, SPENDING_LIMIT10, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE)
 Values (ctn,  trn_date+time/1440,  trn_date+time/1440, 'directDebitUnit', 1, null, 400, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, 285, 2389, '3', 5, 'MMS', 'MMS ORP', 12345, 3, 17, null, '''mms''', '''-1''', '1', '1', null, -1, -1, -1, -1, null, null, 2, '201254', 2, '250997101811129', null, null, null, null, 'MMNINTN000', null, null, null, null, null, null, null, null, null, null, trn_date, 1, 'RUR', 'RUR', 1.000000, 2039815596961, 122197446, 2, null, '[1~'||start_balance||'~10~0]', null, '21545', 2);

--LOCAL_SMS 2 (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && matches(o.getChargeCode(),"S.(H|\\*).(H|\\*)..."))
--Количество транзакций=2
--INTERNATIONAL_SMS 2 (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && matches(o.getChargeCode(),"S.(H|\\*).(I|S)..."))
--Количество транзакций=2
--INTERNATIONAL_ROAMING_SMS 4(Condition:"CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && matches(o.getChargeCode(),"(S|N).I.(H|R|I|S|\\*)..."))
--Количество транзакций=4
dept_names := dnames_tab('79647894455','79035544666','2012356','773245121','79030375544','2012356','773245121','79030375544');
charge_code_massiveEnv:=charge_code_massive('SaHaHaaa','Sa*a*aaa','SaHaIaaa','Sa*aSaaa','SaIaHaaa','NaIaRaaa','SaIaIaaa','SaIaSaaa');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
IF((SMS/10)=checking_sms) then balance_3:=balance_3-10; balance_name:='[3~'||balance_3||'~10~0]';checking_sms:=checking_sms+1;
ELSE balance_name:='[3~100~0~~0~1]';
end if;
Insert into PS_TRANSACTION_url
   (SUBSCRIBER_ID, CHARGE_CODE,TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, REFUND_ID_1, REFUND_ID_2, CALL_ID, SLICE, BILLSYSTEM_CODE, TYPE_OF_CHARGE, ISO_CODE, BALANCES_INFO, IDENTITY_ID, SUBTYPE_ID, ORP_DATE,MSC_ID)
 Values
   (ctn, charge_code_massiveEnv(i),trn_date+time/1440, '1', 17, dept_names(i), 833973252, 3256868758, 'Y', 0, 0, 379918750951, 6170003, 28, '3', 'RUR', '[1~'||start_balance||'~10~0]'||balance_name, 1, 4020, trn_date+time/1440,dept_names(i));
SMS:=SMS+1;
end loop;

	--LOCAL_CALLS (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && matches(o.getChargeCode(),"(M|V|O)(O|F|L)(H|\\*).(H|\\*)..."))
	--Количество транзакций=2
	--INTERNATIONAL_CALLS (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && matches(o.getChargeCode(),"(M|V)(O|F)(H|\\*).(I|S)..."))
	--Количество транзакций=2
dept_names := dnames_tab('79647894455','79030375544','773245121','2012356','79031234321','79281114321');
charge_code_massiveEnv:=charge_code_massive('MOHaHaaa','VF*a*aaa','MOHaIaaa','VF*aSaaa','MOHaIaBa','MOH*H*C*');
for i in 1..dept_names.COUNT loop
IF((Calls/10)=checking_calls) then balance_19:=balance_19-10; balance_name:='[19~'||balance_19||'~10~0]';checking_calls:=checking_calls+1;
ELSE balance_name:='[3~100~0~~0~1]';
end if;
time:=time+1;
start_balance:=start_balance-10;
 Insert into CALL_HISTORY_url (SUBSCRIBER_ID,CHARGE_CODE, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
 Values (ctn, charge_code_massiveEnv(i),trn_date+time/1440, dept_names(i), 360, 'IncomingCall', 0, 16, 0, 0, '79281111111', 784048896812, 49030797, 28, '79038889987', '250991770305226', '94', 'RUR', '[1~'||start_balance||'~10~0]'||balance_name, 108, 1);
Calls:=Calls+1;
end loop;

	--VOICE_CALLS_IN_RUSSIA
dept_names := dnames_tab('79647894455','773245121','2012356','79030375544');
for i in 1..dept_names.count loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into CALL_HISTORY_url (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID,charge_code)
 Values (ctn, trn_date+time/1440, dept_names(i), 360, 'OutgoingCall', 0, 16, 0, 0, '79281111111', 784048896812, 49030797, 28, '79038889987', '250991770305226', '94', 'RUR', '[1~'||start_balance||'~10~0]', 108, 1,111+i);
end loop;


-- INTERNATIONAL_ROAMING
	--INTERNATIONAL_ROAMING_INCOMING_CALLS (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && matches(o.getChargeCode(),"(M|V)TI.(H|R|I|S|\\*)..."))
	--Количество транзакций=4
dept_names := dnames_tab('630891234569874','437011236547896','7103001234567896','244211234567896','INCOMING_TPPS_CALL','INCOMING_TPPS_CALL','IncomingCall','IncomingCall');
charge_code_massiveEnv:=charge_code_massive('MTIaHaaa','VTIaRaaa','MTIaIaaa','VTIaSaaa');
for i in 1..dept_names.COUNT/2 loop
IF((CallsRoam/10)=checking_callsRoam) then balance_19:=balance_19-10; balance_name:='[19~'||balance_19||'~10~0]';checking_callsRoam:=checking_callsRoam+1;
ELSE balance_name:='[3~100~0~~0~1]';
end if;
start_balance:=start_balance-10;
time:=time+1;
 Insert into CALL_HISTORY_url (SUBSCRIBER_ID,CHARGE_CODE, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
 Values (ctn,charge_code_massiveEnv(i), trn_date+time/1440, '201544548', 360, dept_names(i+4), 0, 16, 0, 0, '79281111111', 784048896812, 49030797, 28, '79038889987', dept_names(i), '94', 'RUR', '[1~'||start_balance||'~10~0]'||balance_name, 108, 1);
CallsRoam:=CallsRoam+1;
end loop;

	--INTERNATIONAL_ROAMING_OUTCOMING_CALLS (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && matches(o.getChargeCode(),"(M|V)(O|F)I.(H|R|I|S|\\*)..."))
	--Количество транзакций=4
dept_names := dnames_tab('630891234569874','437011236547896','7103001234567896','244211234567896','OUTGOING_OPPS_CALL','EMERGENCY_CALL','OutgoingCallAttempt','OutgoingCall');
charge_code_massiveEnv:=charge_code_massive('MOIaHaaa','VFIaRaaa','MOIaIaaa','VOIaSaaa');
for i in 1..dept_names.COUNT/2 loop
IF((CallsOut/10)=checking_callsOut) then balance_19:=balance_19-10; balance_name:='[19~'||balance_19||'~10~0]';checking_callsOut:=checking_callsOut+1;
ELSE balance_name:='[3~100~0~~0~1]';
end if;
start_balance:=start_balance-10;
time:=time+1;
 Insert into CALL_HISTORY_url (SUBSCRIBER_ID, CHARGE_CODE,CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
 Values (ctn, charge_code_massiveEnv(i) ,trn_date+time/1440, '201544548', 360, dept_names(i+4), 0, 16, 0, 0, '79281111111', 784048896812, 49030797, 28, '79038889987', dept_names(i), '94', 'RUR', '[1~'||start_balance||'~10~0]'||balance_name, 108, 1);
CallsOut:=CallsOut+1;
end loop;

	--INTERNATIONAL_ROAMING_INTERNET (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && matches(o.getChargeCode(),"(G|W).I....."))
	--Количество транзакций=3
dept_names := dnames_tab('GPRS_EUROPE','GPRS_EUROPE','GPRS_ASIA');
charge_code_massiveEnv:=charge_code_massive('GaIaaaaa','WaIaaaaa','GaIaaaaa');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into osa_history_url (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, DESCRIPT, REASON_CODE, NEW_BALANCE_1, CHANGE_AMOUNT_1, NEW_BALANCE_2, CHANGE_AMOUNT_2, NEW_BALANCE_3, CHANGE_AMOUNT_3, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_7, CHANGE_AMOUNT_7, NEW_BALANCE_8, CHANGE_AMOUNT_8, NEW_BALANCE_9, CHANGE_AMOUNT_9, NEW_BALANCE_10, CHANGE_AMOUNT_10, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, PARAM_CONFIRM_ID, PARAM_CONTRACT, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, SERVICE_PARAMETER_5, LOCATION_A3, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, CURRENCY, IDENTITY_ID, GROUP_ID, CHARGE_CODE, SPENDING_LIMIT1, SPENDING_LIMIT2, SPENDING_LIMIT3, SPENDING_LIMIT4, SPENDING_LIMIT5, SPENDING_LIMIT6, SPENDING_LIMIT7, SPENDING_LIMIT8, SPENDING_LIMIT9, SPENDING_LIMIT10, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE)
 Values (ctn, trn_date+time/1440, trn_date+time/1440, 'unitBasedCharge', 1000, '', 400, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, 224, 1806, '42', 21, 'GPRS', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:193.152.100.38', '''Internet''', '''VOLUME_K''', '', '', 86, -1, -1, -1, -1, null, null, 2, 'IP85.115.245.246', 2, '240991420235429', '''000000;000000;10000#GGSN6-5;3602306640;31728;1''', '', null, '', charge_code_massiveEnv(i), null, null, null, null, null, null, null, null, null, null, trn_date+time/1440, 1, 'RUR', '', 1.000000, 2029562997434, 122115318, 2, dept_names(i), '[1~'||start_balance||'~10~0]', '', '1424296704'||time||'1', 1);
end loop;

--MOBILE_INTERNET (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && matches(o.getChargeCode(),"(G|W).(H|\\*)....."))
--Количество транзакций=3
dept_names := dnames_tab('200241234567891','1110751234567890','1110751234567890');
charge_code_massiveEnv:=charge_code_massive('GaHaaaaa','Wa*aaaaa','Ga*aaaaa');
for i in 1..dept_names.COUNT loop
IF((mobInternet/10)=checking_mobInternet) then balance_18:=balance_18-10; balance_name:='[18~'||balance_18||'~10~0]';checking_mobInternet:=checking_mobInternet+1;
ELSE balance_name:='[3~100~0~~0~1]';
end if;
start_balance:=start_balance-10;
time:=time+1;
 Insert into osa_history_url (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, DESCRIPT, REASON_CODE, NEW_BALANCE_1, CHANGE_AMOUNT_1, NEW_BALANCE_2, CHANGE_AMOUNT_2, NEW_BALANCE_3, CHANGE_AMOUNT_3, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_7, CHANGE_AMOUNT_7, NEW_BALANCE_8, CHANGE_AMOUNT_8, NEW_BALANCE_9, CHANGE_AMOUNT_9, NEW_BALANCE_10, CHANGE_AMOUNT_10, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, PARAM_CONFIRM_ID, PARAM_CONTRACT, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, SERVICE_PARAMETER_5, LOCATION_A3, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, CURRENCY, IDENTITY_ID, GROUP_ID, CHARGE_CODE, SPENDING_LIMIT1, SPENDING_LIMIT2, SPENDING_LIMIT3, SPENDING_LIMIT4, SPENDING_LIMIT5, SPENDING_LIMIT6, SPENDING_LIMIT7, SPENDING_LIMIT8, SPENDING_LIMIT9, SPENDING_LIMIT10, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE)
 Values (ctn, trn_date+time/1440, trn_date+time/1440, 'unitBasedCharge', 1000, '', 400, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, 224, 1806, '42', 21, 'GPRS', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:193.152.100.38', '''Internet''', '''VOLUME_K''', '', '', 86, -1, -1, -1, -1, null, null, 2, 'IP85.115.245.246', 2, '240991420235429', '''000000;000000;10000#GGSN6-5;3602306640;31728;1''', '', null, '', charge_code_massiveEnv(i), null, null, null, null, null, null, null, null, null, null, trn_date+time/1440, 1, 'RUR', '', 1.000000, 2029562997434, 122115318, 2, 'GPRS_BEELINE_CENTER', '[1~'||start_balance||'~10~0]'||balance_name, '', '1424296704'||time||'1', 1);
 Insert into usersessions (NUMCHARGEID, CHRMSISDN, VCHAPN, DTMSTARTDATE, NUMVOLUME, NUMRATEDVOLUME, DTMSYSCREATIONDATE, DTMSYSUPDATEDATE, BILLSYSTEM_CODE, SLICE)
 Values (564, ctn, 'test', trn_date+(time+1)/1440, 1024, 1633280, trn_date+(time+1)/1440, null, 28, 7777400);
mobInternet:=mobInternet+1;
end loop;

--INFO_ENTERTAINMENT (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && matches(o.getChargeCode(),"((S|N|M|V)...(F|P)...)|((C|I|D|R|P).......)"))

	-- HOME_SERVICE_INFO_ENTERTAINMENT (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0  && inSet(o.getSrcEntity(),"MTR") && contains(o.getComment(),"@PATID=CNVVOD@"))
dept_names := dnames_tab('any@PATID=CNVVOD@any');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into mtr_url (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
 Values (null, 0, 'TESTER', null, null, 0, null,dept_names(i), null, null, null, null, null, null, 2009114048420, 121943617, trn_date+time/1440, 27, ctn, null, null, null, null, 'RUR', '', null, null, null, null, null, null, null, '[1~'||start_balance||'~10~0]', null, null, null, null, null);
end loop;

	-- MOBILE_SERVICE_INFO_ENTERTAINMENT (Condition: ("CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && ((inSet(o.getSrcEntity(), "OSA_HISTORY") && inSet(o.getMerchantId(), "CDP", "bol") && !("RBT".equals(o.getMerchantId()) && "RBT_FEE".equals(o.getSessionDesc()))) || (inSet(o.getSrcEntity(), "PS_TRANSACTION") && (matches(o.getOperationType(), "C.*", "WCP.*") || inSet(o.getMessageType(), "3", "10")))) || (inSet(o.getSrcEntity(), "CALL_HISTORY") && inSet(o.getCtn(), "0688", "08216", "0911"))) )
--Количество транзакций=4
dept_names := dnames_tab('C*','WCP*');
charge_code_massiveEnv:=charge_code_massive('SaaaFaaa','Caaaaaaa');
for i in 1..dept_names.COUNT loop
IF((SMSshort/10)=checking_SMSshort) then balance_11:=balance_11-10; balance_name:='[11~'||balance_11||'~10~0]';checking_SMSshort:=checking_SMSshort+1;
ELSE balance_name:='[3~100~0~~0~1]';
end if;
start_balance:=start_balance-10;
time:=time+1;
 Insert into PS_TRANSACTION_url (SUBSCRIBER_ID, CHARGE_CODE,TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, REFUND_ID_1, REFUND_ID_2, CALL_ID, SLICE, BILLSYSTEM_CODE, TYPE_OF_CHARGE, ISO_CODE, BALANCES_INFO, IDENTITY_ID, SUBTYPE_ID, ORP_DATE,MSC_ID)
 Values (ctn, charge_code_massiveEnv(i),trn_date+time/1440, '1', 17, '4455', 833973252, 3256868758, 'Y', 0, 0, 379918750951, 6170003, 28, dept_names(i), 'RUR', '[1~'||start_balance||'~10~0]'||balance_name, 1, 4020, trn_date+time/1440,'1234');
dept_names := dnames_tab('3','10');
charge_code_massiveEnv:=charge_code_massive('NaaaPaaa','Paaaaaaa');
end loop;
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into PS_TRANSACTION_url (SUBSCRIBER_ID,CHARGE_CODE ,TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, REFUND_ID_1, REFUND_ID_2, CALL_ID, SLICE, BILLSYSTEM_CODE, TYPE_OF_CHARGE, ISO_CODE, BALANCES_INFO, IDENTITY_ID, SUBTYPE_ID, ORP_DATE,MSC_ID)
 Values (ctn,charge_code_massiveEnv(i) ,trn_date+time/1440, '1', dept_names(i), '5544', 833973252, 3256868758, 'Y', 0, 0, 379918750951, 6170003, 28, '1234', 'RUR', '[1~'||start_balance||'~10~0]', 1, 4020, trn_date+time/1440,'1234');
SMSshort:=SMSshort+1;
end loop;


--SUBSCRIBER_FEE_AND_SERVICE_CHANGE_FEE 
	-- HOME_SERVICE_SUBSCRIBER_FEE_AND_SERVICE_CHANGE_FEE (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0  && (inSet(o.getSrcEntity(),"MTR") && contains(o.getComment(),"@MTR=CNVBAS@", "@MTR=CNVST@", "@MTR=CNVKSP@", "@MTR=CNVVOL@", "@MTR=CNVTV@", "@MTR=CNVML1@","@MTR=CNVML2@","@MTR=CNVML3@","@MTR=CNVML4@")) || (inSet(o.getSrcEntity(),"RC") && contains(o.getComment(),"PC_PC_CNVBAS_MUAD", "PC_PC_CNVST_MUAD", "PC_PC_CNVKSP_MUAD", "PC_PC_CNVVOL_MUAD", "PC_PC_CNVTV_MUAD", "PC_PC_CNVML1_MUAD","PC_PC_CNVML2_MUAD","PC_PC_CNVML3_MUAD","PC_PC_CNVML4_MUAD")) )
dept_names := dnames_tab('@MTR=CNVBAS@', '@MTR=CNVST@', '@MTR=CNVKSP@', '@MTR=CNVVOL@', '@MTR=CNVTV@', '@MTR=CNVML1@','@MTR=CNVML2@','@MTR=CNVML3@','@MTR=CNVML4@');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into mtr_url (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
 Values (null, 0, 'TESTER', null, null, 0, null,dept_names(i), null, null, null, null, null, null, 2009114048420, 121943617, trn_date+time/1440, 27, ctn, null, null, null, null, 'RUR', '', null, null, null, null, null, null, null, '[1~'||start_balance||'~10~0]', null, null, null, null, null);
end loop;

	-- PAYMENT_FOR_EQUIPMENT (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0  && (inSet(o.getSrcEntity(),"MTR") && contains(o.getComment(),"@PATID=CNVPAYOFF@", "@MTR=CNVRT9@", "@MTR=CNVRT1@","@MTR=CNVRT2@","@MTR=CNVRT3@","@MTR=CNVRT4@","@MTR=CNVRT5@","@MTR=CNVRT6@","@MTR=CNVRT7@","@MTR=CNVRT8@")) || (inSet(o.getSrcEntity(),"RC") && contains(o.getComment(),"PC_PC_CNVINS_MUAD", "PC_PC_CNVRT9_MUAD", "PC_PC_CNVRT1_MUAD","PC_PC_CNVRT2_MUAD","PC_PC_CNVRT3_MUAD","PC_PC_CNVRT4_MUAD","PC_PC_CNVRT5_MUAD","PC_PC_CNVRT6_MUAD","PC_PC_CNVRT7_MUAD","PC_PC_CNVRT8_MUAD")) )
dept_names := dnames_tab('@PATID=CNVPAYOFF@', '@MTR=CNVRT9@', '@MTR=CNVRT1@','@MTR=CNVRT2@','@MTR=CNVRT3@','@MTR=CNVRT4@','@MTR=CNVRT5@','@MTR=CNVRT6@','@MTR=CNVRT7@','@MTR=CNVRT8@');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into mtr_url (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
 Values (null, 0, 'TESTER', null, null, 0, null,dept_names(i), null, null, null, null, null, null, 2009114048420, 121943617, trn_date+time/1440, 27, ctn, null, null, null, null, 'RUR', '', null, null, null, null, null, null, null, '[1~'||start_balance||'~10~0]', null, null, null, null, null);
end loop;

	-- MOBILE_SERVICE_SUBSCRIBER_FEE_AND_SERVICE_CHANGE_FEE (Condition: "CORE BALANCE".equals(b.getName()) & b.getAmountChg() <= 0 & ((inSet(o.getSrcEntity(),"MTR") && (inSet(o.getComment(),"A1B","A58","A3L","A3V","A33","A11","A3H","A10","A15","A5E","A5O","A3D","A32","A5I","A1K","A37","A3Z","A3U","A3P","A5M","A12","A3I","A5H","A57","A16","A38","A1C","A5C","A5R","A50","A3B","A19","A3E","A1Y","A52","A3F","A5S","A39","A3T","A17","A5G","A1W","A56","A3J","A5Q","A13","A53","A5D","A3O","A3Q","A1D","A5J","A3A","A1N","A35","A5K","A36","A1X","A3R ","A18","A3C","A5F","A1Z","A1A","A54","A5A","A14","A1E","A55","A5N","A3S","A59","A1T","A3W","A3G","COS CHANGE","A1F","A1G","A1H","A1I","A1J","A1L","A1M","A1O","A1P","A1Q","A1R","A1S","A1V","A30","A34","A3M","A3N","A3X","A51","A52","A5B","A5L","A5P","A20","A21","A22","A23","A24","A25","A26","A27","A28","A29","A2A","A2B","A2C","A2D","A2E","A2F","A2G","A2H","A2I","A2J","A2K","A2M","A2N","A2O","A2P","A2Q","A2R","A2S","A2T","A2U","A2V","A2W","A2X","A2Y","A2Z","A40","A41","A42","A43","A44","A45","A46","A47","A48","A49","A4A","A4B","A4?","A4D","A4E","A4F","A4G","A4H","A4I","A4J","A4K","A4L","A4M","A4N","A4O","A4P","A4Q","A4R","A4S","A4T","A4U","A4V","A4W","A4X","A4Y","A4Z","A61","A62","A63","A64","A65","A66","A67","A68","A69","A60","A6A","A6B","A6A","A6C","A6D") || matches(o.getComment(),"A@.*CPVAL.*","A@.*CHGVAL.*","pc_.*","A@.*OCVAL.*","RC_*"))) || (inSet(o.getSrcEntity(),"RC") && matches(o.getComment(),"PC_.*") && !contains(o.getComment(),"PC_PC_CNVBAS_MUAD", "PC_PC_CNVST_MUAD", "PC_PC_CNVKSP_MUAD", "PC_PC_CNVVOL_MUAD", "PC_PC_CNVTV_MUAD", "PC_PC_CNVML1_MUAD","PC_PC_CNVML2_MUAD","PC_PC_CNVML3_MUAD","PC_PC_CNVML4_MUAD")) || (inSet(o.getSrcEntity(),"MTR") && startsWith(o.getComment(),"Payment of a service fee for the use of the promised payment")) || (inSet(o.getSrcEntity(),"OSA_HISTORY") && ("RBT".equals(o.getMerchantId()) && "RBT_FEE".equals(o.getSessionDesc())))))
dept_names := dnames_tab('PC_.*','A@.*OCVAL.*','A1B','A58','A3L','A3V','A33','A11','A3H','A10','A15','A5E','A5O','A3D','A32','A5I','A1K','A37','A3Z','A3U');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into mtr_url (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
 Values (null, 0, 'TESTER', null, null, 0, null,dept_names(i), null, null, null, null, null, null, 2009114048420, 121943617, trn_date+time/1440, 27, ctn, null, null, null, null, 'RUR', '', null, null, null, null, null, null, null, '[1~'||start_balance||'~10~0]', null, null, null, null, null);
end loop;
	

-- SERVICES_PAYMENTS_AND_MOBILE_TRANSFERS
	-- SERVICES_PAYMENTS_AND_MOBILE_COMMERCE (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0 && inSet(o.getSrcEntity(),"OSA_HISTORY") && startsWith(o.getOsaItem(),"'MC'"))
dept_names := dnames_tab('''MC''','''MC''');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into osa_history_url (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, DESCRIPT, REASON_CODE, NEW_BALANCE_1, CHANGE_AMOUNT_1, NEW_BALANCE_2, CHANGE_AMOUNT_2, NEW_BALANCE_3, CHANGE_AMOUNT_3, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_7, CHANGE_AMOUNT_7, NEW_BALANCE_8, CHANGE_AMOUNT_8, NEW_BALANCE_9, CHANGE_AMOUNT_9, NEW_BALANCE_10, CHANGE_AMOUNT_10, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, PARAM_CONFIRM_ID, PARAM_CONTRACT, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, SERVICE_PARAMETER_5, LOCATION_A3, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, CURRENCY, IDENTITY_ID, GROUP_ID, CHARGE_CODE, SPENDING_LIMIT1, SPENDING_LIMIT2, SPENDING_LIMIT3, SPENDING_LIMIT4, SPENDING_LIMIT5, SPENDING_LIMIT6, SPENDING_LIMIT7, SPENDING_LIMIT8, SPENDING_LIMIT9, SPENDING_LIMIT10, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE)
 Values (ctn, trn_date+time/1440, trn_date+time/1440, 'unitBasedCharge', 1000, '', 400, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, 224, 1806, '42', 21, 'test', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:193.152.100.38', dept_names(i)||'sfd12'||time, '''VOLUME_K''', '', '', 86, -1, -1, -1, -1, null, null, 2, 'IP85.115.245.246', 2, '240991420235429', '''000000;000000;10000#GGSN6-5;3602306640;31728;1''', '', null, '', '', null, null, null, null, null, null, null, null, null, null, trn_date+time/24*60, 1, 'RUR', '', 1.000000, 2029562997434, 122115318, 2, '435', '[1~'||start_balance||'~10~0]', '', '1424296704'||time||'1', 1);
end loop;

	-- MOBILE_TRANSFERS (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0  && ((inSet(o.getSrcEntity(),"OSA_HISTORY") && startsWith(o.getOsaItem(),"'MC'")) || (inSet(o.getSrcEntity(),"MTR") && matches(o.getComment(),"XPB,.*,.*"))))
dept_names := dnames_tab('XPB,sdf*,sd*','XPB,1f*,sfg*');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into mtr_url (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
 Values (null, 0, 'TESTER', null, null, 0, null,dept_names(i), null, null, null, null, null, null, 2009114048420, 121943617, trn_date+time/1440, 27, ctn, null, null, null, null, 'RUR', '', null, null, null, null, null, null, null, '[1~'||start_balance||'~10~0]', null, null, null, null, null);
end loop;

	-- TRUSTED_AND_AUTO_PAYMENTS (Condition: "CORE BALANCE".equals(b.getName()) & b.getAmountChg() <= 0 & (inSet(o.getSrcEntity(), "MTR") & (startsWith(o.getComment(), "Repayment of a promised payment") || startsWith(o.getComment(), "Repayment of a partial promised payment") || startsWith(o.getComment(), "Repayment of a complete promised payment"))) )
dept_names := dnames_tab('Repayment of a promised payment','Repayment of a partial promised payment','Repayment of a complete promised payment');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into mtr_url (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
 Values (null, 0, 'TESTER', null, null, 0, null,dept_names(i), null, null, null, null, null, null, 2009114048420, 121943617, trn_date+time/1440, 23, ctn, null, null, null, null, 'RUR', '', null, null, null, null, null, null, null, '[1~'||start_balance||'~10~0]', null, null, null, null, null);
end loop;

	-- HOME_SERVICE_PAYMENTS_AND_MOBILE_TRANSFERS (Condition: "CORE BALANCE".equals(b.getName()) && b.getAmountChg() <= 0  && inSet(o.getSrcEntity(),"MTR") && contains(o.getComment(),"@PATID=CNVSPEC@", "@PATID=CNVCONNECT2@", "@PATID=CNVCONNECT1@"))
dept_names := dnames_tab('@PATID=CNVSPEC@','@PATID=CNVCONNECT2@','@PATID=CNVCONNECT1@');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into mtr_url (PART_KEY, ID, LOGIN_NAME, AMOUNT, NEW_BALANCE, BALANCE_TYPE, NEW_BALANCE_2, MTR_COMMENT, FREE_SECONDS_AMOUNT, FREE_SECONDS_NEW_BALANCE, P_BALANCE_1_AMOUNT, NEW_P_BALANCE_1, P_BALANCE_2_AMOUNT, NEW_P_BALANCE_2, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, FREE_SMS_AMOUNT, FREE_SMS_NEW_BALANCE, NEW_VAS_BALANCE, VAS_CHARGE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, NEW_BALANCE_6, CHANGE_AMOUNT_6, PREV_COS_ID, CURRENT_COS_ID, NEW_BALANCE_10, CHANGE_AMOUNT_10, BALANCES_INFO, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, IDENTITY_ID)
 Values (null, 0, 'TESTER', null, null, 0, null,dept_names(i), null, null, null, null, null, null, 2009114048420, 121943617, trn_date+time/1440, 23, ctn, null, null, null, null, 'RUR', '', null, null, null, null, null, null, null, '[1~'||start_balance||'~10~0]', null, null, null, null, null);
end loop;


-- SMS_MMS
	--SMS_IN_RUSSIA
dept_names := dnames_tab('79647894455','773245121','2012356','79030375544');
for i in 1..dept_names.count loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into PS_TRANSACTION_url (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, REFUND_ID_1, REFUND_ID_2, CALL_ID, SLICE, BILLSYSTEM_CODE, TYPE_OF_CHARGE, ISO_CODE, BALANCES_INFO, IDENTITY_ID, SUBTYPE_ID, ORP_DATE,MSC_ID,charge_code)
 Values (ctn, trn_date+time/1440, '1', '17', dept_names(i), 833973252, 3256868758, 'Y', 0, 0, 379918750951, 6170003, 28, '1234', 'RUR', '[1~'||start_balance||'~10~0]', 1, 4020, trn_date+time/1440,'1234',1259+i);
end loop;
	--MMS_IN_RUSSIA
dept_names := dnames_tab('201254','773245121','59412542','79641223322','79030375544');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
Insert into OSA_HISTORY_url
   (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, DESCRIPT, REASON_CODE, NEW_BALANCE_1, CHANGE_AMOUNT_1, NEW_BALANCE_2, CHANGE_AMOUNT_2, NEW_BALANCE_3, CHANGE_AMOUNT_3, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_7, CHANGE_AMOUNT_7, NEW_BALANCE_8, CHANGE_AMOUNT_8, NEW_BALANCE_9, CHANGE_AMOUNT_9, NEW_BALANCE_10, CHANGE_AMOUNT_10, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, PARAM_CONFIRM_ID, PARAM_CONTRACT, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, SERVICE_PARAMETER_5, LOCATION_A3, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, CURRENCY, IDENTITY_ID, GROUP_ID, CHARGE_CODE, SPENDING_LIMIT1, SPENDING_LIMIT2, SPENDING_LIMIT3, SPENDING_LIMIT4, SPENDING_LIMIT5, SPENDING_LIMIT6, SPENDING_LIMIT7, SPENDING_LIMIT8, SPENDING_LIMIT9, SPENDING_LIMIT10, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE)
 Values
   (ctn,trn_date+time/1440, trn_date+time/1440, 'unitBasedCharge', 1, 
    NULL, 400, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, 0, 224, 1806, 
    '42', 21, 'MMS_MESSAGE', 'INT GPRS charging', 12345, 
    2, 1, 'SGSN_IP_ADDRESS:193.152.100.38', '''mms''', '''VOLUME_K''', 
    NULL, NULL, 86, -1, -1, 
    -1, -1, NULL, NULL, 2, 
    dept_names(i), 2, '240991420235429', '''000000;000000;10000#GGSN6-5;3602306640;31728;1''', NULL, 
    NULL, NULL, 2167+i/*charge_code*/, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, trn_date+time/1440, 1, 
    'RUR', NULL, 1, 2029562997434, 122115318, 
    2, 'GPRS_ASIA', '[1~'||start_balance||'~10~0]', NULL, '1424296704321', 
    1);
end loop;


-- ROAMING_IN_RUSSIA
	-- ROAMING_IN_RUSSIA_OUTCOMING_CALLS

dept_names := dnames_tab('79647894455','773245121','2012356','79030375544');
for i in 1..dept_names.count loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into CALL_HISTORY_url (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID,charge_code)
 Values (ctn, trn_date+time/1440, dept_names(i), 360, 'OutgoingCall', 0, 16, 0, 0, '79281111111', 784048896812, 49030797, 28, '79038889987', '250991770305226', '94', 'RUR', '[1~'||start_balance||'~10~0]', 108, 1,282+i);
end loop;

	-- ROAMING_IN_RUSSIA_INCOMING_CALLS
dept_names := dnames_tab('79647894455','773245121','2012356','79030375544');
for i in 1..dept_names.count loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into CALL_HISTORY_url (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID,charge_code)
 Values (ctn, trn_date+time/1440, dept_names(i), 360, 'IncomingCall', 0, 16, 0, 0, '79281111111', 784048896812, 49030797, 28, '79038889987', '250991770305226', '94', 'RUR', '[1~'||start_balance||'~10~0]', 108, 1,1068+i);
end loop;

	-- ROAMING_IN_RUSSIA_SMS_MMS
	-- SMS
dept_names := dnames_tab('79647894455','773245121','2012356','79030375544');
for i in 1..dept_names.count loop
start_balance:=start_balance-10;
time:=time+1;
 Insert into PS_TRANSACTION_url (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, REFUND_ID_1, REFUND_ID_2, CALL_ID, SLICE, BILLSYSTEM_CODE, TYPE_OF_CHARGE, ISO_CODE, BALANCES_INFO, IDENTITY_ID, SUBTYPE_ID, ORP_DATE,MSC_ID,charge_code)
 Values (ctn, trn_date+time/1440, '1', '17', dept_names(i), 833973252, 3256868758, 'Y', 0, 0, 379918750951, 6170003, 28, '1234', 'RUR', '[1~'||start_balance||'~10~0]', 1, 4020, trn_date+time/1440,'1234',1426+i);
end loop;
	-- MMS
dept_names := dnames_tab('201254','773245121','59412542','79641223322','79030375544');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
Insert into OSA_HISTORY_url
   (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, DESCRIPT, REASON_CODE, NEW_BALANCE_1, CHANGE_AMOUNT_1, NEW_BALANCE_2, CHANGE_AMOUNT_2, NEW_BALANCE_3, CHANGE_AMOUNT_3, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_7, CHANGE_AMOUNT_7, NEW_BALANCE_8, CHANGE_AMOUNT_8, NEW_BALANCE_9, CHANGE_AMOUNT_9, NEW_BALANCE_10, CHANGE_AMOUNT_10, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, PARAM_CONFIRM_ID, PARAM_CONTRACT, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, SERVICE_PARAMETER_5, LOCATION_A3, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, CURRENCY, IDENTITY_ID, GROUP_ID, CHARGE_CODE, SPENDING_LIMIT1, SPENDING_LIMIT2, SPENDING_LIMIT3, SPENDING_LIMIT4, SPENDING_LIMIT5, SPENDING_LIMIT6, SPENDING_LIMIT7, SPENDING_LIMIT8, SPENDING_LIMIT9, SPENDING_LIMIT10, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE)
 Values
   (ctn,trn_date+time/1440, trn_date+time/1440, 'unitBasedCharge', 1, 
    NULL, 400, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, 0, 224, 1806, 
    '42', 21, 'MMS_MESSAGE', 'INT GPRS charging', 12345, 
    2, 1, 'SGSN_IP_ADDRESS:193.152.100.38', '''mms''', '''VOLUME_K''', 
    NULL, NULL, 86, -1, -1, 
    -1, -1, NULL, NULL, 2, 
    dept_names(i), 2, '240991420235429', '''000000;000000;10000#GGSN6-5;3602306640;31728;1''', NULL, 
    NULL, NULL, 'N*Naaaaa', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, trn_date+time/1440, 1, 
    'RUR', NULL, 1, 2029562997434, 122115318, 
    2, 'GPRS_ASIA', '[1~'||start_balance||'~10~0]', NULL, '1424296704321', 
    1);
end loop;

	-- ROAMING_IN_RUSSIA_INTERNET ((G|W).N.....)
dept_names := dnames_tab('201254','773245121','59412542','79641223322','79030375544');
for i in 1..dept_names.COUNT loop
start_balance:=start_balance-10;
time:=time+1;
Insert into OSA_HISTORY_url
   (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, DESCRIPT, REASON_CODE, NEW_BALANCE_1, CHANGE_AMOUNT_1, NEW_BALANCE_2, CHANGE_AMOUNT_2, NEW_BALANCE_3, CHANGE_AMOUNT_3, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_7, CHANGE_AMOUNT_7, NEW_BALANCE_8, CHANGE_AMOUNT_8, NEW_BALANCE_9, CHANGE_AMOUNT_9, NEW_BALANCE_10, CHANGE_AMOUNT_10, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, PARAM_CONFIRM_ID, PARAM_CONTRACT, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, SERVICE_PARAMETER_5, LOCATION_A3, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, CURRENCY, IDENTITY_ID, GROUP_ID, CHARGE_CODE, SPENDING_LIMIT1, SPENDING_LIMIT2, SPENDING_LIMIT3, SPENDING_LIMIT4, SPENDING_LIMIT5, SPENDING_LIMIT6, SPENDING_LIMIT7, SPENDING_LIMIT8, SPENDING_LIMIT9, SPENDING_LIMIT10, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE)
 Values
   (ctn,trn_date+time/1440, trn_date+time/1440, 'unitBasedCharge', 1000, 
    NULL, 400, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, 0, 224, 1806, 
    '42', 21, 'GPRS', 'INT GPRS charging', 12345, 
    2, 1, 'SGSN_IP_ADDRESS:193.152.100.38','''Internet''', '''VOLUME_K''', 
    NULL, NULL, 86, -1, -1, 
    -1, -1, NULL, NULL, 2, 
    dept_names(i), 2, '240991420235429', '''000000;000000;10000#GGSN6-5;3602306640;31728;1''', NULL, 
    NULL, NULL, 2490+i/*charge_code*/, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, trn_date+time/1440, 1, 
    'RUR', NULL, 1, 2029562997434, 122115318, 
    2, 'GPRS_BEELINE_ASIA', '[1~'||start_balance||'~10~0]', NULL, '1424296704322', 
    1);
end loop;

-- for testing parameter <NEED_BALANCE_GRANTS>Y</NEED_BALANCE_GRANTS> (1 transaction create grant + 1 grant)
 Insert into MTR_URL (ID, LOGIN_NAME, BALANCE_TYPE, MTR_COMMENT, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO, IDENTITY_ID, GRANT_ID, GRANT_AMOUNT, BALANCE_GRANT_ID)
 Values (0, 'sapiuser', 0, 'SAPI GRANT CREATED', 277665337522, 6167025, sysdate-2, 23, ctn, 'RUR', 1555, '[1~990~0~0][19~100~-20~2025-09-09 00:00:00~0~1]', 1, 170815182058563, 20, 19);
 Insert into BALANCE_GRANTS_URL (GRANT_DATE, EXTERNAL_ID, BALANCE_ID, GRANT_ID, GRANT_EXPIRATION_TYPE, GRANT_AMOUNT, GRANT_ACTIVE_DATE, GRANT_EXPIRY_DATE, GRANT_STATUS, GRANT_SOURCE, SLICE)
 Values (trunc(sysdate)-1, ctn, 19, 170815182058563, 2, 20, sysdate-2, TO_DATE('12/31/2016 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 1, 'RECHARGE', 1234);

-- for testing parameter <I_FILTER_TECH>Y</I_FILTER_TECH> (1 transaction)
start_balance:=start_balance-10;
time:=time+1;
 Insert into CALL_HISTORY_URL (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
 Values (ctn, trn_date+time/1440, '79585080000', 0, 'OutgoingCall', 0, 16, 0, 0, '79111123412', 784048896812, 49030797, 23, '79038889987', 'null', '94', 'RUR', '[1~'||start_balance||'~0~0]', 108, 1);

-- for testing parameter <UNITE_SESSION>Y</UNITE_SESSION> (4 OSA-transactions)
LOOP
EXIT when rounds=4;
start_balance:=start_balance-10;
time:=time+1;
 Insert into OSA_HISTORY_URL (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, DESCRIPT, REASON_CODE, NEW_BALANCE_1, CHANGE_AMOUNT_1, NEW_BALANCE_2, CHANGE_AMOUNT_2, NEW_BALANCE_3, CHANGE_AMOUNT_3, NEW_BALANCE_4, CHANGE_AMOUNT_4, NEW_BALANCE_5, CHANGE_AMOUNT_5, NEW_BALANCE_6, CHANGE_AMOUNT_6, NEW_BALANCE_7, CHANGE_AMOUNT_7, NEW_BALANCE_8, CHANGE_AMOUNT_8, NEW_BALANCE_9, CHANGE_AMOUNT_9, NEW_BALANCE_10, CHANGE_AMOUNT_10, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, PARAM_CONFIRM_ID, PARAM_CONTRACT, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, SERVICE_PARAMETER_5, LOCATION_A3, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, CURRENCY, IDENTITY_ID, GROUP_ID, CHARGE_CODE, SPENDING_LIMIT1, SPENDING_LIMIT2, SPENDING_LIMIT3, SPENDING_LIMIT4, SPENDING_LIMIT5, SPENDING_LIMIT6, SPENDING_LIMIT7, SPENDING_LIMIT8, SPENDING_LIMIT9, SPENDING_LIMIT10, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, PREV_ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, ADDITIONAL_GROUP_INFO, SESSION_ID, RECORD_SOURCE)
 Values (ctn, trn_date+(23/24)+(rounds/1440), trn_date+(23/24)+(rounds/1440), 'unitBasedCharge', 500, '', 400, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 0, 224, 1806, '42', 21, 'GPRS', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:193.152.100.38', '''Internet''', '''VOLUME_K''', '', '', 86, -1, -1, -1, -1, null, null, 2, 'IP85.115.245.246', 2, '240991420235429', '''000000;000000;10000#GGSN6-5;3602306640;31728;1''', '', null, '', 'GaHaaaaa', null, null, null, null, null, null, null, null, null, null, trn_date+time/1440, 1, 'RUR', '', 1.000000, 2029562997434, 122115318, 2, 'GPRS_BEELINE_CENTER', '[1~'||start_balance||'~10~0]'||balance_name, '', '2000963000', 1);
rounds:=rounds+1;
end loop;

commit;
end;


/*
-- удаление всех транзакций

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
deleteRc varchar2(5000);
deleteNrc varchar2(5000);

begin
ctn:='9030372222';
tablePrefixDwh:='URL';
deleteCallHistory:='delete from call_history_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and call_date_time between trunc(sysdate)-2 and sysdate';
deleteMtr:='delete from mtr_'||tablePrefixDwh||' where pps_account in('||ctn||',7'||ctn||') and mtr_date_time between trunc(sysdate)-2 and sysdate';
deleteOsaHistory:='delete from osa_history_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and start_call_date_time between trunc(sysdate)-2 and sysdate';
deletePsTransaction:='delete from ps_transaction_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and transaction_date_time between trunc(sysdate)-2 and sysdate';
deleteRechargeHistory:='delete from recharge_history_'||tablePrefixDwh||' where subscriber_id in('||ctn||',7'||ctn||') and recharge_date_time between trunc(sysdate)-2 and sysdate';
deleteRoamingCalls:='delete from ROAMING_CALLS where subscriber_id in('||ctn||',7'||ctn||') and call_date_time between trunc(sysdate)-2 and sysdate';
deleteUsersessions:='delete from USERSESSIONS where CHRMSISDN in('||ctn||',7'||ctn||') and dtmstartdate between trunc(sysdate)-2 and sysdate';
deleteRc:='delete from rc_'||tablePrefixDwh||' where pps_account in('||ctn||',7'||ctn||') and rc_date_time between trunc(sysdate)-2 and sysdate';
deleteNrc:='delete from nrc_'||tablePrefixDwh||' where pps_account in('||ctn||',7'||ctn||') and nrc_date_time between trunc(sysdate)-2 and sysdate';
execute immediate deleteCallHistory;
execute immediate deleteMtr;
execute immediate deleteOsaHistory;
execute immediate deletePsTransaction;
execute immediate deleteRechargeHistory;
execute immediate deleteRoamingCalls;
execute immediate deleteUsersessions;
execute immediate deleteRc;
execute immediate deleteNrc;
commit;
end;

*/