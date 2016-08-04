declare
ctn varchar2(100);
iterator number; -- счетчик
amountTransactions number; -- количество транзакций
begin
ctn:='9030371111';
amountTransactions:=2;
iterator:=0;
loop
Insert into ROAMING_CALLS (SUBSCRIBER_ID, CALL_DATE_TIME, CALL_DURATION, CALLED_NUMBER, TOTAL_CHARGE, NEW_BALANCE, OPERATION_DATE_TIME, COS, ROAMING_PARTNER, T_O, CALL_ID, SLICE, BILLSYSTEM_CODE, VOLUME, MEASURE)
Values ('7'||ctn||'', sysdate, 199, 'CCBOtest', -13.7979, 0, sysdate, '', 'GABCT', '2V', 19428494, 121943360, 27, 0, 'SE');
iterator:=iterator+1;
exit when iterator>amountTransactions;

Insert into ACCUMULATOR (CHRMSISDN, NUMID, DTMSYSCREATIONDATE, DTMNOTIFYDATE, BILLSYSTEM_CODE, SLICE, SMS_TYPE)
Values (''||ctn||'', 905426593, sysdate, sysdate, 23, NULL, 'CCBOtest');
iterator:=iterator+1;
exit when iterator>amountTransactions;
end loop;
commit;
end;

