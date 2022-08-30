#!/bin/bash

# check whether $DIFOSS_ENV_BASE environment variable
if [ $DIFOSS_ENV_BASE ];then
    echo 'easy-sh-alias seems to be installed ($DIFOSS_ENV_BASE exists).'
    exit 0
fi

tmp_file=/etc/profile.d/easy-sh-alias.sh

# append content of `bashrc_increment.template` to `/etc/profile.d`,
# and replace current path instead of string "{{REALPATH_OF_PWD}}"
if [ -f "$tmp_file" ]; then
    echo "easy-sh-alias had already installed on <$DIFOSS_ENV_BASE>."
	exit 0
else
    cat bashrc_increment.template >> "$tmp_file"
    sed -i "s#{{REALPATH_OF_PWD}}#$PWD#g" "$tmp_file"
    source "$tmp_file"
    echo easy-alias-sh install done !
fi
