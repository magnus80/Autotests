-- UMCS

-- Declare the variable to be used.
DECLARE @ctn varchar(10); -- номер абонента
DECLARE @change_balance money; -- изменение баланса в транзакции
DECLARE @end_balance money; -- конечный баланс в транзакции
DECLARE @iterator varchar(2); -- итератор, используемый для ограничения количества транзакций
DECLARE @Nmin int; -- итератор для выставления времени, через которое выполняются транзакции (для поля WRITING_DOWN_DATE)
-- Initialize the variable.
SET @ctn = '9030372222';
SET @change_balance = -50;
SET @end_balance = 950;
SET @iterator = 0;
SET @Nmin = 0;
-- Test the variable to see if the loop is finished.
WHILE (@iterator < 10)
BEGIN;
SET @end_balance = @end_balance + @change_balance;
INSERT INTO [LogDb].[dbo].[UMCS_TRANSACTION_LOG]
     ([TL_ID],[LT_ID],[LS_ID],[TL_DATE],[ACC_PHONE],[ACC_ID],[GD_ID],[ST_ID],[TL_AMOUNT],[TL_MESSAGE],
	 [TL_SOURCE],[TL_SMS],[TL_ORDER_ID],[TL_PARENT],[GD_CODE],[GD_NAME],[ST_NAME],[ST_INN],[TL_COMMENT],[GD_PRICE],
	 [TL_TARGET_PHONE],[GD_COMISSION_BANK],[GD_COMISSION_OPERATOR],[GD_COMISSION_OF_ACC],[TL_PARENT_ORDER_ID],[CH_ID],[SMDS_ID],[TL_ERROR_CODE],[TL_UPLOAD_DATE],[TL_IS_PURCH],
	 [RB_ID],[ID_BP],[ID_ORDER_BP],[DATE_PAY_BP],[DATE_TRAN_BP],[TL_DATE_UPDATE],[TL_ACC_IS_DEL],[TL_PAY_PHONE_ID],[BNK_ID],[BNK_CODE],
	 [GDCT_ID],[GDCT_NAME],[GD_FIX_COMISS_OPERATOR],[GD_FIX_COMISS_OF_ACC],[BST_COMMENT],[TL_EXEPTION],[TL_EX_OUTSIDE_SYS],[TL_IS_CMD_TASK],[TL_CORRELATION_ID],[TL_CORRELATION_ID_PFX],
	 [TL_AMOUNT_CAC],[TL_AMOUNT_BL],[TL_AMOUNT_SM],[TL_REF_ID],[TL_SENDED_TO_REPORT],[TL_AMOUNT_AF],[TL_TRANSFER_AMOUNT],[WRITING_DOWN_DATE],[CANCELLATION_ID])
VALUES
	 (1999,	0,	1,	dateadd(mi, +@Nmin, getdate()-2),	@ctn,	NULL,	NULL,	NULL,	NULL,	NULL,
	 NULL,	NULL,	NULL,	NULL,	8810,	NULL,	NULL,	NULL,	NULL,	NULL,
	 NULL,	NULL,	NULL,	NULL,	NULL,	1,	0,	NULL,	'2011-03-16 00:00:00.000',	0,
	 NULL,	NULL,	NULL,	NULL,	NULL,	'2015-09-14 10:42:12.177',	0,	NULL,	NULL,	NULL,
	 NULL,	NULL,	'0.00',	'0.00',	NULL,	NULL,	NULL,	0,	NULL,	NULL,
	 NULL,	NULL,	NULL,	NULL,	0,	@end_balance,	@change_balance,	dateadd(mi, +@Nmin, getdate()-2),	NULL)
SET @iterator = @iterator + 1;
SET @Nmin = @Nmin + 1;
END;
--GO