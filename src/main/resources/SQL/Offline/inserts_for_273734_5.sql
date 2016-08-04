-- добавление транзакций RECHARGE_HISTORY
declare
ctn varchar2(100);						/* номер абонента */
iterator number;						/* счетчик количества транзакций */
amountTransactions number;				/* количество транзакций */
tablePrefixDwh varchar2(10);			/* префикс таблицы */
start_core_balance int;					/* стартовое значение основного баланса */
executeReachargeHistory varchar2(5000);	/* workTable */

begin
ctn:='9030372222';
amountTransactions:=15;
tablePrefixDwh:='URL';
iterator:=1;
start_core_balance:=1000;

loop
start_core_balance:=start_core_balance+10;
executeReachargeHistory:='Insert into RECHARGE_HISTORY_'||tablePrefixDwh||'
   (SUBSCRIBER_ID, RECHARGE_DATE_TIME, CARD_NUMBER, RECHARGE_AMOUNT, EXPIRATION_OFFSET, NEW_BALANCE, VOUCHER_TYPE, BALANCE_TYPE, SERIAL_NUMBER, RECHARGE_COMMENT, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, FACE_VALUE, BALANCES_INFO, IDENTITY_ID)
 Values
   ('||ctn||', sysdate-2+'||iterator||'/(24*60), ''non voucher'', 61, 0, 0, 0, 0, 12070368844, ''XPB,.E012070368844'', 279918750002, 6169982, 23, ''RUR'', 10, ''[1~'||start_core_balance||'~10~0]'', 1)';
execute immediate executeReachargeHistory;
iterator:=iterator+1;
exit when iterator>amountTransactions;
end loop;

commit;
end;