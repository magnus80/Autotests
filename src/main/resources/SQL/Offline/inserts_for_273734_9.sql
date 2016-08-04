-- добавление транзакций NRC
declare
ctn varchar2(100);				/* номер абонента */
iterator number;				/* счетчик количества транзакций */
amountTransactions number;		/* количество транзакций */
tablePrefixDwh varchar2(10);	/* префикс таблицы */
start_core_balance int;			/* стартовое значение основного баланса */
executeNrc varchar2(5000);		/* workTable */

begin
ctn:='9030372222';
amountTransactions:=15;
tablePrefixDwh:='URL';
iterator:=1;
start_core_balance:=1000;

loop
start_core_balance:=start_core_balance-10;
executeNrc:='Insert into NRC_'||tablePrefixDwh||'
   (ID, NRC_COMMENT, CALL_ID, SLICE, NRC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, BALANCES_INFO)
 Values
   (0, ''PC_testNRC'', 287512311454, 6226097, sysdate-2+'||iterator||'/(24*60), 23, '||ctn||', ''RUR'', ''[1~'||start_core_balance||'~10~0]'')';
execute immediate executeNrc;
iterator:=iterator+1;
exit when iterator>amountTransactions;
end loop;

commit;
end;