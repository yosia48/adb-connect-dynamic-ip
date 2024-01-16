@echo off

REM Run arp -a and save the output to a file
arp -a > arp_output.txt

REM Extract the dynamic IP address from the output
for /f "tokens=2 delims= " %%A in ('find "dynamic" arp_output.txt ^| find "5555"') do set dynamic_ip=%%A

REM Check if the dynamic IP address is set
if not defined dynamic_ip (
    echo Dynamic IP address not found.
    exit /b
)

REM Connect via ADB using the dynamic IP address
adb connect %dynamic_ip%:5555

REM Pause to keep the console window open (optional)
pause
