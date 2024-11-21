@echo off
:: تنظیم مسیرهای اصلی
set FullBackupPath=C:\SQL Server Backups\FullBackup
set DiffBackupPath=C:\SQL Server Backups\DifferentialBackup
set LogBackupPath=C:\SQL Server Backups\TransactionLogs

:: حذف فایل‌های قدیمی‌تر از 30 روز از Full Backup
forfiles /P "%FullBackupPath%" /S /M *.bak /D -30 /C "cmd /c del @path"
echo Deleted files older than 30 days in Full Backup folder.

:: حذف فایل‌های قدیمی‌تر از 30 روز از Differential Backup
forfiles /P "%DiffBackupPath%" /S /M *.bak /D -30 /C "cmd /c del @path"
echo Deleted files older than 30 days in Differential Backup folder.

:: حذف فایل‌های قدیمی‌تر از 30 روز از Transaction Log Backup
forfiles /P "%LogBackupPath%" /S /M *.trn /D -30 /C "cmd /c del @path"
echo Deleted files older than 30 days in Transaction Log folder.

:: پایان عملیات
echo Cleanup completed!
pause
