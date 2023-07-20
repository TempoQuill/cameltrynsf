@echo off

echo Assembling...
tools\asm6f.exe cameltry.asm -n -c -L %* bin\cameltry.nsf > bin\assembler.log
if %ERRORLEVEL% neq 0 goto buildfail
move /y cameltry.lst bin > nul
move /y cameltry.cdl bin > nul
echo Done.
echo.

echo SHA1 hash check:
echo 47ba60fad332fdea5ae44b7979fe1ee78de1d316ee027fea2ad5fe3c0d86f25a PRG0
echo 6ca47e9da206914730895e45fef4f7393e59772c1c80e9b9befc1a01d7ecf724 PRG1
echo Yours:
certutil -hashfile bin\cameltry.nsf SHA256 | findstr /V ":"


goto end

:buildfail
echo The build seems to have failed.
goto end

:buildsame
echo Your built ROM and the original are the same.
goto end

:builddifferent
echo Your built ROM and the original differ.
echo If this is intentional, don't worry about it.
goto end


:end
echo on
