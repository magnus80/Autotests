declare
ctn varchar2(100); 
deleteRoamingCallsStmt varchar2(5000);
deleteUsersessionsStmt varchar2(5000);
begin
ctn:='9030371111'; -- ����� �������� �� ������� ����� ��������� ����������
deleteRoamingCallsStmt:='DELETE roaming_calls where SUBSCRIBER_ID=7'||ctn;
deleteUsersessionsStmt:='DELETE USERSESSIONS where CHRMSISDN='||ctn;
execute immediate deleteRoamingCallsStmt;
execute immediate deleteUsersessionsStmt;
commit;
end;



