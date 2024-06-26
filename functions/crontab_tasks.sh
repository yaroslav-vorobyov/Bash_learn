#!/usr/bin/env bash
# 
# Color output for all cron tasks and all users
# 
# add to ~/.bash_aliases:
# echo 'source ~/.scripts/functions/crontab_tasks.sh' >> ~/.bash_aliases

function allcrontab() {
    # Set colors
    # red='\e[0;31m'
    RED='\e[1;31m'
    # green='\e[0;32m'
    GREEN='\e[1;32m'
    NC='\e[0m'

    for user in $(cut -d':' -f1 /etc/passwd); do
        usercrontab=$(crontab -l -u ${user} 2> /dev/null)
            if [ -n "${usercrontab}" ]; then
                echo -e "${RED}====== Start crontab for user ${NC}${GREEN}${user}${NC} ${RED}======${NC}"
                crontab -l -u ${user} | sed '/ *#/d; /^ *$/d'
                echo -e "${RED}====== End crontab for user ${NC}${GREEN}${user}${NC} ${RED}========${NC}\n"
            fi
        done
}
