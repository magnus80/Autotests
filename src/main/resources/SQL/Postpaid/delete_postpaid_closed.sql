-- delete postpaid, closed cycle (ODSAMD)
declare
ctn varchar2(100);							-- ����� ��������
deleteUsages varchar2(5000);				-- workTable

begin
ctn:='9060000000';

deleteUsages:='DELETE FROM USAGES where SUBSCRIBER_NO='''||ctn||''' and channel_seizure_dt between sysdate-60 and sysdate';
execute immediate deleteUsages;

commit;
end;