# easy-sh-alias

Easy shell alias for developer.

## How to install

```bash
./install.sh
```

Run `install.sh`  directly !

## How to use

Run `alias`  to see aliases this package add. Here are some common aliases:

- `b.rc`

  **alias:** `vim $HOME/.bashrc && srouce $HOME/.bashrc`

  **purpose:** Edit `~/.bahsrc` and run `source ~/.bashrc` after you save it.

-  `b.alias`

  **alias:** `vim $DIFOSS_ENV_BASE/my_alias && source $DIFOSS_ENV_BASE/my_alias`

  **purpose:**   Edit easy-sh-alias file ( for improvement ).

-  ``f.c++``

  **alias:** `find . -type f -print0 | grep --color=no -zaiE ".*\.(cpp|hpp|c|h|hh|cxx|cc)$" | xargs -0 grep -aHn --color=$COLOR_FLAG`

  **purpose:** Quick find for c++ source files and header files.

-  `f.cpp`

  **alias:** `find . -type f -print0 | grep --color=no -zaiE ".*\.(cpp|c|cxx|cc)$" | xargs -0 grep -aHn --color=$COLOR_FLAG`

  **purpose:** Quick find for c++ source files.

-  ``f.gosrc`

  **alias:**  `find . -path "./vendor/*" -prune -o -name "*.go" -type f -print0 | xargs -0 grep -aHn --color=$COLOR_FLAG` 

  **purpose:** Quick find for go source files excluding `./vendor` directory.

-  `-`

  **alias:** `cd -`

  **purpose:** Jump to the previous directory.

-  `..`

  **alias:** `cd ../..`

  **purpose:** 

-  `...`

  **alias:** `cd ../..`

  **purpose:**   Jump to the upper  2 level directory.

-  `....`

  **alias:** `cd ../../..`

  **purpose:**   Jump to the upper  3 level directory.

And some useful functions:

-  `mkcd`

  **purpose:** `mkdir` & `cd` in it.

-  `__df_change_go_version`

   **purpose:** Change go version

   **precondition:** 

   1. Decompress `go-x.y.z.tar.gz`  into ``/data/go-x.y.x`` 
   2. `mkdir /data/gopath-x.y.z`

   So, You can make alias as follow to use the function like follow:

   ```bash
   alias go1.10.3='__df_change_go_version 1.10.3'
   alias go1.12.7='__df_change_go_version 1.12.7'
   alias go1.13.3='__df_change_go_version 1.13.3'
   ```


 More features waiting for you to create. Enjoy it :-) 

