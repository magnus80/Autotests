
declare
ctn varchar2(100);
iterator number; -- Счетчик
amountTransactions number; -- Количество транзакций
begin
ctn:='9030371111';
amountTransactions:=10;
iterator:=0;
loop
exit when iterator>amountTransactions;
Insert into ACCUMULATOR
   (CHRMSISDN, NUMID, DTMSYSCREATIONDATE, DTMNOTIFYDATE, BILLSYSTEM_CODE, SLICE, SMS_TYPE)
 Values
   (''||ctn||'', 905426593, sysdate, sysdate, 23, NULL, 'CCBOtest');
iterator:=iterator+1;
end loop;
commit;
end;

