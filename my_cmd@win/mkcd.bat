@echo OFF
if not %1=="" (
    echo mkdir and enter directory %1 
    echo %~n1
    python -c "import os,sys; os.mkdir(' '.join(sys.argv[1:]));" "%~n1"
    cd "%1"
)
