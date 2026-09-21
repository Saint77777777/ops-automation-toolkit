# ops-automation-toolkit
English: Personal collection of sysadmin & DevOps automation scripts. Written during internship practice. All scripts are generic, for learning demonstration only. No internal enterprise data or confidential information included. Not affiliated with any employer.

中文：个人运维自动化脚本合集，实习期间练习编写。所有脚本均为通用功能，仅用于学习演示；不含企业内部业务、敏感数据，与实习单位无关联。

## Script List 脚本清单
| File Name 文件名 | Description 功能说明 |
| ---- | ---- |
| powershell/DiskVolumeMonitor.ps1 | Disk usage monitor with daily log rotation. 磁盘使用率监控，日志按日期滚动 |
| powershell/ServiceHealthCheck.ps1 | Windows service health inspection, optional auto-restart. Windows服务健康巡检，可选自动重启 |
| bash/linux_resource_check.sh | Linux server CPU / Memory / Disk resource check. Linux服务器CPU、内存、磁盘资源巡检 |
| python/remote_host_ping_check.py | Batch host ping connectivity test. 批量主机ping连通性探测 |

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
