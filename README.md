# easy-sh-alias

Easy shell alias for developer.

## How to install

```bash
./install.sh
```

Run `install.sh`  directly !

## How to use

Run cmd `alias` to see aliases this package add. Here are some common aliases:

| alias name | command                                                      | purpose                                                      |
| ---------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `b.rc`     | `vim $HOME/.bashrc && source $HOME/.bashrc`                  | Edit `~/.bahsrc` and run `source ~/.bashrc` after you save it. |
| `b.alias`  | `vim $DIFOSS_ENV_BASE/my_alias && source $DIFOSS_ENV_BASE/my_alias` | Edit easy-sh-alias file ( for improvement ).                 |
| `f`        | `f.c++`                                                      | Quick find for my common programming language files ( c++).  |
| `f.cpp`    | `find . -type f -print0 | grep --color=no -zaiE ".*\.(cpp|hpp|c|h|hh|cxx|cc)$"|xargs -0 grep -aHn --color=$COLOR_FLAG` | Quick find for c++ source files.                             |
| `f.go`     | `find . -type f -print0 | grep --color=no -zaiE ".*\.(go)$" | xargs -0 grep -aHn --color=$COLOR_FLAG'` | Quick find for go source files.                              |
| `f.gosrc`  | `find . -path "./vendor/*" -prune -o -name "*.go" -type f -print0 | xargs -0 grep -aHn --color=$COLOR_FLAG` | Quick find for go source files excluse `./vendor` dir.       |
| `--`       | `cd -`                                                       | Jump to the previous directory.                              |
| `..`       | `cd ..`                                                      | Jump to the upper directory.                                 |
| `...`      | `cd ../..`                                                   | Jump to the upper 2 level directory.                         |
| `....`     | `cd ../../..`                                                | Jump to the upper  3 level directory.                        |
| `mkcd`     |                                                              | mkdir & `cd` in it.                                          |

More features waiting for you to create. Enjoy it :-) 

