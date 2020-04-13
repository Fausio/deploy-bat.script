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
    CALL ADMIN.BAT
  
:: exibe uma alert de sucesso
powershell (New-Object -ComObject Wscript.Shell).Popup("""e-MAC atualizado  com  sucesso!""",0,"""Done""",0x0)
 

:: Inicializa link da aplicação 
start "" http://localhost:80


   