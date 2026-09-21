#!/bin/bash
# Linux resource health check script
# Personal practice, for learning only

# config
THRESHOLD_MEM=85
THRESHOLD_DISK=85
LOG_DIR="/var/ops_log"
LOG_FILE="${LOG_DIR}/resource_$(date +%Y%m%d).log"

mkdir -p ${LOG_DIR}
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

echo "[${TIMESTAMP}] Start resource check" >> ${LOG_FILE}

# cpu usage
CPU_USE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
CPU_USE=$(printf "%.2f" $CPU_USE)
echo "[${TIMESTAMP}] CPU Usage: ${CPU_USE}%" >> ${LOG_FILE}

# memory usage
MEM_RAW=$(free | awk '/Mem/{printf "%.2f", $3/$2 *100}')
echo "[${TIMESTAMP}] Memory Usage: ${MEM_RAW}%" >> ${LOG_FILE}
if (( $(echo "$MEM_RAW > $THRESHOLD_MEM" | bc -l) )); then
    echo "[${TIMESTAMP}] ALERT: Memory exceed threshold ${THRESHOLD_MEM}%" >> ${LOG_FILE}
fi

# disk check
df -h | awk 'NR>1 && $1 !~ /tmpfs|loop/ {print $5,$1}' | while read -r line; do
    USE=$(echo $line | cut -d% -f1)
    DEV=$(echo $line | cut -d' ' -f2)
    if [ $USE -ge $THRESHOLD_DISK ];then
        echo "[${TIMESTAMP}] ALERT: Disk $DEV usage ${USE}% over threshold" >> ${LOG_FILE}
    fi
done

echo "[${TIMESTAMP}] Check done" >> ${LOG_FILE}
echo "" >> ${LOG_FILE}
