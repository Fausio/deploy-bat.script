echo
:: set folder to save backup files ex. BACKUPPATH=c:\backup
set BACKUPPATH=C:\COVIDA\BACKUPS\BASE DE DADOS

:: set Sql Server location ex. set SERVERNAME=localhost\SQLEXPRESS
set SERVERNAME=localhost\SQL_ENGINE_2014

:: set Database name to backup
set DATABASENAME=CSI_PROD

:: filename format Name-Date (eg MyDatabase-2009-5-19_1700.bak)
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a%%b)

set DATESTAMP=%mydate%_%mytime%
set BACKUPFILENAME=%BACKUPPATH%\%DATABASENAME%-%DATESTAMP%.bak
echo.

sqlcmd -E -S %SERVERNAME% -d master -Q "BACKUP DATABASE [%DATABASENAME%] TO DISK = N'%BACKUPFILENAME%' WITH INIT , NOUNLOAD , NAME = N'%DATABASENAME% backup', NOSKIP , STATS = 10, NOFORMAT"
echo.

:: In this case, we are choosing to keep the most recent 10 files
:: Also, the files we are looking for have a 'bak' extension
for /f "skip=10 delims=" %%F in ('dir %BACKUPPATH%\*.bak /s/b/o-d/a-d') do del "%%F"