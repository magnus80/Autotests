-- добавление транзакций ACCUMULATOR
declare
ctn varchar2(100);					/* номер абонента */
iterator number;					/* счетчик количества транзакций */
amountTransactions number;			/* количество транзакций */
tablePrefixDwh varchar2(10);		/* префикс таблицы */
start_core_balance int;				/* стартовое значение основного баланса */
executeAccumulator varchar2(5000);	/* workTable */

begin
ctn:='9030372222';
amountTransactions:=15;
--tablePrefixDwh:='URL';
iterator:=1;
--start_core_balance:=1000;

loop
--start_core_balance:=start_core_balance-0; -- изменять баланс не нужно
executeAccumulator:='Insert into ACCUMULATOR
   (CHRMSISDN, NUMID, DTMSYSCREATIONDATE, DTMNOTIFYDATE, BILLSYSTEM_CODE, SMS_TYPE)
 Values
   ('||ctn||', 905426593, sysdate-2+'||iterator||'/(24*60), sysdate-2+'||iterator||'/(24*60), 23, ''pink+30'')';
execute immediate executeAccumulator;
iterator:=iterator+1;
exit when iterator>amountTransactions;
end loop;

commit;
end;