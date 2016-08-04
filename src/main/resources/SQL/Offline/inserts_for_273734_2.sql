-- добавление транзакций MTR
declare
ctn varchar2(100);				/* номер абонента */
iterator number;				/* счетчик количества транзакций */
amountTransactions number;		/* количество транзакций */
tablePrefixDwh varchar2(10);	/* префикс таблицы */
start_core_balance int;			/* стартовое значение основного баланса */
executeMtr varchar2(5000);		/* workTable */

begin
ctn:='9030372222';
amountTransactions:=15;
tablePrefixDwh:='URL';
iterator:=1;
start_core_balance:=1000;

loop
start_core_balance:=start_core_balance-10;
executeMtr:='Insert into MTR_'||tablePrefixDwh||'
   (ID, LOGIN_NAME, BALANCE_TYPE, MTR_COMMENT, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO, IDENTITY_ID)
 Values
   (0, ''SWITCHCONTROL'', 0, ''AUTO_TESTER'', 277665337522, 6167025, sysdate-2+'||iterator||'/(24*60), 23, '||ctn||', ''RUR'', 1555, ''[1~'||start_core_balance||'~10~0]'', 1)';
execute immediate executeMtr;
iterator:=iterator+1;
exit when iterator>amountTransactions;
end loop;

commit;
end;