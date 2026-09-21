# Usage Guide 使用说明
English:
This document describes the basic operation steps of these automation scripts.
All scripts are for study only.

中文：
本文档描述自动化脚本的基础操作步骤。全部脚本仅供学习。

## PowerShell Scripts
### Precondition
- Enable WinRM for remote operation if you need batch remote deploy.
- Run PowerShell as Administrator.
- Execution policy may need adjustment: `Set-ExecutionPolicy RemoteSigned`

## WinPE WIM Image Deployment（新增）
### Precondition
- Boot into WinPE environment
- USB drive mounted as U:, store scripts and wim image file
- Target disk is disk 0 (modify disk number in CreatePartitions script if needed)

### Manual workflow (your original operation)
1. Run partition script:
```cmd
diskpart /s "U:\Script\CreatePartitions-UEFI-FFU.txt"


### Typical workflow for software deployment
1. Prepare target_hosts.txt, fill in host names or IP addresses
2. Modify placeholder configuration in DeploySoftwareSilent.ps1
3. Test single machine install first
4. Run RemoteBatchDeploy.ps1 for batch push
5. Run CheckSoftwareInstallStatus.ps1 to collect install result and export CSV

## Bash Scripts
### Precondition
- SSH key authentication recommended for batch remote execution
- rsync required for file_backup_sync.sh
- Install openssh-clients for ssh batch deploy

### Typical workflow for linux package deploy
1. Fill linux_hosts.txt with target host ip
2. Modify package url and package name in pkg_silent_install.sh
3. Test install on single host
4. Run ssh_batch_deploy.sh to push to multiple nodes
5. Run check_linux_software.sh to verify installation status

## Python Scripts
### Precondition
Python 3.6+. Most scripts only use standard library.
webhook_alert.py requires requests package: `pip install requests`

## Log & Report
All logs will be saved in configured log folder.
Batch deployment results can be parsed by deploy_report_parser.py.
