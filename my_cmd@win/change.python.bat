@echo off

:init
set PYTHON_27_HOME=D:\develop_tools\Python27
set PYTHOH_36_HOME=D:\develop_tools\python-3.6.1-embed-amd64

:start
echo ��ǰpython�汾:
python -c "import platform,sys; print (platform.architecture()[0] + '\\n' + sys.version)"

echo.
echo =============================================
echo python�汾�б�
echo 2: python2.7
echo 3: python3.6
echo =============================================

:select
set /p opt=��ѡ��python�汾��
if %opt%==2 (
setx PYTHON_HOME "%PYTHON_27_HOME%" -m
rem reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PYTHON_HOME /t reg_sz /d "%PYTHON_27_HOME%" /f
goto success
)
if %opt%==3 (
setx PYTHON_HOME "%PYTHOH_36_HOME%" -m
rem reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PYTHON_HOME /t reg_sz /d "%PYTHOH_36_HOME%" /f
goto success
)
echo ѡ��İ汾����,������ѡ��
PAUSE
goto start

:success
echo.
echo ���û������˳ɹ�.
rem python -c "import platform,sys; print (platform.architecture()[0]); print(sys.version)"
