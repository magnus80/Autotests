--Callex
declare
ctn varchar2(11);
call_type varchar2(1);
C_NUMBE_TYPE varchar2(1);
CALL_STATUS varchar2(1);
TYPE service_tab IS TABLE OF VARCHAR2(30);
service_names service_tab;
TYPE clear_code_tab IS TABLE OF VARCHAR2(30);
clear_code_names clear_code_tab;
timeVar number;
amountTransactions number;
begin
ctn :='9030371111';
C_NUMBE_TYPE:='T';
call_type:='O';
CALL_STATUS:='1';
timeVar:=1;
service_names  := service_tab('V','F','R');
clear_code_names :=clear_code_tab('B017','B018','B019','B020','B021','A13''');
amountTransactions:=1;
loop
exit when amountTransactions>2; -- за один проход 18 транзакций всех типов

for i in 1..service_names.COUNT loop
for j in 1..clear_code_names.COUNT loop
        Insert into CALLEX
                (RECORD_ID, DATETIME, A164_NUM, E164_NUM, CALL_TYPE, CALL_STATUS, DURATION, SERVICE, CLEAR_CODE, C_NUMBE_TYPE, USERID, SLICE)
        Values
                ('Tsivilev_test'||timeVar, sysdate-10+(timeVar/(24*60)), ctn, '11111111', call_type, 
                CALL_STATUS, 26, service_names(i), clear_code_names(j), C_NUMBE_TYPE, 
                'Tsivilev@sip.beeline.ru', 6234369);
        Insert into SOFTEL
                (RECORD_ID, DATETIME, CHARGE, CURRENCY, SLICE)
        Values
                ('Tsivilev_test'||timeVar,sysdate-10+(timeVar/(24*60)) , 10, 'RUR', 1);

        timeVar:=timeVar+1;
                
end loop;
    
end loop;
amountTransactions:=amountTransactions+1;
end loop;

end;

