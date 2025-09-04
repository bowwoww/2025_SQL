use master;
GO

DECLARE @DatabaseName NVARCHAR(128) = 'MessageBoard';
DECLARE @BackupPath NVARCHAR(256) = 'C:\Backup\';
DECLARE @DateSuffix NVARCHAR(20) = CONVERT(VARCHAR(20), GETDATE(), 112) + '_' + REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), ':', '');
DECLARE @BackupFileName NVARCHAR(256) = @BackupPath + @DatabaseName + '_' + @DateSuffix + '.bak';

DECLARE @SQL NVARCHAR(MAX) = '
BACKUP DATABASE [' + @DatabaseName + ']
TO DISK = N''' + @BackupFileName + '''
WITH INIT, NAME = N''Full Backup - ' + @DatabaseName + ''', COMPRESSION, STATS = 10;
';

EXEC(@SQL);

--還原 database
DECLARE @RestoreSQL NVARCHAR(MAX) = '
ALTER DATABASE [' + 'MessageBoard' + '] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
RESTORE DATABASE [' + 'MessageBoard' + ']
FROM DISK = N''' + 'c:\Backup\MessageBoard_20250730_153351.bak' + '''
WITH REPLACE, STATS = 10;
ALTER DATABASE [' + 'MessageBoard' + '] SET MULTI_USER;
';

EXEC(@RestoreSQL);