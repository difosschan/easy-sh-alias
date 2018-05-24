@xfind . -type f | grep -E ".*\.(hpp|h|hxx|hh)$" | xargs grep --color=auto -n %*
