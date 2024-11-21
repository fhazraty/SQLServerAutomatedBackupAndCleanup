-- بررسی اینکه آیا ساعت و دقیقه برابر با 12:00 شب است (برای اجرای Full Backup)
IF DATEPART(HOUR, GETDATE()) = 0 AND DATEPART(MINUTE, GETDATE()) = 0 -- Full backup at midnight
BEGIN
    -- تعریف متغیر برای ذخیره مسیر فایل پشتیبان کامل
    DECLARE @FullBackupPath NVARCHAR(255);
    
    -- تنظیم مسیر فایل پشتیبان با استفاده از تاریخ و زمان فعلی برای ایجاد نام یکتا
    SET @FullBackupPath = 'C:\SQL Server Backups\FullBackup\DatabaseName_Full_' 
        + CONVERT(VARCHAR, GETDATE(), 112) -- تاریخ به فرمت YYYYMMDD
        + '_' 
        + REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '') -- زمان به فرمت HHMMSS (بدون دو نقطه)
        + '.bak';

    -- چاپ پیام شروع عملیات Full Backup
    PRINT 'Starting Full Backup...';

    -- اجرای پشتیبان‌گیری کامل پایگاه داده
    BACKUP DATABASE [MyDatabase]
    TO DISK = @FullBackupPath -- ذخیره در مسیر تعیین شده
    WITH FORMAT, -- فرمت کردن فایل پشتیبان (برای اطمینان از تمیزی فایل)
         INIT, -- شروع نوشتن جدید در فایل پشتیبان
         NAME = 'Full Backup of DatabaseName', -- نام توضیحی برای این پشتیبان
         STATS = 10; -- نمایش پیشرفت پشتیبان‌گیری به صورت درصدی (هر 10%)

    -- چاپ پیام موفقیت‌آمیز بودن عملیات Full Backup
    PRINT 'Full Backup Completed Successfully.';
END
-- بررسی اینکه آیا دقیقه جاری برابر با 0 است (برای اجرای Differential Backup هر ساعت)
ELSE IF DATEPART(MINUTE, GETDATE()) = 0
BEGIN
    -- تعریف متغیر برای ذخیره مسیر فایل پشتیبان تفاضلی
    DECLARE @DiffBackupPath NVARCHAR(255);
    
    -- تنظیم مسیر فایل پشتیبان با استفاده از تاریخ و زمان فعلی برای ایجاد نام یکتا
    SET @DiffBackupPath = 'C:\SQL Server Backups\DifferentialBackup\DatabaseName_Diff_' 
        + CONVERT(VARCHAR, GETDATE(), 112) -- تاریخ به فرمت YYYYMMDD
        + '_' 
        + REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '') -- زمان به فرمت HHMMSS (بدون دو نقطه)
        + '.bak';

    -- چاپ پیام شروع عملیات Differential Backup
    PRINT 'Starting Differential Backup...';

    -- اجرای پشتیبان‌گیری تفاضلی پایگاه داده
    BACKUP DATABASE [MyDatabase]
    TO DISK = @DiffBackupPath -- ذخیره در مسیر تعیین شده
    WITH DIFFERENTIAL, -- مشخص کردن اینکه این پشتیبان از نوع تفاضلی است
         INIT, -- شروع نوشتن جدید در فایل پشتیبان
         NAME = 'Differential Backup of DatabaseName', -- نام توضیحی برای این پشتیبان
         STATS = 10; -- نمایش پیشرفت پشتیبان‌گیری به صورت درصدی (هر 10%)

    -- چاپ پیام موفقیت‌آمیز بودن عملیات Differential Backup
    PRINT 'Differential Backup Completed Successfully.';
END
-- بررسی اینکه آیا دقیقه جاری مضربی از 5 است (برای اجرای Transaction Log Backup هر 5 دقیقه)
ELSE IF DATEPART(MINUTE, GETDATE()) % 5 = 0
BEGIN
    -- تعریف متغیر برای ذخیره مسیر فایل پشتیبان لاگ تراکنش
    DECLARE @LogBackupPath NVARCHAR(255);
    
    -- تنظیم مسیر فایل پشتیبان با استفاده از تاریخ و زمان فعلی برای ایجاد نام یکتا
    SET @LogBackupPath = 'C:\SQL Server Backups\TransactionLogs\DatabaseName_Log_' 
        + CONVERT(VARCHAR, GETDATE(), 112) -- تاریخ به فرمت YYYYMMDD
        + '_' 
        + REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '') -- زمان به فرمت HHMMSS (بدون دو نقطه)
        + '.trn';

    -- چاپ پیام شروع عملیات Transaction Log Backup
    PRINT 'Starting Transaction Log Backup...';

    -- اجرای پشتیبان‌گیری لاگ تراکنش پایگاه داده
    BACKUP LOG [MyDatabase]
    TO DISK = @LogBackupPath -- ذخیره در مسیر تعیین شده
    WITH INIT, -- شروع نوشتن جدید در فایل پشتیبان
         NAME = 'Transaction Log Backup of DatabaseName', -- نام توضیحی برای این پشتیبان
         STATS = 10; -- نمایش پیشرفت پشتیبان‌گیری به صورت درصدی (هر 10%)

    -- چاپ پیام موفقیت‌آمیز بودن عملیات Transaction Log Backup
    PRINT 'Transaction Log Backup Completed Successfully.';
END
