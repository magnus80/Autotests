-- Detalisation postpaid, closed cycle (ODSAMD)
declare
TYPE feature_code IS TABLE OF VARCHAR2(30);	-- ����������� ���� ������
feature_desc feature_code;					-- ����������� ���� ������
TYPE oum IS TABLE OF VARCHAR2(2);			-- Oum, ����� �����
oumEnv oum;									-- Oum, ����� �����
TYPE balance IS TABLE OF VARCHAR2(30);		-- ������ �� � �����
balanceEnv balance;							-- ������ �� � �����
randomEnv int;								-- randomEnv ���� CALL_ACTION_CODE
	/* ������� ��� randomEnv:
	1. ���� ���� callActionCode='1', �� ���������� �������� ���� ctn (���� SUBSCRIBER_NO).
	2. ����� ���������� �������� ���� msisdn (���� CALL_TO_TN).
	*/
randomCtn int;								-- ��������� �����
randomDur int;								-- ��������� �����������������
providerId varchar2(100);					-- ���� ����������� (������������ ���������)

ctn varchar2(100);							-- ����� ��������
iterator number;							-- ������� ���������� ����������
amountTransactions number;					-- ���������� ����������

begin
ctn:='9060000000';
amountTransactions:=20;
iterator:=1;
feature_desc:=feature_code('00','00CC0','00    ','UVRP01','UVRP15','SS65','BP9ST3','PP13','VOICE','VMN_S9','SV025M','UVRPPO', '', 'PRT010', 'USO   ');
	/*�����������
	Feature_code	Feature_desc
	00				null
	00CC0			null
	00				null + 4 �������
	UVRP01			������ �����  
	UVRP15			������ ������5
	SS65			SS for NW_ROAM
	BP9ST3			BP9 for NWSTAZH3
	PP13			COS for 12PFDF5
	VOICE			��������� �����
	VMN_S9			"�" ����������, �������
	SV025M			���/���.������
	UVRPPO			��������� ������
	PRT010			Premium Rate MT SMS $0.10
	USO   			��������� SMS �� "������"                                                                           
	*/

oumEnv:=oum('SE','EV','SE','MB' ); -- �������� ������������� ��� ������ randomEnv
	/* ��������  uom 
	��� ���� ����� �����:
	1. ���� ���� uom ����� 'SE', �� ���������� �������� ���� callDuration ���������������� �� ������ � ������ ��:��:��
	2. ���� ���� uom ����� 'EV', �� ������ �� ����������.
	3. ���� ���������� ������� �� �����������, �� ���������� �������� ���� traffic.
	��� ���� ����.������:
	1.	���� ���� uom ����� 'SE' � ���� billedTraffic �� ������, �� ���������� ��������, ��������������� � ������ '#.##', ������ �� ���� billedTraffic � ���������� �� 60.
	2.	���� ���� uom ����� 'MB' � ���� billedTraffic �� ������, �� ���������� �������� ���� billedTraffic ���������������� �� ������ � ������ ��:��:��
	3.	���� ���������� ������� �� �����������, �� ���������� �������� �0�
	*/

balanceEnv:=balance('D','D','D','D','P','P','P','P','P','P','P','P','P','E','E');	
	/*1. ������ �� � �����, ���� ���� ������� unitTypeName = 'D'  ��� unitTypeName = 'P', �� ������ �� ����������.
	������/��.���.  1. ���� ���� ������� unitTypeName = 'D'  ��� unitTypeName = 'P', �� ���������� ��������, �������������� �� ���������� �������: 
	1.1.     ���� ���� ������� unitTypeName = 'D', ����� ����� 'USD'
	1.2.     ���� ���� ������� unitTypeName = 'P', ����� ����� 'RUR'
	2.    ���� ���������� ������� �� �����������, �� �������� �� ����������� CCBO_UNIT_TYPE �������� ���� unitType ��� ������� ������� � ���������� ���.
	*/	

loop -- ���� �����������, ���� �� ��������� ��������, ��������� � amountTransactions

for i in 1..feature_desc.count loop
select provider_id into providerId from (select * from ODSCMV.ROAMING_AGREEMENT c order by DBMS_RANDOM.value()) where rownum=1; --������� ��������� �������� �� ���� provider_id
randomEnv:=dbms_random.VALUE(1,4);						-- ��������� ����� �� ��� �� ����
randomCtn:=dbms_random.VALUE(79030000000,79039999999);	-- ��������� ������
randomDur:=dbms_random.VALUE(10,120);					-- ��������� ����� �� ��� �� ����
Insert into USAGES
   (SUBSCRIBER_NO, CHANNEL_SEIZURE_DT, MESSAGE_SWITCH_ID, AT_SOC, AT_FEATURE_CODE,
   CALL_ACTION_CODE, AT_CALL_DUR_SEC, AT_NUM_MINS_TO_RATE, AT_CHARGE_AMT, CALL_TO_TN,
   CALLING_NO, SERVICE_FEATURE_CODE, DATA_VOLUME, AC_AMT, CELL_ID,
   PROVIDER_ID, UOM, NEW_BALANCE, SLICE, IMEI,
   IMSI, CUR_IND)
 Values
   (ctn, sysdate-40+(iterator/24/60), '14500', 'RTIER', feature_desc(i),
   randomEnv, randomDur, (randomDur-5), (randomDur-10)/*������*/, (randomCtn-1),
   randomCtn, 'U_LCV ', NULL, NULL, 'UOM:'||oumEnv(randomEnv)/*� ��� ��������/�������� ������ �������� UOM ��� ��������, �� ����� ���� ������ �������*/,
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