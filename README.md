# ops-automation-toolkit
English: Personal collection of sysadmin & DevOps automation scripts. Written during internship practice. All scripts are generic, for learning demonstration only. No internal enterprise data or confidential information included. Not affiliated with any employer.

中文：个人运维自动化脚本合集，实习期间练习编写。所有脚本均为通用功能，仅用于学习演示；不含企业内部业务、敏感数据，与实习单位无关联。

## Script List 脚本清单
| File Name 文件名 | Description 功能说明 |
| ---- | ---- |
| powershell/DiskVolumeMonitor.ps1 | Disk usage monitor with daily log rotation. 磁盘使用率监控，日志按日期滚动 |
| powershell/ServiceHealthCheck.ps1 | Windows service health inspection, optional auto-restart. Windows服务健康巡检，可选自动重启 |
| powershell/LogArchiveClean.ps1 | Archive old logs to zip and clean source files. 日志压缩归档并清理源文件 |
| powershell/FileIntegrityCheck.ps1 | SHA256 file hash check for tamper detection. SHA256文件哈希校验，检测篡改 |
| powershell/RemoteAssetCollect.ps1 | Collect Windows host asset info export to JSON. Windows主机资产信息采集导出JSON |
| bash/linux_resource_check.sh | Linux server CPU / Memory / Disk resource check. Linux服务器CPU、内存、磁盘资源巡检 |
| bash/log_rotate_clean.sh | Log rotate, compress and retain limited archives. 日志轮转压缩，保留指定归档数量 |
| bash/file_backup_sync.sh | Incremental directory backup by rsync. rsync增量目录备份 |
| bash/port_scan_check.sh | Collect listening port and process info. 监听端口与进程信息采集 |
| python/remote_host_ping_check.py | Batch host ping connectivity test. 批量主机ping连通性探测 |
| python/webhook_alert.py | Push alert message via webhook (WeCom). Webhook推送告警消息（企业微信） |
| python/dir_size_stats.py | Recursive subdirectory size statistics. 递归统计子目录占用大小 |
| python/log_error_scan.py | Scan log file for error keywords. 日志错误关键词检索 |

## Environment 运行环境
- PowerShell 5.1 / PowerShell Core
- Bash 4+
- Python3 (only standard library, no extra pip package required)

## Usage 使用说明
> Please run with sufficient permissions.
> 请使用足够权限执行脚本。
> Recommend schedule via Windows Task Scheduler / Linux crontab.
> 推荐搭配 Windows任务计划程序 / Linux crontab 定时运行。

## License
MIT
