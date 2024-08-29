@echo off
setlocal enabledelayedexpansion

set outputFile="C:\saida.txt"
echo Salvando as informações das redes Wi-Fi... > %outputFile%

:: Listar todos os perfis de rede Wi-Fi
for /f "tokens=*" %%a in ('netsh wlan show profiles') do (
    echo %%a | findstr /r /c:"Perfil" >nul
    if not errorlevel 1 (
        set "profile=%%a"
        set "profile=!profile:Perfil de rede =!"
        set "profile=!profile:Perfil de rede =!"
        echo. >> %outputFile%
        echo SSID: !profile! >> %outputFile%
        echo Senha: >> %outputFile%
        for /f "tokens=*" %%b in ('netsh wlan show profile name="!profile!" key=clear') do (
            echo %%b | findstr /r /c:"Key Content" >nul
            if not errorlevel 1 (
                set "key=%%b"
                set "key=!key:Key Content=!"
                set "key=!key:Key Content =!"
                echo Senha: !key! >> %outputFile%
            )
        )
    )
)

echo Informações salvas em %outputFile%
pause