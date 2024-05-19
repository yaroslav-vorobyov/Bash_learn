#!/usr/bin/env bash
# Backup crontab tasks
# 
# Next rows 'starting with' are exported (only lines which are not commented with one dash, #):
# 1) from *
# 2) from digit
# 3) from ## (two dashes)
# 4) empty rows (they are dividers between sections)

crontab -l | grep -e '^\(@\|$\|\*\|##\|[0-9]\)' > ~/.crontab/tasks_backup.txt
