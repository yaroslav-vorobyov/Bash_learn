#!/usr/bin/env bash
# 
# add to ~/.bashrc :
# echo 'source ~/.scripts/addons/hstr.sh' >> ~/.bashrc
# 
## HSTR configuration
## HSTR (HiSToRy) is a command line utility that brings improved bash/zsh command completion from the history.
## https://github.com/dvorka/hstr/tree/master
# 
# https://github.com/dvorka/hstr/blob/master/CONFIGURATION.md#alias
alias hs=hstr                       # hh alias to hstr is default

# https://github.com/dvorka/hstr/blob/master/CONFIGURATION.md#hstr-config-options
# get more colors
# show the prompt at the bottom of the screen (instead at the top)
# show normal history by default (instead of 'metrics-based view', which is default)
# use substring based matching
# keep duplicates in 'raw-history-view' (duplicate commands are discarded by default)
# do not prompt for confirmation when deleting history items
export HSTR_CONFIG=hicolor,prompt-top,raw-history-view,substring-matching,duplicates,no-confirm

# https://github.com/dvorka/hstr/blob/master/CONFIGURATION.md#environment-variables
export HSTR_IS_SUBSHELL=1           # when HSTR is used in a subshell, set to 1 to fix output when pressing TAB or RIGHT arrow key

# ensure synchronization between bash memory and history file
# export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"

# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then 
    bind '"\C-r": "\C-a hstr -- \C-j"'
fi

# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then 
    bind '"\C-xk": "\C-a hstr -k \C-j"'
fi