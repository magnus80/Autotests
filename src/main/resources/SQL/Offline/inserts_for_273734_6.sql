-- ���������� ���������� ROAMING_CALLS
declare
ctn varchar2(100);					/* ����� �������� */
iterator number;					/* ������� ���������� ���������� */
amountTransactions number;			/* ���������� ���������� */
tablePrefixDwh varchar2(10);		/* ������� ������� */
start_core_balance int;				/* ��������� �������� ��������� ������� */
executeRoamingCalls varchar2(5000);	/* workTable */

begin
ctn:='9030372222';
amountTransactions:=15;
--tablePrefixDwh:='URL';
iterator:=1;
start_core_balance:=1000;

loop
start_core_balance:=start_core_balance-10;
executeRoamingCalls:='Insert into ROAMING_CALLS
   (SUBSCRIBER_ID, CALL_DATE_TIME, CALL_DURATION, CALLED_NUMBER, TOTAL_CHARGE, NEW_BALANCE, OPERATION_DATE_TIME, ROAMING_PARTNER, T_O, CALL_ID, SLICE, BILLSYSTEM_CODE, VOLUME, MEASURE)
 Values
   ('||ctn||', sysdate-2+'||iterator||'/(24*60), 199, ''79603578862'', -10, '||start_core_balance||', sysdate-2+'||iterator||'/(24*60), ''GABCT'', ''2V'', 19428494, 121943360, 23, 0, ''SE'')';
execute immediate executeRoamingCalls;
iterator:=iterator+1;
exit when iterator>amountTransactions;
end loop;

commit;
end;