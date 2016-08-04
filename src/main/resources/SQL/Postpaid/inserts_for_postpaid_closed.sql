-- Detalisation postpaid, closed cycle (ODSAMD)
declare
TYPE feature_code IS TABLE OF VARCHAR2(30);	-- Расшифровки поля Сервис
feature_desc feature_code;					-- Расшифровки поля Сервис
TYPE oum IS TABLE OF VARCHAR2(2);			-- Oum, Объем услуг
oumEnv oum;									-- Oum, Объем услуг
TYPE balance IS TABLE OF VARCHAR2(30);		-- Баланс до и после
balanceEnv balance;							-- Баланс до и после
randomEnv int;								-- randomEnv поле CALL_ACTION_CODE
	/* условия для randomEnv:
	1. Если поле callActionCode='1', то отображаем значение поля ctn (поле SUBSCRIBER_NO).
	2. Иначе отображаем значение поля msisdn (поле CALL_TO_TN).
	*/
randomCtn int;								-- случайный номер
randomDur int;								-- случайная продолжительность
providerId varchar2(100);					-- Поле комментарий (отображается провайдер)

ctn varchar2(100);							-- номер абонента
iterator number;							-- счетчик количества транзакций
amountTransactions number;					-- количество транзакций

begin
ctn:='9060000000';
amountTransactions:=20;
iterator:=1;
feature_desc:=feature_code('00','00CC0','00    ','UVRP01','UVRP15','SS65','BP9ST3','PP13','VOICE','VMN_S9','SV025M','UVRPPO', '', 'PRT010', 'USO   ');
	/*Расшифровки
	Feature_code	Feature_desc
	00				null
	00CC0			null
	00				null + 4 пробела
	UVRP01			Билайн Центр  
	UVRP15			Билайн Резерв5
	SS65			SS for NW_ROAM
	BP9ST3			BP9 for NWSTAZH3
	PP13			COS for 12PFDF5
	VOICE			Голосовой канал
	VMN_S9			"В" английский, мужчина
	SV025M			исх/доп.сервис
	UVRPPO			Исходящий звонок
	PRT010			Premium Rate MT SMS $0.10
	USO   			Исходящее SMS на "Билайн"                                                                           
	*/

oumEnv:=oum('SE','EV','SE','MB' ); -- значения выдергиваются при помощи randomEnv
	/* Значение  uom 
	для поля Объем услуг:
	1. Если поле uom равно 'SE', то отображаем значение поля callDuration преобразованного из секунд в формат ЧЧ:ММ:СС
	2. Если поле uom равно 'EV', то ничего не отображаем.
	3. Если предыдущие условия не выполнились, то отображаем значение поля traffic.
	Для поля Длит.сессии:
	1.	Если поле uom равно 'SE' и поле billedTraffic не пустое, то отображаем значение, преобразованное в формат '#.##', взятое из поля billedTraffic и умноженное на 60.
	2.	Если поле uom равно 'MB' и поле billedTraffic не пустое, то отображаем значение поля billedTraffic преобразованного из секунд в формат ЧЧ:ММ:СС
	3.	Если предыдущие условия не выполнились, то отображаем значение ‘0’
	*/

balanceEnv:=balance('D','D','D','D','P','P','P','P','P','P','P','P','P','E','E');	
	/*1. Баланс ДО и После, Если поле баланса unitTypeName = 'D'  или unitTypeName = 'P', то ничего не отображаем.
	Валюта/ед.изм.  1. Если поле баланса unitTypeName = 'D'  или unitTypeName = 'P', то отображаем значение, сформированное по следующему правилу: 
	1.1.     Если поле баланса unitTypeName = 'D', пишем фразу 'USD'
	1.2.     Если поле баланса unitTypeName = 'P', пишем фразу 'RUR'
	2.    Если предыдущие условия не выполнились, то получаем из справочника CCBO_UNIT_TYPE значение поля unitType для данного баланса и отображаем его.
	*/	

loop -- цикл выполняется, пока не достигнет значения, заданного в amountTransactions

for i in 1..feature_desc.count loop
select provider_id into providerId from (select * from ODSCMV.ROAMING_AGREEMENT c order by DBMS_RANDOM.value()) where rownum=1; --Берется случайное значение из поля provider_id
randomEnv:=dbms_random.VALUE(1,4);						-- Случайное число от мин до макс
randomCtn:=dbms_random.VALUE(79030000000,79039999999);	-- Случайные номера
randomDur:=dbms_random.VALUE(10,120);					-- Случайное число от мин до макс
Insert into USAGES
   (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE,
   CALL_ACTION_CODE, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, CALL_TO_TN,
   CALLING_NO, SERVICE_FEATURE_CODE, DATA_VOLUME, AC_AMT, CELL_ID,
   PROVIDER_ID, UOM, NEW_BALANCE, SLICE, IMEI,
   IMSI, CUR_IND)
 Values
   (ctn, sysdate-40+(iterator/24/60), '14500', 'RTIER', feature_desc(i),
   randomEnv, randomDur, (randomDur-5), (randomDur-10)/*баланс*/, (randomCtn-1),
   randomCtn, 'U_LCV ', NULL, NULL, 'UOM:'||oumEnv(randomEnv)/*В Тип операции/Оператор вывожу значение UOM для удобства, от этого поля многое зависит*/,
   providerId, oumEnv(randomEnv), NULL, 6234666, '111111111111111',
   '250990000000217', balanceEnv(i));
iterator:=iterator+1;
exit when iterator>amountTransactions;
end loop;

exit when iterator>amountTransactions;
end loop;

commit;
end;


/*
select * from odscmv.ROAMING_AGREEMENT c
select * from ODSAMD.COPY_FEATURE where feature_desc like '%SMS%'

select c.*,c.rowid from usages c where subscriber_no ='9030334239'
and channel_seizure_dt between sysdate-30 and sysdate
order by channel_seizure_dt desc


select count(*) from usages where subscriber_no ='9030334239'
and channel_seizure_dt between sysdate-30 and sysdate
*/