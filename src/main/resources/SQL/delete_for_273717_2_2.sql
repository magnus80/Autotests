declare
ctn varchar2(100); 
deleteUsersessionsStmt varchar2(5000);
deleteAccumulatorStmt varchar2(5000);
begin
ctn:='9030371111'; -- ����� �������� �� ������� ����� ��������� ����������
deleteUsersessionsStmt:='DELETE USERSESSIONS where CHRMSISDN='||ctn;
deleteAccumulatorStmt:='DELETE ACCUMULATOR where CHRMSISDN='||ctn;
execute immediate deleteUsersessionsStmt;
execute immediate deleteAccumulatorStmt;
commit;
end;


