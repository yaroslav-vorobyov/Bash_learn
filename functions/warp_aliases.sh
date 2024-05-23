#!/usr/bin/env bash
# 
# Backup ~/.bash_aliases or any other file if it's provided as $1 env
# 
# add to ~/.bash_aliases:
# echo 'source ~/.scripts/functions/warp_aliases.sh' >> ~/.bash_aliases

function al_bak () {
    FILE=~/.bash_aliases
    # FILE=~/test
    ALIASES=${1:-$FILE}

    # if file has a size greater than zero OR backup is absent
    if [[ -s $ALIASES ]] || [[ ! -e $ALIASES.bak ]]; then
        # check if ALIAS.bak existing
        if [[ -e $ALIASES.bak ]]
        then 
            # if ALIAS.bak bigger than ALIAS by size then make bak2-precopy just in case over .bak
            if [[ $(stat -c %s $ALIASES.bak) -gt $(stat -c %s $ALIASES) ]]
            then
                echo "Making precopy of .bak to prevent losses! Check .bak2 as soon as it possible!"
                yes | cp $ALIASES.bak $ALIASES.bak2
                echo
            fi
        fi
        echo "Making copy!"
        yes | cp $ALIASES $ALIASES.bak
        echo
        echo "$ALIASES saved!"
    # if ALIAS has zero size - restore it
    else
        echo "Restoring the file!"
        yes | cp $ALIASES.bak $ALIASES
        echo
        echo "$ALIASES restored from backup!"
    fi
}   