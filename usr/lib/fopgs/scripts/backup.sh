#!/bin/bash
# This script creates daily, weekly, and monthly backups of specified directories.
# It uses tar to create compressed archives and stores them in a specified backup root directory.
BACKUP_ROOT="/mnt/backup"  
SOURCE_DIRS=("/etc" "/home/home/fopgs" "/usr/local/bin" "/root" "/var/lib" "/var/log" "/var/www/html") 
LOG_FILE="/var/log/backup.log"  
DAY_OF_WEEK=$(date +%A | tr '[:upper:]' '[:lower:]')
DAY_OF_MONTH=$(date +%d)                            
MONTH=$(date +%b | tr '[:upper:]' '[:lower:]')
for DIR in daily weekly monthly; do
    if [ ! -d "$BACKUP_ROOT/$DIR" ]; then
        echo -e "Source directory "$DIR" does not exist..\n\rCreating "$DIR" now..."
        mkdir -p "$BACKUP_ROOT"/"$DIR"
    fi
done      
create_backup() {
    local backup_type=$1
    local backup_dir=$2
    local temp_dir=$(mktemp -d)
    for dir in "${SOURCE_DIRS[@]}"; do
        cp -a "$dir" "$temp_dir/"
    done
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local archive_name="backup_${timestamp}.tar.gz"
    tar -czvf "$backup_dir/$archive_name" -C "$temp_dir" .
    
    rm -rf "$temp_dir"
    
    echo "$(date) - Created $backup_type backup: $backup_dir/$archive_name" >> "$LOG_FILE"
}
daily_dir="$BACKUP_ROOT/daily/$DAY_OF_WEEK"
mkdir -p "$daily_dir"
rm -f "$daily_dir"/*.tar.gz  
create_backup "daily" "$daily_dir"
if [[ "$DAY_OF_MONTH" =~ ^(01|08|15|23|30)$ ]]; then
    weekly_dir="$BACKUP_ROOT/weekly/$DAY_OF_MONTH"
    mkdir -p "$weekly_dir"
    rm -f "$weekly_dir"/*.tar.gz  
    create_backup "weekly" "$weekly_dir"
fi
if [[ "$(date +%d)" == "01" ]]; then
    monthly_dir="$BACKUP_ROOT/monthly/$MONTH"
    mkdir -p "$monthly_dir"
    rm -f "$monthly_dir"/*.tar.gz 
    create_backup "monthly" "$monthly_dir"
fi