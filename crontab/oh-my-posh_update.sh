#!/usr/bin/env bash
# Update oh-my-posh (terminal visual prompt)

OH_MY_POSH_LOCAL=/usr/local/bin/oh-my-posh
OH_MY_POSH_ONLINE=https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64

online_md5="$(curl -sL $OH_MY_POSH_ONLINE | md5sum | cut -d ' ' -f 1)"
local_md5="$(md5sum $OH_MY_POSH_LOCAL | cut -d ' ' -f 1)"

if [[ $online_md5 != $local_md5 ]]
then
    # echo "Get update!"
    wget $OH_MY_POSH_ONLINE -O $OH_MY_POSH_LOCAL
    exit 0
fi

exit 1
