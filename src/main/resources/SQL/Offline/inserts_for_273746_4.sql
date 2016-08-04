-- добавление транзакций PS_TRANSACTION
declare
ctn varchar2(100);						/* номер абонента */
iterator number;						/* счетчик количества транзакций */
amountTransactions number;				/* количество транзакций */
tablePrefixDwh varchar2(10);			/* префикс таблицы */
start_core_balance int;					/* стартовое значение основного баланса */
executePsTransaction varchar2(5000);	/* workTable */

begin
ctn:='9030372222';
amountTransactions:=15;
tablePrefixDwh:='URL';
iterator:=1;
start_core_balance:=1000;

loop
start_core_balance:=start_core_balance-0; /* например, баланс не меняем, т.к. проверяем тех.детализацию */
executePsTransaction:='Insert into PS_TRANSACTION_'||tablePrefixDwh||'
   (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, CONVERSION_RATE, REQUESTED_ISO_CODE, BALANCES_INFO, MSC_ID, SUBTYPE_ID, ORP_DATE, FUND_USAGE_TYPE, RECORD_SOURCE)
 Values
   ('||ctn||', sysdate-2+'||iterator||'/(24*60), ''1'', 4, ''79281111360'', 2650382349, 2562273291, ''N'', 287515636049, 6234594, 23, ''RUR'', 0, ''RUR'', ''[1~'||start_core_balance||'~0~0]'', ''79624959999'', 203, sysdate-2+'||iterator||'/(24*60), 1, 1)';
execute immediate executePsTransaction;
iterator:=iterator+1;
exit when iterator>amountTransactions;
end loop;

commit;
end;