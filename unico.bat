:: 1 errado / 0 certo
:: Compara se a versão da OCB é a mesma que a do owncloud, se não for igual ele deve executar O MAIN.BAT
@echo ON
   :main
   fc C:\OwnCloud\e-MAC\e-MAC_LastVersion.txt   C:\COVIDA\WebSite1\e-MAC_LastVersion.txt   > nul
   if errorlevel 1 goto update  

   :next
     EXIT
  goto main

  :update
   ::------------------------------------------BACKUP-----------------------------------------------------------
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







   ::------------------------------------------BACKUP_Files----------------------------------------------------------------
   color a
@echo off
"C:\Program Files (x86)\WinRAR\Rar.exe" a -r "C:\COVIDA\Old WebSite and Last Database\E-MAC_Beckup.zip" "C:\COVIDA\WebSite1\*.*"
"C:\Program Files (x86)\WinRAR\Rar.exe" a -r "C:\COVIDA\Old WebSite and Last Database\CSI_Beckup.zip"   "C:\COVIDA\BACKUPS\BASE DE DADOS\*.*"
echo.
echo Back-up finalizado com sucesso!
echo. 










   ::------------------------------------------DELETE_OLD_FILES-----------------------------------------------------------

   COLOR C
del "C:\COVIDA\BACKUPS\BASE DE DADOS\*.BAK"
del /s /q "C:\COVIDA\WebSite1\*.*"



   ::------------------------------------------UPDATE_e_MAC---------------------------------------------------------
    
  color D
  cd/
  :: copia para pasta da OCB os files da versão
  "C:\Program Files (x86)\WinRAR\Rar.exe" x -y -c "C:\OwnCloud\e-MAC\*.rar" "C:\COVIDA\WebSite1"   

  :: copia para pasta da OCB o .txt versão
  ::copy "C:\OwnCloud\e-MAC\e-MAC_LastVersion.txt" "C:\COVIDA\WebSite1"
 

:: exibe uma alert de sucesso
:: powershell (New-Object -ComObject Wscript.Shell).Popup("""e-MAC atualizado  com  sucesso!""",0,"""Done""",0x0)
 
   ::------------------------------------------start_e_MAC---------------------------------------------------------
:: Inicializa link da aplicação 
start "" http://localhost:80


   