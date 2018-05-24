@echo off
REM for %%c in %* do echo %%c

for /F "delims="  %%c IN ("%*") DO echo %%c


set grep_E_str=''


REM xfind . -type f -prune | grep -E ".*\.(cpp|h)$" %1



