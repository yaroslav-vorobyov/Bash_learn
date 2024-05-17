#!/usr/bin/env bash
# Add alias to current profile
# $1 is name of alias
# $2 is command line with options
# 
# example with quotes, command line has single quotes
# $ adda up "sudo apt list --upgradable 2>/dev/null | tail +2 | cut -f 1 -d '/'"
# 
# add to ~/.bash_aliases:
# echo 'source ~/.scripts/functions/add_alias.sh' >> ~/.bash_aliases

function adda() {
    echo "alias $1=\"$2\"" >> ~/.bash_aliases
}
