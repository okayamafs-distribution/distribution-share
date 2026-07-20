@echo off

REM パスワード変数にランダムパスワード値を割り当てる
REM setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
REM set alfanum=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
REM set rustdesk_pw=
REM for /L %%b in (1, 1, 12) do (
REM     set /A rnd_num=!RANDOM! %% 62
REM     for %%c in (!rnd_num!) do (
REM         set rustdesk_pw=!rustdesk_pw!!alfanum:~%%c,1!
REM     )
REM )

set rustdesk_pw="Okayama2900"

REM Webポータルから設定文字列を取得し、以下で入力してください
set rustdesk_cfg="9JCNxETMyozM44iM04SOuETMy8yL6AHd0hmI6ISawFmIsISPnRWNVtUeTNGWSNmcRNjdnJnQwtSY2glUy0kWIdzUXR1QnxGa0kmVLJkZrJiOikXZrJCLiMDOuIDNukjLxEjMiojI0N3boJye"

REM ############################### この線より下を編集しないでください #########################################

echo RustDeskをインストールしています
echo しばらくお待ち下さい

:# インストール用のexeの階層に移動
:# cd /d "%~dp0"

if not exist C:\Temp\ md C:\Temp\
dir > "C:\Temp\test.txt"
cd C:\Temp\

REM curl -L "https://github.com/rustdesk/rustdesk/releases/download/1.4.5/rustdesk-1.4.5-x86_64.exe" -o rustdesk.exe

if exist "c:\Program Files (x86)\MOTEX\LanScope Client\Distribution\20260720\rustdesk.exe" copy "c:\Program Files (x86)\MOTEX\LanScope Client\Distribution\20260720\rustdesk.exe" rustdesk.exe > nul
if exist "c:\Program Files\MOTEX\LanScope Client\Distribution\20260720\rustdesk.exe" copy "c:\Program Files\MOTEX\LanScope Client\Distribution\20260720\rrustdesk.exe" rustdesk.exe > nul

rustdesk.exe --silent-install
timeout /t 20
:# timeoutコマンドだと途中で終わらせることができるのでsleepを使う
:# powershell -Command "Start-Sleep -s 20"

:# デスクトップのショートカット削除
del /f "%PUBLIC%\Desktop\RustDesk.lnk" 2>nul
del /f "%USERPROFILE%\Desktop\RustDesk.lnk" 2>nul


echo 設定を変更しています
echo\


cd "C:\Program Files\RustDesk\"
rustdesk.exe --install-service
timeout /t 20 /nobreak
:# powershell -Command "Start-Sleep -s 20"

for /f "delims=" %%i in ('rustdesk.exe --get-id ^| more') do set rustdesk_id=%%i

rustdesk.exe --config %rustdesk_cfg%

rustdesk.exe --password %rustdesk_pw%

echo ...............................................
REM ID変数の値を表示
echo RustDesk ID: %rustdesk_id%

:# REM パスワード変数の値を表示
:# echo パスワード: %rustdesk_pw%
echo ...............................................

echo インストールが完了しました
echo\
echo\
:# pause
