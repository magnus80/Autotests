declare
ctn varchar2(100); 
deleteCallexStmt varchar2(5000);
deleteSoftelStmt varchar2(5000);
record_id_text  varchar2(5000);
Nj int;
i int;
begin
ctn:='9030371111';
i:=0;
record_id_text:='Tsivilev_test';

select count(record_id) into Nj from callex where a164_num=ctn;

WHILE (i < Nj) LOOP
i:=i+1;
deleteCallexStmt:='DELETE CALLEX where record_id='''||record_id_text||i||'''';
deleteSoftelStmt:='DELETE SOFTEL where record_id='''||record_id_text||i||'''';
execute immediate deleteCallexStmt;
execute immediate deleteSoftelStmt;
end loop;

commit;
end;