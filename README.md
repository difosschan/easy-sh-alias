# easy-sh-alias

Easy shell alias for developer.

## For Linux User

Modify **first line** of file `.bashrc-example` in Project Diretory to indent this directory, and copy into `~/.bashrc` .

## For Cygwin/Msys2 User

If you don't use `~/.bashrc` yet, modify **first line** of file `.bashrc-example` in Project Diretory as follow:

```bash
export DIFOSS_ENV_BASE='/opt/easy-sh-alias'   # Modify here !

if [ $DIFOSS_ENV_BASE ]; then
    if [ -f $DIFOSS_ENV_BASE/my_alias ]; then
        source $DIFOSS_ENV_BASE/my_alias
    fi

    # Add user intimate aliases and functions in .privacy/__init__.sh
    if [ -f $DIFOSS_ENV_BASE/.privacy/__init__.sh ]; then
        source $DIFOSS_ENV_BASE/.privacy/__init__.sh
    fi

fi
```

And copy it into `%HOMEPATH%/.bashrc` .

Or use  `mklink.exe` command in `Windows Shell (cmd)`  as follow:

```cmd
mklink.exe %HOMEPATH%\.bashrc D:\easy-sh-alias\.privacy\.bashrc
```

