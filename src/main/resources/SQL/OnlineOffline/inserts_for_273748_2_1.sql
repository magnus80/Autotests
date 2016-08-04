declare
ctn varchar2(100); 
subscr_no varchar2(100);
account_no varchar2(100);
executeMtrStmt varchar2(5000);
mtr_id number;
MtrTablePrefix_AB varchar2(100); 
iterator number;
exitStmt number;

begin
ctn:='79030371112';
exitStmt:=6;
select subscr_no into subscr_no from account_subscriber where range_map_external_id=ctn;
select account_no into account_no from account_subscriber where range_map_external_id=ctn;
select table_ab  into MtrTablePrefix_AB from INSERT_CONTROL  where table_name='MTR' and  active_set='Y';

execute immediate 'select max(mtr_id) from mtr_main_'||MtrTablePrefix_AB||'' into mtr_id; -- Для mtr есть констрейнт на это поле, должно быть уникально
mtr_id:=NVL(mtr_id,1); -- если запись первая, то id =1 ;
mtr_id:=mtr_id+1;

iterator:=0;
loop
--MTR
executeMtrStmt:='INSERT INTO MTR_MAIN_'||MtrTablePrefix_AB||'(subscr_no,subscr_no_resets,account_no,owning_account_no,mtr_id2,mtr_id,mtr_type,mtr_sub_type,
mtr_comment,mod_date,login_name,mtr_source,extract_file_id,subscriber_currency,reseller_id,bal_info,accu_info,offer_info,
mog_id,group_account_type,fund_usage_type,pcl_flag,ple_flag) 
VALUES ('||subscr_no||',0,'||account_no||',0,150,'||mtr_id||',14,1,''CCBOtest'',sysdate+('||iterator||'/24/60),
''sapiuser'',3,2,''RUR'',0,
''[1~150.0~10~~0~1][2~0.0~0.0~~0~1][3~0~0~0001-01-01 00:00:00~0~1][4~20.0~0.0~~0~1][5~0.0~0.0~2023-10-22 00:00:00~0~1][6~0.0~0.0~2023-10-22 00:00:00~0~1][7~0.0~0.0~~0~1][8~0.0~0.0~~0~1][9~0.0~0.0~~0~1][10~0.0~0.0~2023-10-22 00:00:00~0~1][11~0.0~0.0~~0~1][12~0.0~0.0~~0~1][13~0.0~0.0~~0~1][14~0.0~0.0~~0~1][15~0.0~0.0~~0~1][17~0.0~0.0~~0~1][16~0.0~0.0~~0~1][19~600.0~0.0~2014-11-05 00:00:00~0~1][18~0.0~0.0~2033-12-16 00:00:00~0~1][20~0.0~0.0~~0~1]'',
''[4~0.0~0.0][8~145.0~0.0][10~0.0~0.0][12~0.0~0.0][14~0.0~0.0][17~0.0~0.0][21~0.0~0.0][22~0.0~0.0][23~0.0~0.0][27~0.0~0.0][29~0.0~0.0][57~0.0~0.0][58~1612.38~0.0][72~0.0~0.0][105~0.0~0.0][106~0.0~0.0][112~0.0~0.0]'',
''[216]'',1,6,1,0,0)';
mtr_id:=mtr_id+1;
iterator:=iterator+1;
exit when iterator>exitStmt;
execute immediate executeMtrStmt;

end loop;
commit;
end;
