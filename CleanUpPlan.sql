-- فعال‌سازی xp_cmdshell اگر غیرفعال است
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;

-- تعریف متغیرها
DECLARE @BackupBasePath NVARCHAR(255); -- مسیر اصلی پشتیبان‌ها
-- تنظیم مسیر اصلی
SET @BackupBasePath = 'C:\SQL Server Backups';

DECLARE @CommandFull NVARCHAR(MAX); -- دستور حذف فایل‌های Full Backup
-- دستور حذف فایل‌های Full Backup (قدیمی‌تر از 30 روز)
SET @CommandFull = 'forfiles /P "' + @BackupBasePath + '\FullBackup" /S /M *.bak /D -30 /C "cmd /c del @path"';
-- اجرای دستور حذف برای Full Backup
EXEC xp_cmdshell @CommandFull;

DECLARE @CommandDiff NVARCHAR(MAX); -- دستور حذف فایل‌های Differential Backup
-- دستور حذف فایل‌های Differential Backup (قدیمی‌تر از 30 روز)
SET @CommandDiff = 'forfiles /P "' + @BackupBasePath + '\DifferentialBackup" /S /M *.bak /D -30 /C "cmd /c del @path"';
-- اجرای دستور حذف برای Differential Backup
EXEC xp_cmdshell @CommandDiff;

DECLARE @CommandLog NVARCHAR(MAX);  -- دستور حذف فایل‌های Transaction Log
-- دستور حذف فایل‌های Transaction Logs (قدیمی‌تر از 30 روز)
SET @CommandLog = 'forfiles /P "' + @BackupBasePath + '\TransactionLogs" /S /M *.trn /D -30 /C "cmd /c del @path"';
-- اجرای دستور حذف برای Transaction Log Backup
EXEC xp_cmdshell @CommandLog;
