<#
.SYNOPSIS
Simple disk volume monitor for Windows server, log to file and alert when usage exceed threshold.
AUTHOR: personal practice, for learning only
#>

$threshold = 85
$logRoot = "C:\ops_logs"
$logFile = Join-Path -Path $logRoot -ChildPath "disk_monitor_$(Get-Date -Format 'yyyyMMdd').log"

# create log folder if not exist
if (-not (Test-Path $logRoot)){
    New-Item -ItemType Directory -Path $logRoot | Out-Null
}

$timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"[$timeStamp] Start disk volume check" | Out-File $logFile -Append

# iterate fixed drives only, skip cd-rom
Get-Volume | Where-Object {
    $_.DriveLetter -and $_.SizeRemaining -and $_.DriveType -eq 'Fixed'
} | ForEach-Object {
    $driveLetter = $_.DriveLetter
    $totalSize = $_.Size
    $freeSize = $_.SizeRemaining
    $usedPercent = (($totalSize - $freeSize) / $totalSize) * 100
    $usedPercent = [math]::Round($usedPercent,2)

    $msg = "Drive $driveLetter : Used $usedPercent %"
    if ($usedPercent -ge $threshold){
        $msg = "ALERT! $msg , threshold: $threshold%"
        Write-Host $msg -ForegroundColor Red
    }else{
        Write-Host $msg -ForegroundColor Green
    }
    "[$timeStamp] $msg" | Out-File $logFile -Append
}

"[$timeStamp] Check finished`n" | Out-File $logFile -Append
