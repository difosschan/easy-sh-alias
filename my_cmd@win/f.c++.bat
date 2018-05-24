@xfind . -type f | grep -E ".*\.(cpp|hpp|c|h|cxx|hxx|cc|hh)$" | xargs grep --color=auto -n %*
