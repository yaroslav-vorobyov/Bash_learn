#!/usr/bin/env bash
# 
# Replace single quotes by double quotes in ~/.bash_aliases + remove '\'
# Needed when alias > /path/to/file, double quotes from beginning replaced to single quotes
# 
# example No.1:
# alias al_bak='cp ~/.bash_aliases ~/.bash_aliases.bak --force && echo; echo '\''.bash_aliases saved!'\'''
# converts to:
# alias al_bak="cp ~/.bash_aliases ~/.bash_aliases.bak --force && echo; echo '.bash_aliases saved!'"
#
# example No.2:
# alias cron_bak='crontab -l > ~/.crontab/tasks_backup.txt && echo; echo '\''Crontab tasks saved!'\'''
# converts to:
# alias cron_bak="crontab -l > ~/.crontab/tasks_backup.txt && echo; echo 'Crontab tasks saved!'"
# 
# add to ~/.bash_aliases:
# echo 'source ~/.scripts/functions/replace_quotes.sh' >> ~/.bash_aliases

function al_quo() {
    sed -i "s/='/=\"/g; s/'$/\"/g; s/'\\\'//g" ~/.bash_aliases
}
