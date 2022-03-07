@echo off

:loop

rem Determine if Elden Ring is running
tasklist /fi "ImageName eq eldenring.exe" /fo csv 2>NUL | find /I "eldenring.exe">NUL

rem Save the current datetime to a var https://stackoverflow.com/a/203116
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c_%%a_%%b)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a_%%b)
set mydatetime="%mydate%__%mytime%"

rem If Elden Ring is running...
if "%ERRORLEVEL%"=="1" (
	rem Set up a folder name for our new backup
	SET stamp=backup-%mydatetime%.zip

	rem Back up with Windows 10's 'tar.exe' https://superuser.com/a/1473257
	tar.exe -a -cf "%stamp%" "%USERPROFILE%\AppData\Roaming\EldenRing" 2> NUL

	rem Back up with 7zip
	rem "C:\Program Files\7-Zip\7z.exe" a -tzip "%stamp%" "%USERPROFILE%\AppData\Roaming\EldenRing" > NUL

	echo [%TIME%] Backed up to %stamp%
) else (
	echo [%TIME%] Not running...
)

rem sleep for 30 minutes https://serverfault.com/a/432323
timeout /t 1800 /nobreak
rem powershell -command "Start-Sleep -s 1800"    https://stackoverflow.com/a/16803409

goto loop