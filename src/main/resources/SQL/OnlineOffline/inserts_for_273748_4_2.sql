declare
ctn varchar2(100);
iterator number; -- Счетчик
amountTransactions number; -- Количество транзакций
tablePrefixDwh varchar2(10);
--workTables
executePsTransaction varchar2(5000);

begin
ctn:='9030371112';
amountTransactions:=6;
tablePrefixDwh:='URL';
iterator:=0;

loop

--PS_TRANSACTION
executePsTransaction:='Insert into PS_TRANSACTION_'||tablePrefixDwh||'
   (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, REFUND_ID_1, REFUND_ID_2, CALL_ID, SLICE, BILLSYSTEM_CODE, TYPE_OF_CHARGE, ISO_CODE, BALANCES_INFO, IDENTITY_ID, SUBTYPE_ID, ORP_DATE,MSC_ID,charge_code)
 Values
   ('||ctn||', sysdate-7+'||iterator||'/(24*60), ''1'', ''4'', ''79030372222'', 833973252, 3256868758, ''Y'', 0, 0, 379918750951, 6170003, 28, ''1234'', ''RUR'', ''[1~100~10~0]'', 1, 4020, sysdate-7+'||iterator||'/(24*60),''1234'',1426)';
execute immediate executePsTransaction;
iterator:=iterator+1;
exit when iterator>amountTransactions;


end loop;
commit;
end;
