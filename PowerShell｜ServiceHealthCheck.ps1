<#
.SYNOPSIS
Check status of target windows services, log status, optional auto restart.
#>

# modify service list to your target
$targetServices = @("W3SVC","Spooler")
$logRoot = "C:\ops_logs"
$logFile = Join-Path -Path $logRoot -ChildPath "svc_check_$(Get-Date -Format 'yyyyMMdd').log"

if (-not (Test-Path $logRoot)){
    New-Item -ItemType Directory -Path $logRoot | Out-Null
}

$timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"[$timeStamp] Start service health check" | Out-File $logFile -Append

foreach ($svcName in $targetServices){
    $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
    if (-not $svc){
        $msg = "WARNING: Service $svcName not found"
        Write-Host $msg -ForegroundColor Yellow
        "[$timeStamp] $msg" | Out-File $logFile -Append
        continue
    }

    if ($svc.Status -ne "Running"){
        $msg = "ALERT: $svcName stopped, try restart"
        Write-Host $msg -ForegroundColor Red
        "[$timeStamp] $msg" | Out-File $logFile -Append
        
        # comment below two lines if you don't want auto-restart
        Start-Service $svcName -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
        
        $svcAfter = Get-Service $svcName
        if ($svcAfter.Status -eq "Running"){
            $msgOk = "$svcName restart success"
            Write-Host $msgOk -ForegroundColor Green
            "[$timeStamp] $msgOk" | Out-File $logFile -Append
        }else{
            $msgFail = "$svcName restart failed"
            Write-Host $msgFail -ForegroundColor Red
            "[$timeStamp] $msgFail" | Out-File $logFile -Append
        }
    }else{
        $msg = "$svcName running normally"
        Write-Host $msg -ForegroundColor Green
        "[$timeStamp] $msg" | Out-File $logFile -Append
    }
}

"[$timeStamp] Service check finished`n" | Out-File $logFile -Append
