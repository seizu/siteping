@echo off
setlocal

if "%~1"=="" (
   echo Usage: tpush.bat [message_text]
   exit /b 1
)

set timeout=5
set token=YOUR_TOKEN
set chatId=YOUR_CHAT_ID

curl.exe --connect-timeout %timeout% -G -s -o NUL "https://api.telegram.org/bot%token%/sendMessage?" --data-urlencode "text=%~1" --data-urlencode "chat_id=%chatId%" || exit /b 1
endlocal
