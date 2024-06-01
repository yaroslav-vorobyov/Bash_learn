#!/usr/bin/env bash
# 
# Print for perl-scipts called as commands. 
# 
# Variables:
# $1 - path to command
# $2 - delimiter to 'cut'-command
# $3 - grep column by 'cut'-command
# 
# add to ~/.bash_aliases:
# echo 'source ~/.scripts/functions/cat_command.sh' >> ~/.bash_aliases

function catty () {
    COMMAND=$1
    DELIMITER=${2:-' '}
    COLUMN=${3:-2}
    cat $(whereis $COMMAND | cut -d "$DELIMITER" -f $COLUMN)
}
