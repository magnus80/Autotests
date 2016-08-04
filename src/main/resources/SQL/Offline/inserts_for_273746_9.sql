-- ���������� ���������� RC
declare
ctn varchar2(100);				/* ����� �������� */
iterator number;				/* ������� ���������� ���������� */
amountTransactions number;		/* ���������� ���������� */
tablePrefixDwh varchar2(10);	/* ������� ������� */
start_core_balance int;			/* ��������� �������� ��������� ������� */
executeRc varchar2(5000);		/* workTable */

begin
ctn:='9030372222';
amountTransactions:=15;
tablePrefixDwh:='URL';
iterator:=1;
start_core_balance:=1000;

loop
start_core_balance:=start_core_balance-0; /* ��������, ������ �� ������, �.�. ��������� ���.����������� */
executeRc:='Insert into RC_'||tablePrefixDwh||'
   (ID, RC_COMMENT, RC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, BALANCES_INFO)
 Values
   (0, ''PC_EASY01_OR_PC'', sysdate-2+'||iterator||'/(24*60), 23, '||ctn||', ''RUR'', ''[1~'||start_core_balance||'~0~0]'')';
execute immediate executeRc;
iterator:=iterator+1;
exit when iterator>amountTransactions;
end loop;

commit;
end;