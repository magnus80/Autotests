-- ���������� ���������� USERSESSIONS
declare
ctn varchar2(100);					/* ����� �������� */
iterator number;					/* ������� ���������� ���������� */
amountTransactions number;			/* ���������� ���������� */
tablePrefixDwh varchar2(10);		/* ������� ������� */
start_core_balance int;				/* ��������� �������� ��������� ������� */
executeUsersessions varchar2(5000);	/* workTable */

begin
ctn:='9030372222';
amountTransactions:=15;
--tablePrefixDwh:='URL';
iterator:=1;
start_core_balance:=1000;

loop
/* start_core_balance:=start_core_balance-10;	-- �� ������ ������ */
executeUsersessions:='Insert into USERSESSIONS
   (NUMCHARGEID, CHRMSISDN, VCHAPN, DTMSTARTDATE, NUMVOLUME, NUMRATEDVOLUME, DTMSYSCREATIONDATE, BILLSYSTEM_CODE, SLICE)
 Values
   (564, '||ctn||', ''internet.beeline.ru'', sysdate-2+'||iterator||'/(24*60), 0 /*����� ����� �� ������*/, 1633280, sysdate-2+'||iterator||'/(24*60), 23, 7777400)';
execute immediate executeUsersessions;
iterator:=iterator+1;
exit when iterator>amountTransactions;
end loop;

commit;
end;