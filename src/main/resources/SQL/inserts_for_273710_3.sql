

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
Insert into USERSESSIONS
   (NUMCHARGEID, CHRMSISDN, VCHAPN, DTMSTARTDATE, NUMVOLUME, NUMRATEDVOLUME, DTMSYSCREATIONDATE, DTMSYSUPDATEDATE, BILLSYSTEM_CODE, SLICE)
 Values
   (564, ''||ctn||'', 'test', sysdate, 1024, 1633280, sysdate, NULL, 28, 7777400);
iterator:=iterator+1;
end loop;
commit;
end;

