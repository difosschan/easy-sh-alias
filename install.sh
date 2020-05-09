#!/bin/bash

# check whether $DIFOSS_ENV_BASE environment variable
if [ $DIFOSS_ENV_BASE ];then
    echo 'easy-sh-alias seems to be installed ($DIFOSS_ENV_BASE exists).'
    exit 0
fi

# append content of `bashrc_increment.template` to `~/.bashrc`,
# and replace current path instead of string "{{REALPATH_OF_PWD}}"
cat bashrc_increment.template >> ~/.bashrc
sed -i "s#{{REALPATH_OF_PWD}}#$PWD#g" ~/.bashrc
source ~/.bashrc
echo easy-alias-sh install done !

