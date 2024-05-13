#!/usr/bin/env bash
# Backup crontab tasks

crontab -l > .crontab/tasks_backup.txt
