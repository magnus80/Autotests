-- добавление транзакций CALL_HISTORY
declare
ctn varchar2(100);					/* номер абонента */
iterator number;					/* счетчик количества транзакций */
amountTransactions number;			/* количество транзакций */
tablePrefixDwh varchar2(10);		/* префикс таблицы */
start_core_balance int;				/* стартовое значение основного баланса */
executeCallHistory varchar2(5000);	/* workTable */

begin
ctn:='9030372222';
amountTransactions:=15;
tablePrefixDwh:='URL';
iterator:=1;
start_core_balance:=1000;

loop
start_core_balance:=start_core_balance-0; /* например, баланс не меняем, т.к. проверяем тех.детализацию */
executeCallHistory:='Insert into CALL_HISTORY_'||tablePrefixDwh||'
   (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
 Values
   ('||ctn||', sysdate-2+'||iterator||'/(24*60), ''79030000000'', 61, ''OUTGOING_OPPS_CALL'', 0, 16, 0, 0, ''79111123412'', 784048896812, 49030797, 23, ''79038889987'', ''250991770305226'', ''94'', ''RUR'', ''[1~'||start_core_balance||'~0~0]'', 108, 1)';
execute immediate executeCallHistory;
iterator:=iterator+1;
exit when iterator>amountTransactions;
end loop;

commit;
end;