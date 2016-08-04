declare
ctn int;					/* номер абонента */
billsys_code int;			/* биллинг код системы (необязательный параметр) */
trn_date date;				/* установка времени для транзакций */
Nsec int;					/* время в секундах, через которое выполняются транзакции */
time int;
rounds int;					/* количество повторов всех транзакций */
start_core_balance int;		/* стартовое значение основного баланса */
start_sms_balance int;		/* стартовое значение баланса SMS */

begin
ctn:='9030372222';
billsys_code:=23;
time:=0;
trn_date:=trunc(sysdate)-7; /* время начала транзакции, где (trunc(sysdate)+(1/1440) - это 00:01:00 sysdate */
Nsec:=5;	/* время в секундах, через которое совершаются транзакции */
rounds:=0;
start_core_balance:=990;
start_sms_balance:=19;

	LOOP
	EXIT when rounds=1;  /* цикл, количество повторов всех транзакций */

/* Транзакции для операций CALL_HISTORY */
	time:=time+1;
	Insert into ODSCMV.CALL_HISTORY_URL (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), '79053200000', 61, 'OutgoingCall', 0, 16, 0, 0, '79111123412', 784048896812, 49030797, billsys_code, '79038889987', 'null', '94', 'RUR', '[1~'||start_core_balance||'~10~0]', 108, 1);
	time:=time+1;
	start_core_balance:=start_core_balance+10;
	Insert into ODSCMV.CALL_HISTORY_URL (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), '79153200000', 3661, 'OutgoingCall', 0, 16, 0, 0, '79111123412', 784048896812, 49030797, billsys_code, '79038889987', 'null', '94', 'RUR', '[1~'||start_core_balance||'~-10~0]', 108, 1);
	time:=time+1;
	start_core_balance:=start_core_balance-10; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.CALL_HISTORY_URL (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), '79271140000', 11, 'OutgoingCall', 0, 16, 0, 0, '79111123412', 784048896812, 49030797, billsys_code, '79038889987', 'null', '94', 'RUR', '[1~'||start_core_balance||'~10~0][3~'||start_sms_balance||'~1~0]', 108, 1);
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.CALL_HISTORY_URL (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), '79281100000', 56, 'OutgoingCall', 0, 16, 0, 0, '79111123412', 784048896812, 49030797, billsys_code, '79038889987', 'null', '94', 'RUR', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~1~0]', 108, 1);
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-0;
	Insert into ODSCMV.CALL_HISTORY_URL (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), '79585080000', 36, 'IncomingCall', 0, 16, 0, 0, '79111123412', 784048896812, 49030797, billsys_code, '79038889987', 'null', '94', 'RUR', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~0~0]', 108, 1);
	/* с нулевой стоимостью и не нулевым объемом услуг */
	time:=time+1;
	start_core_balance:=start_core_balance-0;
	Insert into ODSCMV.CALL_HISTORY_URL (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), '79585080000', 31, 'OutgoingCall', 0, 16, 0, 0, '79111123412', 784048896812, 49030797, billsys_code, '79038889987', 'null', '94', 'RUR', '[1~'||start_core_balance||'~0~0]', 108, 1);
	/* с нулевой стоимостью и нулевым объемом услуг (тех.детализация) */
	time:=time+1;
	start_core_balance:=start_core_balance-0;
	Insert into ODSCMV.CALL_HISTORY_URL (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), '79585080000', 0, 'OutgoingCall', 0, 16, 0, 0, '79111123412', 784048896812, 49030797, billsys_code, '79038889987', 'null', '94', 'RUR', '[1~'||start_core_balance||'~0~0]', 108, 1);
	/* звонок на оператора, определяемого по полю MSC_ID */
	time:=time+1;
	start_core_balance:=start_core_balance-10;
	Insert into ODSCMV.CALL_HISTORY_URL (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), '79585080000', 0, 'OutgoingCall', 0, 16, 0, 0, '79111123412', 784048896812, 49030797, billsys_code, '1_D6499', 'null', '94', 'RUR', '[1~'||start_core_balance||'~10~0]', 108, 1);
	/* международный звонок */
	time:=time+1;
	start_core_balance:=start_core_balance-10;	
	Insert into ODSCMV.CALL_HISTORY_URL (SUBSCRIBER_ID, CALL_DATE_TIME, CALLED_NUMBER, CALL_DURATION, CALL_TYPE, TOTAL_CHARGE, REASON_CODE, NEW_BALANCE, BALANCE_TYPE, ADDITIONAL_NUMBER, CALL_ID, SLICE, BILLSYSTEM_CODE, MSC_ID, CELL_ID_OR_LAI, SLU_ID, ISO_CODE, BALANCES_INFO, SUBTYPE_ID, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), '12034534551', 0, 'OutgoingCall', 0, 16, 0, 0, '79111123412', 784048896812, 49030797, billsys_code, '79038889987', 'null', '94', 'RUR', '[1~'||start_core_balance||'~10~0]', 108, 1);

/* Транзакции для операций RECHARGE_HISTORY */
	time:=time+1;
	start_core_balance:=start_core_balance-10;
	Insert into ODSCMV.RECHARGE_HISTORY_URL (SUBSCRIBER_ID, RECHARGE_DATE_TIME, CARD_NUMBER, RECHARGE_AMOUNT, EXPIRATION_OFFSET, NEW_BALANCE, VOUCHER_TYPE, BALANCE_TYPE, SERIAL_NUMBER, RECHARGE_COMMENT, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, FACE_VALUE, BALANCES_INFO, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), 'non voucher', 61, 0, 0, 0, 0, 12070368844, 'XPB,.E012070368844', 279918750002, 6169982, billsys_code, 'RUR', 10, '[1~'||start_core_balance||'~-10~0]', 1);
	time:=time+1;
	start_core_balance:=start_core_balance+10;
	Insert into ODSCMV.RECHARGE_HISTORY_URL (SUBSCRIBER_ID, RECHARGE_DATE_TIME, CARD_NUMBER, RECHARGE_AMOUNT, EXPIRATION_OFFSET, NEW_BALANCE, VOUCHER_TYPE, BALANCE_TYPE, SERIAL_NUMBER, RECHARGE_COMMENT, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, FACE_VALUE, BALANCES_INFO, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), 'non voucher', 65, 0, 0, 0, 0, 12070368844, 'XPB,.E012070368844', 279918750002, 6169982, billsys_code, 'RUR', 10, '[1~'||start_core_balance||'~10~0]', 1);
	time:=time+1;
	start_core_balance:=start_core_balance+10; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.RECHARGE_HISTORY_URL (SUBSCRIBER_ID, RECHARGE_DATE_TIME, CARD_NUMBER, RECHARGE_AMOUNT, EXPIRATION_OFFSET, NEW_BALANCE, VOUCHER_TYPE, BALANCE_TYPE, SERIAL_NUMBER, RECHARGE_COMMENT, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, FACE_VALUE, BALANCES_INFO, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), 'non voucher', 30, 0, 0, 0, 0, 12070368844, 'XPB,.E012070368844', 279918750002, 6169982, billsys_code, 'RUR', 10, '[1~'||start_core_balance||'~10~0][3~'||start_sms_balance||'~-1~0]', 1);
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.RECHARGE_HISTORY_URL (SUBSCRIBER_ID, RECHARGE_DATE_TIME, CARD_NUMBER, RECHARGE_AMOUNT, EXPIRATION_OFFSET, NEW_BALANCE, VOUCHER_TYPE, BALANCE_TYPE, SERIAL_NUMBER, RECHARGE_COMMENT, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, FACE_VALUE, BALANCES_INFO, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), 'non voucher', 1, 0, 0, 0, 0, 12070368844, 'XPB,.E012070368844', 279918750002, 6169982, billsys_code, 'RUR', 10, '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~-1~0]', 1);
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-0;
	Insert into ODSCMV.RECHARGE_HISTORY_URL (SUBSCRIBER_ID, RECHARGE_DATE_TIME, CARD_NUMBER, RECHARGE_AMOUNT, EXPIRATION_OFFSET, NEW_BALANCE, VOUCHER_TYPE, BALANCE_TYPE, SERIAL_NUMBER, RECHARGE_COMMENT, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, FACE_VALUE, BALANCES_INFO, IDENTITY_ID)
	Values (ctn, trn_date+time/(86400/Nsec), 'non voucher', 123, 0, 0, 0, 0, 12070368844, 'XPB,.E012070368844', 279918750002, 6169982, billsys_code, 'RUR', 10, '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~0~0]', 1);

/* Транзакции для операций MTR */
	time:=time+1;
	start_core_balance:=start_core_balance+10;
	Insert into ODSCMV.MTR_URL (ID, LOGIN_NAME, BALANCE_TYPE, MTR_COMMENT, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO, IDENTITY_ID)
	Values (0, 'SWITCHCONTROL', 0, 'XPB12', 277665337522, 6167025, trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', 1555, '[1~'||start_core_balance||'~-10~0]', 1);
	time:=time+1;
	start_core_balance:=start_core_balance-10;
	Insert into ODSCMV.MTR_URL (ID, LOGIN_NAME, BALANCE_TYPE, MTR_COMMENT, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO, IDENTITY_ID)
	Values (0, 'SWITCHCONTROL', 0, 'XPB12', 277665337522, 6167025, trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', 1555, '[1~'||start_core_balance||'~10~0]', 1);
	time:=time+1;
	start_core_balance:=start_core_balance-10; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.MTR_URL (ID, LOGIN_NAME, BALANCE_TYPE, MTR_COMMENT, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO, IDENTITY_ID)
	Values (0, 'SWITCHCONTROL', 0, 'XPB12', 277665337522, 6167025, trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', 1555, '[1~'||start_core_balance||'~10~0][3~'||start_sms_balance||'~1~0]', 1);
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.MTR_URL (ID, LOGIN_NAME, BALANCE_TYPE, MTR_COMMENT, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO, IDENTITY_ID)
	Values (0, 'SWITCHCONTROL', 0, 'XPB12', 277665337522, 6167025, trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', 1555, '[1~'||start_core_balance||'~0~~0~1][3~'||start_sms_balance||'~1~0]', 1);
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-0;
	Insert into ODSCMV.MTR_URL (ID, LOGIN_NAME, BALANCE_TYPE, MTR_COMMENT, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO, IDENTITY_ID)
	Values (0, 'SWITCHCONTROL', 0, 'XPB12', 277665337522, 6167025, trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', 1555, '[1~'||start_core_balance||'~0~~0~1][3~'||start_sms_balance||'~0~0]', 1);
	/* Положительные корректировки основного баланса вручную оператором (проверка цвета, светло-зеленый) */
	time:=time+1;
	start_core_balance:=start_core_balance+10; start_sms_balance:=start_sms_balance-0;
	Insert into ODSCMV.MTR_URL (ID, LOGIN_NAME, BALANCE_TYPE, MTR_COMMENT, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO, IDENTITY_ID)
	Values (0, 'SWITCHCONTROL', 0, 'ODS_TESTER_corr_19_00_01_036_000', 277665337522, 6167025, trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', 1555, '[1~'||start_core_balance||'~-10~~0~1][3~'||start_sms_balance||'~0~0]', 1);
	/* Отрицательные корректировки основного баланса вручную оператором (проверка цвета, желтый)*/
	time:=time+1;
	start_core_balance:=start_core_balance-10; start_sms_balance:=start_sms_balance-0;
	Insert into ODSCMV.MTR_URL (ID, LOGIN_NAME, BALANCE_TYPE, MTR_COMMENT, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO, IDENTITY_ID)
	Values (0, 'SWITCHCONTROL', 0, 'ODS_TESTER_corr_19_00_01_036_000', 277665337522, 6167025, trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', 1555, '[1~'||start_core_balance||'~10~~0~1][3~'||start_sms_balance||'~0~0]', 1);
	/* Отрицательные корректировки основного баланса переводом MoneyTransfer (проверка цвета, желтый)*/
	time:=time+1;
	start_core_balance:=start_core_balance-10; start_sms_balance:=start_sms_balance-0;
	Insert into ODSCMV.MTR_URL (ID, LOGIN_NAME, BALANCE_TYPE, MTR_COMMENT, CALL_ID, SLICE, MTR_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, CURRENT_COS_ID, BALANCES_INFO, IDENTITY_ID)
	Values (0, 'SWITCHCONTROL', 0, 'ODS_TESTER_MoneyTransfer(number=9030372222)', 277665337522, 6167025, trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', 1555, '[1~'||start_core_balance||'~10~~0~1][3~'||start_sms_balance||'~0~0]', 1);

/* Транзакции для операций PS_TRANSACTIION */
	time:=time+1;
	start_core_balance:=start_core_balance+10;
	Insert into ODSCMV.PS_TRANSACTION_URL (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, CONVERSION_RATE, REQUESTED_ISO_CODE, BALANCES_INFO, MSC_ID, SUBTYPE_ID, ORP_DATE, FUND_USAGE_TYPE, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), '1', 4, '79154681360', 2650382349, 2562273291, 'N', 287515636049, 6234594, billsys_code, 'RUR', 0, 'RUR', '[1~'||start_core_balance||'~-10~0]', '79624959999', 203, trn_date+time/(86400/Nsec), 1, 1);
	time:=time+1;
	start_core_balance:=start_core_balance-10;
	Insert into ODSCMV.PS_TRANSACTION_URL (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, CONVERSION_RATE, REQUESTED_ISO_CODE, BALANCES_INFO, MSC_ID, SUBTYPE_ID, ORP_DATE, FUND_USAGE_TYPE, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), '1', 4, '79281111360', 2650382349, 2562273291, 'N', 287515636049, 6234594, billsys_code, 'RUR', 0, 'RUR', '[1~'||start_core_balance||'~10~0]', '79624959999', 203, trn_date+time/(86400/Nsec), 1, 1);
	time:=time+1;
	start_core_balance:=start_core_balance-10; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.PS_TRANSACTION_URL (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, CONVERSION_RATE, REQUESTED_ISO_CODE, BALANCES_INFO, MSC_ID, SUBTYPE_ID, ORP_DATE, FUND_USAGE_TYPE, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), '1', 4, '79271141360', 2650382349, 2562273291, 'N', 287515636049, 6234594, billsys_code, 'RUR', 0, 'RUR', '[1~'||start_core_balance||'~10~0][3~'||start_sms_balance||'~1~0]', '79624959999', 203, trn_date+time/(86400/Nsec), 1, 1);
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.PS_TRANSACTION_URL (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, CONVERSION_RATE, REQUESTED_ISO_CODE, BALANCES_INFO, MSC_ID, SUBTYPE_ID, ORP_DATE, FUND_USAGE_TYPE, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), '1', 4, '79054681360', 2650382349, 2562273291, 'N', 287515636049, 6234594, billsys_code, 'RUR', 0, 'RUR', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~1~0]', '79624959999', 203, trn_date+time/(86400/Nsec), 1, 1);
	/* бесплатная SMS с message_type=4 (должна отображаться) */
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-0;
	Insert into ODSCMV.PS_TRANSACTION_URL (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, CONVERSION_RATE, REQUESTED_ISO_CODE, BALANCES_INFO, MSC_ID, SUBTYPE_ID, ORP_DATE, FUND_USAGE_TYPE, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), '1', 4, '79654681360', 2650382349, 2562273291, 'N', 287515636049, 6234594, billsys_code, 'RUR', 0, 'RUR', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~0~0]', '79624959999', 203, trn_date+time/(86400/Nsec), 1, 1);
	/* бесплатная SMS с message_type=3 (не должна отображаться) */
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-0;
	Insert into ODSCMV.PS_TRANSACTION_URL (SUBSCRIBER_ID, TRANSACTION_DATE_TIME, SUBSCRIBER_TYPE, MESSAGE_TYPE, SUB_ID2, TRANS_ID_1, TRANS_ID_2, REFUND_FLAG, CALL_ID, SLICE, BILLSYSTEM_CODE, ISO_CODE, CONVERSION_RATE, REQUESTED_ISO_CODE, BALANCES_INFO, MSC_ID, SUBTYPE_ID, ORP_DATE, FUND_USAGE_TYPE, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), '1', 3, '79064681360', 2650382349, 2562273291, 'N', 287515636049, 6234594, billsys_code, 'RUR', 0, 'RUR', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~0~0]', '79624959999', 203, trn_date+time/(86400/Nsec), 1, 1);

/* Транзакции для операций OSA_HISTORY и OSA_HISTORY_PLAIN_GPRS (для проверки тех.детализации) */
	time:=time+1;
	start_core_balance:=start_core_balance+10;
	Insert into ODSCMV.OSA_HISTORY_URL (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), trn_date+time/(86400/Nsec), 'unitBasedCharge', 10, 400, 0, 225, 1541, '49', 21, 'GPRS', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:85.115.244.147', '''Internet''', '''VOLUME_K''', 66, -1, -1, -1, -1, 2, 'IP85.115.241.7', 2, '250996671940230', '''000000;000000;10000#ggsn7.huawei.com;360115520''', trn_date+time/(86400/Nsec), 1, 'RUR', 1, 2018635754085, 122024584, billsys_code, 'GPRS_BEELINE_VOLGA', '[1~'||start_core_balance||'~-10~0]', '1662888639', 1);
	Insert into ODSCMV.OSA_HISTORY_PLAIN_GPRS_URL (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), trn_date+time/(86400/Nsec), 'unitBasedCharge', 10, 400, 0, 225, 1541, '49', 21, 'GPRS', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:85.115.244.147', '''Internet''', '''VOLUME_K''', 66, -1, -1, -1, -1, 2, 'IP85.115.241.7', 2, '250996671940230', '''000000;000000;10000#ggsn7.huawei.com;360115520''', trn_date+time/(86400/Nsec), 1, 'RUR', 1, 2018635754085, 122024584, billsys_code, 'GPRS_BEELINE_VOLGA', '[1~'||start_core_balance||'~-10~0]', '1662888539', 1);
	time:=time+1;
	start_core_balance:=start_core_balance-10;
	Insert into ODSCMV.OSA_HISTORY_URL (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), trn_date+time/(86400/Nsec), 'unitBasedCharge', 10, 400, 0, 225, 1541, '49', 21, 'GPRS', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:85.115.244.147', '''Internet''', '''VOLUME_K''', 66, -1, -1, -1, -1, 2, 'IP85.115.241.7', 2, '250996671940230', '''000000;000000;10000#ggsn7.huawei.com;360115520''', trn_date+time/(86400/Nsec), 1, 'RUR', 1, 2018635754085, 122024584, billsys_code, 'GPRS_BEELINE_VOLGA', '[1~'||start_core_balance||'~10~0]', '1662888639', 1);
	Insert into ODSCMV.OSA_HISTORY_PLAIN_GPRS_URL (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), trn_date+time/(86400/Nsec), 'unitBasedCharge', 10, 400, 0, 225, 1541, '49', 21, 'GPRS', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:85.115.244.147', '''Internet''', '''VOLUME_K''', 66, -1, -1, -1, -1, 2, 'IP85.115.241.7', 2, '250996671940230', '''000000;000000;10000#ggsn7.huawei.com;360115520''', trn_date+time/(86400/Nsec), 1, 'RUR', 1, 2018635754085, 122024584, billsys_code, 'GPRS_BEELINE_VOLGA', '[1~'||start_core_balance||'~10~0]', '1662888539', 1);
	time:=time+1;
	start_core_balance:=start_core_balance-10; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.OSA_HISTORY_URL (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), trn_date+time/(86400/Nsec), 'unitBasedCharge', 10, 400, 0, 225, 1541, '49', 21, 'GPRS', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:85.115.244.147', '''Internet''', '''VOLUME_K''', 66, -1, -1, -1, -1, 2, 'IP85.115.241.7', 2, '250996671940230', '''000000;000000;10000#ggsn7.huawei.com;360115520''', trn_date+time/(86400/Nsec), 1, 'RUR', 1, 2018635754085, 122024584, billsys_code, 'GPRS_BEELINE_VOLGA', '[1~'||start_core_balance||'~10~0][3~'||start_sms_balance||'~1~0]', '1662888639', 1);
	Insert into ODSCMV.OSA_HISTORY_PLAIN_GPRS_URL (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), trn_date+time/(86400/Nsec), 'unitBasedCharge', 10, 400, 0, 225, 1541, '49', 21, 'GPRS', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:85.115.244.147', '''Internet''', '''VOLUME_K''', 66, -1, -1, -1, -1, 2, 'IP85.115.241.7', 2, '250996671940230', '''000000;000000;10000#ggsn7.huawei.com;360115520''', trn_date+time/(86400/Nsec), 1, 'RUR', 1, 2018635754085, 122024584, billsys_code, 'GPRS_BEELINE_VOLGA', '[1~'||start_core_balance||'~10~0][3~'||start_sms_balance||'~1~0]', '1662888539', 1);
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.OSA_HISTORY_URL (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), trn_date+time/(86400/Nsec), 'unitBasedCharge', 10, 400, 0, 225, 1541, '49', 21, 'GPRS', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:85.115.244.147', '''Internet''', '''VOLUME_K''', 66, -1, -1, -1, -1, 2, 'IP85.115.241.7', 2, '250996671940230', '''000000;000000;10000#ggsn7.huawei.com;360115520''', trn_date+time/(86400/Nsec), 1, 'RUR', 1, 2018635754085, 122024584, billsys_code, 'GPRS_BEELINE_VOLGA', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~1~0]', '1662888639', 1);
	Insert into ODSCMV.OSA_HISTORY_PLAIN_GPRS_URL (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), trn_date+time/(86400/Nsec), 'unitBasedCharge', 10, 400, 0, 225, 1541, '49', 21, 'GPRS', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:85.115.244.147', '''Internet''', '''VOLUME_K''', 66, -1, -1, -1, -1, 2, 'IP85.115.241.7', 2, '250996671940230', '''000000;000000;10000#ggsn7.huawei.com;360115520''', trn_date+time/(86400/Nsec), 1, 'RUR', 1, 2018635754085, 122024584, billsys_code, 'GPRS_BEELINE_VOLGA', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~1~0]', '1662888539', 1);
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-0;
	Insert into ODSCMV.OSA_HISTORY_URL (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), trn_date+time/(86400/Nsec), 'unitBasedCharge', 10, 400, 0, 225, 1541, '49', 21, 'GPRS', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:85.115.244.147', '''Internet''', '''VOLUME_K''', 66, -1, -1, -1, -1, 2, 'IP85.115.241.7', 2, '250996671940230', '''000000;000000;10000#ggsn7.huawei.com;360115520''', trn_date+time/(86400/Nsec), 1, 'RUR', 1, 2018635754085, 122024584, billsys_code, 'GPRS_BEELINE_VOLGA', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~0~0]', '1662888639', 1);
	Insert into ODSCMV.OSA_HISTORY_PLAIN_GPRS_URL (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, APPLICATION_DESC, OSA_ITEM, OSA_SUBTYPE, QOS, SERVICE_PARAMETER_1, SERVICE_PARAMETER_2, SERVICE_PARAMETER_3, SERVICE_PARAMETER_4, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, INFO_PARAMETER, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), trn_date+time/(86400/Nsec), 'unitBasedCharge', 10, 400, 0, 225, 1541, '49', 21, 'GPRS', 'INT GPRS charging', 12345, 2, 1, 'SGSN_IP_ADDRESS:85.115.244.147', '''Internet''', '''VOLUME_K''', 66, -1, -1, -1, -1, 2, 'IP85.115.241.7', 2, '250996671940230', '''000000;000000;10000#ggsn7.huawei.com;360115520''', trn_date+time/(86400/Nsec), 1, 'RUR', 1, 2018635754085, 122024584, billsys_code, 'GPRS_BEELINE_VOLGA', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~0~0]', '1662888539', 1);
	/* Транзакции с MERCHANT_ID <> GPRS (например, MMS) */
	time:=time+1;	
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-0;
	Insert into ODSCMV.OSA_HISTORY_URL (SUBSCRIBER_ID, START_CALL_DATE_TIME, END_CALL_DATE_TIME, ACTIVITY_TYPE, USAGE_AMOUNT, REASON_CODE, ACCOUNT_TYPE, APPLICATION_ID, SUBTYPE_ID, SLU_ID, UNIT_TYPE_ID, MERCHANT_ID, SESSION_DESC, CORRELATION_ID, CORRELATION_TYPE, ACCOUNT_ID, OSA_ITEM, OSA_SUBTYPE, SERVICE_PARAMETER_1, LOCATION_A_TYPE, LOCATION_B, LOCATION_B_TYPE, IMSI, CHARGE_CODE, ORP_DATE, FUND_USAGE_TYPE, ISO_CODE, CONVERSION_RATE, CALL_ID, SLICE, BILLSYSTEM_CODE, LOCATION_A, BALANCES_INFO, SESSION_ID, RECORD_SOURCE)
	Values (ctn, trn_date+time/(86400/Nsec), trn_date+time/(86400/Nsec), 'unitBasedCharge', 1, 400, 0, 285, 1541, '3', 5, 'MMS_MESSAGE', 'MMSMO:79645768036', 90100215, 3, 17, '''mms''', '''-1''', 25, 2, '773245121', 2, '250997100072863', 'Na*aSaaa', trn_date+time/(86400/Nsec), 1, 'RUR', 1, 2018635754085, 122024584, billsys_code, '79036608929', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~0~0]', '1662888639', 1);

/* Транзакции для операций RC */
	time:=time+1;
	start_core_balance:=start_core_balance+10;
	Insert into ODSCMV.RC_URL (ID, RC_COMMENT, RC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, BALANCES_INFO)
	Values (0, 'PC_EASY01_OR_PC', trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', '[1~'||start_core_balance||'~-10~0]');
	time:=time+1;
	start_core_balance:=start_core_balance-10;
	Insert into ODSCMV.RC_URL (ID, RC_COMMENT, RC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, BALANCES_INFO)
	Values (0, 'PC_EASY01_OR_PC', trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', '[1~'||start_core_balance||'~10~0]');
	time:=time+1;
	start_core_balance:=start_core_balance-10; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.RC_URL (ID, RC_COMMENT, RC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, BALANCES_INFO)
	Values (0, 'PC_EASY01_OR_PC', trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', '[1~'||start_core_balance||'~10~0][3~'||start_sms_balance||'~1~0]');
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.RC_URL (ID, RC_COMMENT, RC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, BALANCES_INFO)
	Values (0, 'PC_EASY01_OR_PC', trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~1~0]');
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-0;
	Insert into ODSCMV.RC_URL (ID, RC_COMMENT, RC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, BALANCES_INFO)
	Values (0, 'PC_EASY01_OR_PC', trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~0~0]');

/* Транзакции для операций NRC */
	time:=time+1;
	start_core_balance:=start_core_balance+10;
	Insert into ODSCMV.NRC_URL (ID, NRC_COMMENT, CALL_ID, SLICE, NRC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, BALANCES_INFO)
	Values (0, 'PC_test', 287512311454, 6226097, trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', '[1~'||start_core_balance||'~-10~0]');
	time:=time+1;
	start_core_balance:=start_core_balance-10;
	Insert into ODSCMV.NRC_URL (ID, NRC_COMMENT, CALL_ID, SLICE, NRC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, BALANCES_INFO)
	Values (0, 'PC_test', 287512311454, 6226097, trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', '[1~'||start_core_balance||'~10~0]');
	time:=time+1;
	start_core_balance:=start_core_balance-10; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.NRC_URL (ID, NRC_COMMENT, CALL_ID, SLICE, NRC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, BALANCES_INFO)
	Values (0, 'PC_test', 287512311454, 6226097, trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', '[1~'||start_core_balance||'~10~0][3~'||start_sms_balance||'~1~0]');
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-1;
	Insert into ODSCMV.NRC_URL (ID, NRC_COMMENT, CALL_ID, SLICE, NRC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, BALANCES_INFO)
	Values (0, 'PC_test', 287512311454, 6226097, trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~1~0]');
	time:=time+1;
	start_core_balance:=start_core_balance-0; start_sms_balance:=start_sms_balance-0;
	Insert into ODSCMV.NRC_URL (ID, NRC_COMMENT, CALL_ID, SLICE, NRC_DATE_TIME, BILLSYSTEM_CODE, PPS_ACCOUNT, ISO_CODE, BALANCES_INFO)
	Values (0, 'PC_test', 287512311454, 6226097, trn_date+time/(86400/Nsec), billsys_code, ctn, 'RUR', '[1~'||start_core_balance||'~0~0][3~'||start_sms_balance||'~0~0]');

/* транзакции ROAMING_CALLS */
	time:=time+1;
	Insert into ODSCMV.ROAMING_CALLS (SUBSCRIBER_ID, CALL_DATE_TIME, CALL_DURATION, CALLED_NUMBER, TOTAL_CHARGE, NEW_BALANCE, OPERATION_DATE_TIME, ROAMING_PARTNER, T_O, CALL_ID, SLICE, BILLSYSTEM_CODE, VOLUME, MEASURE)
	Values (ctn, trn_date+time/(86400/Nsec), 245, '78452797714', 1, 5.5, trn_date+time/(86400/Nsec), 'GABCT', '2V', 19428496, 121943360, billsys_code, 0, 'SE');
	time:=time+1;
	Insert into ODSCMV.ROAMING_CALLS (SUBSCRIBER_ID, CALL_DATE_TIME, CALL_DURATION, CALLED_NUMBER, TOTAL_CHARGE, NEW_BALANCE, OPERATION_DATE_TIME, ROAMING_PARTNER, T_O, CALL_ID, SLICE, BILLSYSTEM_CODE, VOLUME, MEASURE)
	Values (ctn, trn_date+time/(86400/Nsec), 199, '79603578862', -13.7979, 0, trn_date+time/(86400/Nsec), 'GABCT', '2V', 19428494, 121943360, billsys_code, 0, 'SE');

/* транзакции USERSESSIONS */
	time:=time+1;
	Insert into ODSCMV.USERSESSIONS (NUMCHARGEID, CHRMSISDN, VCHAPN, DTMSTARTDATE, NUMVOLUME, NUMRATEDVOLUME, DTMSYSCREATIONDATE, BILLSYSTEM_CODE, SLICE)
	Values (564, ctn, 'internet.beeline.ru', trn_date+time/(86400/Nsec), 1633118, 1633280, trn_date+time/(86400/Nsec), billsys_code, 7777400);

/* транзакции ACCUMULATOR */
	time:=time+1;
	Insert into ODSCMV.ACCUMULATOR (CHRMSISDN, NUMID, DTMSYSCREATIONDATE, DTMNOTIFYDATE, BILLSYSTEM_CODE, SMS_TYPE)
	Values (ctn, 905426593, trn_date+time/(86400/Nsec), trn_date+time/(86400/Nsec), billsys_code, 'pink+30');

	rounds:=rounds+1;
	end LOOP;
commit;
end;