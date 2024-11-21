# SQLBackupAndCleanup

## English

A set of scripts and tools to automate the backup, log management, and cleanup processes for SQL Server databases. This repository is designed to help administrators maintain a clean and efficient backup system with minimal manual intervention.

### Features:
1. Automated **Full**, **Differential**, and **Transaction Log** backups using dynamic file naming.
2. Cleanup of old backup files based on a **30-day retention policy**.
3. Batch file integration for deleting outdated files directly from the system.

### Files Included:
- **BackupPlan.sql**: Automates full, differential, and transaction log backups.
- **CleanUpPlan.sql**: Deletes outdated backup and log files using SQL Server's `xp_cmdshell`.
- **RemoveOldFiles.bat**: Batch file for removing `.bak` and `.trn` files older than 30 days.

### How to Use:
1. **Schedule BackupPlan.sql** in SQL Server Agent to run backups (full, differential, or transaction logs) as per your needs.
2. Use **CleanUpPlan.sql** or **RemoveOldFiles.bat** to clean up old files periodically.
3. Combine the scripts with a Windows Task Scheduler or SQL Server jobs for full automation.

---

## فارسی

مجموعه‌ای از اسکریپت‌ها و ابزارها برای خودکارسازی فرآیندهای پشتیبان‌گیری، مدیریت لاگ‌ها و پاکسازی فایل‌ها در پایگاه داده SQL Server. این مخزن به مدیران کمک می‌کند تا یک سیستم پشتیبان کارآمد و تمیز را با حداقل مداخله دستی حفظ کنند.

### ویژگی‌ها:
1. پشتیبان‌گیری خودکار **کامل (Full)**، **تفاضلی (Differential)** و **لاگ تراکنش (Transaction Log)** با نام‌گذاری پویا.
2. حذف فایل‌های پشتیبان قدیمی بر اساس **سیاست نگهداری 30 روزه**.
3. فایل‌های دسته‌ای برای حذف فایل‌های قدیمی به صورت مستقیم از سیستم.

### فایل‌های موجود:
- **BackupPlan.sql**: پشتیبان‌گیری خودکار از پایگاه داده (کامل، تفاضلی، لاگ).
- **CleanUpPlan.sql**: حذف فایل‌های قدیمی پشتیبان و لاگ با استفاده از `xp_cmdshell` SQL Server.
- **RemoveOldFiles.bat**: فایل دسته‌ای برای حذف فایل‌های قدیمی‌تر از 30 روز.

### نحوه استفاده:
1. اسکریپت **BackupPlan.sql** را در SQL Server Agent زمان‌بندی کنید تا پشتیبان‌ها را طبق نیاز اجرا کند.
2. از **CleanUpPlan.sql** یا **RemoveOldFiles.bat** برای پاکسازی فایل‌های قدیمی به صورت دوره‌ای استفاده کنید.
3. اسکریپت‌ها را با Windows Task Scheduler یا Job‌های SQL Server برای خودکارسازی کامل ترکیب کنید.
