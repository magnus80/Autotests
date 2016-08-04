-- inserts for filters, postpaid, closed cycle (ODSAMD)
declare
ctn varchar2(100);							-- номер абонента
iterator number;							-- счетчик количества транзакций
amountTransactions number;					-- количество транзакций
randomCtn int;								-- случайный номер абонента

begin
ctn:='9060000000';
amountTransactions:=12; 					-- 13 транзакций за один цикл
iterator:=0;

loop
randomCtn:=dbms_random.VALUE(9030000000,9039999999);

-- Сессии и списания GPRS - Сессии и списания GPRS
Insert into ODSAMD.USAGES (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE, CALL_ACTION_CODE, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, CALLING_NO, SERVICE_FEATURE_CODE, DATA_VOLUME, PROVIDER_ID, UOM, SLICE, IMSI, CUR_IND)
Values (ctn, sysdate-40+(iterator/24/60), '14500', 'RVIPDEF  ', 'GPRS  ', '1', 15, 6, -3.54, randomCtn, 'GPRS  ', 1024, '25002   ', 'SE', 6235048, '250990000005661 ', 'P');
iterator:=iterator+1;
exit when iterator>amountTransactions;
Insert into ODSAMD.USAGES (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE, CALL_ACTION_CODE, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, CALLING_NO, SERVICE_FEATURE_CODE, DATA_VOLUME, PROVIDER_ID, UOM, SLICE, IMSI, CUR_IND)
Values (ctn, sysdate-40+(iterator/24/60), '14500', 'RVIPDEF  ', 'UWLID ', '1', 15, 6, -3.54, randomCtn, 'UWLID ', 1024, '25002   ', 'SE', 6235048, '250990000005661 ', 'P');
iterator:=iterator+1;
exit when iterator>amountTransactions;
Insert into ODSAMD.USAGES (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE, CALL_ACTION_CODE, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, CALLING_NO, SERVICE_FEATURE_CODE, DATA_VOLUME, PROVIDER_ID, UOM, SLICE, IMSI, CUR_IND)
Values (ctn, sysdate-40+(iterator/24/60), '14500', 'RVIPDEF  ', '09GPP0', '1', 15, 6, -3.54, randomCtn, '09GPP0', 1024, '25002   ', 'SE', 6235048, '250990000005661 ', 'P');
iterator:=iterator+1;
exit when iterator>amountTransactions;
-- Сессии и списания GPRS - Сессии и списания GPRS-Internet
Insert into ODSAMD.USAGES (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE, CALL_ACTION_CODE, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, CALL_TO_TN, CALLING_NO, SERVICE_FEATURE_CODE, CELL_ID, PROVIDER_ID, UOM, SLICE, IMEI, IMSI, CUR_IND)
Values (ctn, sysdate-40+(iterator/24/60), '14500', 'RTIER    ', 'GPRSI ', '2', 600, 10, 1998.94, randomCtn, '9030330217           ', 'GPRSI ', '000513', '53001   ', 'SE', 6235048, '111111111111111', '250990000000217 ', 'P');
iterator:=iterator+1;
exit when iterator>amountTransactions;
-- Сессии и списания GPRS - Сессии и списания GPRS_WAP
Insert into ODSAMD.USAGES (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE, CALL_ACTION_CODE, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, CALL_TO_TN, CALLING_NO, SERVICE_FEATURE_CODE, CELL_ID, PROVIDER_ID, UOM, SLICE, IMEI, IMSI, CUR_IND)
Values (ctn, sysdate-40+(iterator/24/60), '14500', 'RTIER    ', 'GPRSW ', '2', 0, 0, 1, randomCtn, '9030330217           ', 'GPRSW ', '000513', '2502035 ', 'SE', 6235048, '111111111111111', '250990000000217 ', 'P');
iterator:=iterator+1;
exit when iterator>amountTransactions;

-- Тип записи - Роуминг
Insert into ODSAMD.USAGES (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE, CALL_ACTION_CODE, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, CALL_TO_TN, CALLING_NO, SERVICE_FEATURE_CODE, CELL_ID, PROVIDER_ID, UOM, SLICE, IMEI, IMSI, CUR_IND)
Values (ctn, sysdate-40+(iterator/24/60), '14500', 'RTIER    ', 'UVRVO ', '2', 600, 10, 14.4, randomCtn, '9030330217           ', 'UVRVO ', '000513', '62501   ', 'SE', 6235048, '111111111111111', '250990000000217 ', 'P');
iterator:=iterator+1;
exit when iterator>amountTransactions;
Insert into ODSAMD.USAGES (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE, CALL_ACTION_CODE, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, CALL_TO_TN, CALLING_NO, SERVICE_FEATURE_CODE, CELL_ID, PROVIDER_ID, UOM, SLICE, IMEI, IMSI, CUR_IND)
Values (ctn, sysdate-40+(iterator/24/60), '14500', 'RTIER    ', 'ROAMN ', '2', 600, 10, 14.4, randomCtn, '9030330217           ', 'ROAMN ', '000513', '99999   ', 'SE', 6235048, '111111111111111', '250990000000217 ', 'P');
iterator:=iterator+1;
exit when iterator>amountTransactions;
Insert into ODSAMD.USAGES (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE, CALL_ACTION_CODE, AT_CHARGE_AMT, CALLING_NO, SERVICE_FEATURE_CODE, PROVIDER_ID, UOM, SLICE, IMSI, CUR_IND)
Values (ctn, sysdate-40+(iterator/24/60), '78129600203', 'RVIPDEF  ', 'U_R_LD', '1', 1234.01, randomCtn, 'U_R_LD', '25002   ', 'EV', 6235048, '250990000005661 ', 'P');
iterator:=iterator+1;
exit when iterator>amountTransactions;
Insert into ODSAMD.USAGES (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE, CALL_ACTION_CODE, AT_CHARGE_AMT, CALLING_NO, SERVICE_FEATURE_CODE, PROVIDER_ID, UOM, SLICE, IMSI, CUR_IND)
Values (ctn, sysdate-40+(iterator/24/60), '78129600203', 'RVIPDEF  ', 'U_R_IN', '1', 10.5, randomCtn, 'U_R_IN', '27404   ', 'EV', 6235048, '250990000005661 ', 'P');
iterator:=iterator+1;
exit when iterator>amountTransactions;
Insert into ODSAMD.USAGES (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE, CALL_ACTION_CODE, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, CALLING_NO, SERVICE_FEATURE_CODE, DATA_VOLUME, PROVIDER_ID, UOM, SLICE, IMSI, CUR_IND)
Values (ctn, sysdate-40+(iterator/24/60), '14500', 'RVIPDEF  ', 'PCHGO4', '1', 15, 6, 3.5, randomCtn, 'PCHGO4', 1024, '27404   ', 'SE', 6235059, '250990000005661 ', 'P');
iterator:=iterator+1;
exit when iterator>amountTransactions;

-- Тип записи - CPA-подписки
Insert into ODSAMD.USAGES (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE, CALL_ACTION_CODE, AT_CHARGE_AMT, CALLING_NO, SERVICE_FEATURE_CODE, PROVIDER_ID, UOM, SLICE, IMSI, CUR_IND)
Values (ctn, sysdate-40+(iterator/24/60), '78129600203', 'RVIPDEF  ', 'PRO001', '1', 0.5, randomCtn, 'PRO001', '25002   ', 'EV', 6235059, '250990000005661 ', 'P');
iterator:=iterator+1;
exit when iterator>amountTransactions;
Insert into ODSAMD.USAGES (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE, CALL_ACTION_CODE, AT_CHARGE_AMT, CALLING_NO, SERVICE_FEATURE_CODE, PROVIDER_ID, UOM, SLICE, IMSI, CUR_IND)
Values (ctn, sysdate-40+(iterator/24/60), '78129600203', 'RVIPDEF  ', 'PRO009', '1', 0.09, randomCtn, 'PRO009', '25002   ', 'EV', 6235059, '250990000005661 ', 'D');
iterator:=iterator+1;
exit when iterator>amountTransactions;
Insert into ODSAMD.USAGES (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE, CALL_ACTION_CODE, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, CALL_TO_TN, CALLING_NO, SERVICE_FEATURE_CODE, CELL_ID, PROVIDER_ID, UOM, SLICE, IMEI, IMSI, CUR_IND)
Values (ctn, sysdate-40+(iterator/24/60), '14500', 'RTIER    ', 'PRO010', '2', 600, 15, 0.1, randomCtn, '9030330217           ', 'PRO010', '000513', '25099   ', 'SE', 6234518, '111111111111111', '250990000000217 ', 'D');
iterator:=iterator+1;
exit when iterator>amountTransactions;

-- Роуминг, транзакции и списания (те же, что и "Тип записи - Роуминг")

end loop;

commit;
end;