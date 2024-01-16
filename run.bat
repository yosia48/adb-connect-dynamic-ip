@echo off
setlocal enabledelayedexpansion

REM Hentikan server adb sebelum mencoba koneksi baru
adb kill-server

REM Baca file ARP_OUTPUT.TXT dan temukan alamat IP yang dinamis
for /f "tokens=1,2" %%a in ('findstr "dynamic" arp_output.txt') do (
    set ip_address=%%a
    set mac_address=%%b

    REM Cek apakah alamat IP valid (tidak berisi "Interface" atau "Internet")
    echo !ip_address! | findstr /i /c:"Interface" >nul
    if errorlevel 1 (
        echo !ip_address! | findstr /i /c:"Internet" >nul
        if errorlevel 1 (
            REM Eksekusi adb connect ke alamat IP yang dinamis
            adb connect !ip_address!:5555
        )
    )
)

endlocal
