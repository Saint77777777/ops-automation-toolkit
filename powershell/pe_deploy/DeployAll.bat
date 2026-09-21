@echo off
rem ==============================================
rem DeployAll.bat: One-click full deployment
rem 中文说明：一键完整部署脚本：先diskpart分区，再调用ApplyImage部署镜像
rem Command same as your screenshot:
rem diskpart /s "U:\Script\CreatePartitions-UEFI-FFU.txt"
rem call ApplyImage.bat U:\xxx.wim
rem Personal practice, for learning only
rem ==============================================
set "SCRIPT_ROOT=U:\Script"
set "WIM_IMAGE=U:\Universal_Win11_20250721.wim"

echo Run diskpart create partition script
echo 执行磁盘分区脚本
diskpart /s "%SCRIPT_ROOT%\CreatePartitions-UEFI-FFU.txt"
if not %errorlevel% equ 0 (
    echo DiskPart partition error! 分区脚本执行失败
    pause
    exit /b %errorlevel%
)

echo Start apply wim image
echo 开始部署镜像
call "%SCRIPT_ROOT%\ApplyImage.bat" "%WIM_IMAGE%"

echo All task finished. Press any key to reboot.
pause
wpeutil reboot
