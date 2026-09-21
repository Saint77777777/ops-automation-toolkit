@echo off
rem ==============================================
rem ApplyImage.bat : Apply WIM image to target W: drive in WinPE
rem 中文说明：PE环境批处理，使用DISM把WIM镜像部署到W盘，部署完成自动修复引导
rem Usage: ApplyImage.bat U:\xxx.wim
rem Personal practice, for learning only
rem ==============================================
setlocal enabledelayedexpansion
if "%~1"=="" (
    echo ERROR: Please input wim file path.
    echo 错误：请传入WIM镜像文件路径
    pause
    exit /b 1
)
set "WIM_FILE=%~1"
set "WIN_DRIVE=W:"
set "ESP_DRIVE=S:"

echo ======================================
echo Start apply wim image to %WIN_DRIVE%
echo 开始将WIM镜像部署到系统盘 %WIN_DRIVE%
echo WIM Source: %WIM_FILE%
echo ======================================

rem Apply image with DISM | DISM应用镜像
dism /apply-image /imagefile:%WIM_FILE% /index:1 /applydir:%WIN_DRIVE%\
if not !errorlevel! equ 0 (
    echo ERROR: DISM apply image failed. 镜像部署失败
    pause
    exit /b !errorlevel!
)

rem Write boot files to ESP partition | 向ESP分区写入引导
%WIN_DRIVE%\Windows\System32\bcdboot %WIN_DRIVE%\Windows /s %ESP_DRIVE% /f UEFI
if not !errorlevel! equ 0 (
    echo ERROR: bcdboot write boot failed. 引导写入失败
    pause
    exit /b !errorlevel!
)

echo ======================================
echo Image apply & boot success!
echo 镜像部署+引导写入完成，可以重启进入系统
echo ======================================
endlocal
pause
