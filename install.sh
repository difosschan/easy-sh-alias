#!/bin/bash

# check whether $DIFOSS_ENV_BASE environment variable
if [[ ! -z "$DIFOSS_ENV_BASE" ]]; then
    echo "easy-sh-alias seems to be installed oon <$DIFOSS_ENV_BASE>."
    exit 0
fi

tmp_file=/etc/profile.d/easy-sh-alias.sh

# append content of `bashrc_increment.template` to `/etc/profile.d`,
# and replace current path instead of string "{{REALPATH_OF_PWD}}"
if [ ! -f "$tmp_file" ]; then
    cat bashrc_increment.template >> "$tmp_file"
    sed -i "s#{{REALPATH_OF_PWD}}#$PWD#g" "$tmp_file"
fi

if [[ x"$USER" = 'xroot' ]]; then
    source "$tmp_file"
else
    IFS=$'\n'
    for line in `cat $tmp_file`; do
        echo $line >> ~/.bashrc
    done

    source ~/.bashrc
fi

echo easy-alias-sh install done !

