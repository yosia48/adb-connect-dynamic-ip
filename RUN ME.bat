@echo off
setlocal enabledelayedexpansion

REM Jalankan arp -a dan simpan outputnya ke dalam file
arp -a > arp_output.txt

REM Hentikan server adb sebelum mencoba koneksi baru
adb kill-server

REM Baca file ARP_OUTPUT.TXT dan temukan alamat IP yang dinamis
for /f "tokens=1,2,3" %%a in ('findstr /i /c:"dynamic" arp_output.txt') do (
    set ip_address=%%a

    REM Eksekusi adb connect ke alamat IP yang dinamis
    echo Menghubungkan ke !ip_address!
    adb connect !ip_address!:5555
)

:loop
REM Jalankan scrcpy dengan opsi -S
scrcpy -S

REM Setelah scrcpy ditutup, matikan layar perangkat
adb shell input keyevent 223

REM Tampilkan pesan dan tunggu input pengguna
echo Tekan Enter untuk menjalankan kembali scrcpy, atau Ctrl+C untuk keluar.
pause >nul

REM Kembali ke loop untuk menjalankan scrcpy lagi
goto loop

endlocal
