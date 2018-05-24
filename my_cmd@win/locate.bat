@echo off
FOR /F "delims=" %%i IN ("%1") DO (
   if not "%%i" == "" (echo %%~$PATH:i |grep -v ECHO) 
)
