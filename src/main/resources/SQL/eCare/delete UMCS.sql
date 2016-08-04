-- delete UMCS (удаление данных для абонента за период между системным временем минус 1 день и системным временем плюс 1 день)
delete [LogDb].[dbo].[UMCS_TRANSACTION_LOG]
WHERE
ACC_PHONE = '9030372222'
and 
WRITING_DOWN_DATE between getdate()-3 and getdate()+1
