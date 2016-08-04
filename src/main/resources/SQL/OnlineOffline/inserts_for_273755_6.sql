declare
ctn varchar2(100);
iterator number; -- Счетчик
amountTransactions number; -- Количество транзакций

begin
ctn:='9030371112';
amountTransactions:=20;
iterator:=0;

loop

insert into roaming_calls (SUBSCRIBER_ID, CALL_DATE_TIME, CALL_DURATION, CALLED_NUMBER, TOTAL_CHARGE, NEW_BALANCE, OPERATION_DATE_TIME, COS, ROAMING_PARTNER, T_O, CALL_ID, SLICE, BILLSYSTEM_CODE, VOLUME, MEASURE)
values ('7'||ctn||'', sysdate, 199, 'CCBOtest', -13.7979, 0, sysdate, '', 'GABCT', '2V', 19428494, 121943360, 27, 0, 'SE');
iterator:=iterator+1;
exit when iterator>amountTransactions;

end loop;
commit;
end;
