@echo off
:pt
:mn
title Count Recorder
cls
mode con cols=40 lines=20
"data\Fn.dll" Font 9
"data\Fn.dll" cursor 1
color a9
echo 1) Start Counting
echo 2) Help
echo 3) Exit
"data\Fn.dll" kbd
set choic=0
if %errorlevel%==49 set choic=1
if %errorlevel%==50 set choic=2
if %errorlevel%==51 set choic=3
if %choic%==1 goto stsstssrr
if %choic%==2 goto helpwithit
if %choic%==3 exit
cls
goto mn
:stsstssrr
title Counting...
cls
set /a x=0
set /a u=1
"data\Fn.dll" cursor 0
:a
cls
echo %x%
"data\Fn.dll" kbd
set yy=%errorlevel%
if %yy%==32 set /a x=%x%+%u%
if %yy%==8 set /a x=%x%-%u%
if %yy%==327 set /a u=%u%+1
if %yy%==335 set /a u=%u%-1
if %yy%==13 call :procinit write
if %yy%==337 call :procinit read
if %yy%==338 call :procinit delete
if %yy%==326 call :procinit reset
if %yy%==315 call :procinit custom
if %yy%==27 goto mn

goto a

:ppp
if exist temp2.vbs del /f /q temp2.vbs >nul
:: 0) OK button
:: 1) OK and CANCEL
:: 2) ABORT, RETRY, and IGNORE
:: 3) YES, NO, and CANCEL
:: 4) YES and NO
:: 5) RETRY and CANCEL
:: And
:: 16) Critical Message Icon
:: 48) Warning Message Icon
:: 32) Question Mark Icon
:: 64) Information Icon
echo x=msgbox("%~1",%3+%4,"%~2") > "temp2.vbs"
if "%5" == "" temp2.vbs && del /f /q temp2.vbs >nul
if "%5" == "0" start temp2.vbs
goto :eof

:undone
call :ppp "Press the Spacebar to add and the Backspace button to subtract value 'x' to/from the displayed number. Press Enter/Return to add and Escape to subtract 1 to/from the value 'x', which is used by the Spacebar and the Backspace to add to and subtract from the displayed value. The default number for the value 'x' is 1." "Help" 0 64

call :ppp "E. g. If I press the Spacebar after starting the application, the displayed number, which was 0, will have the value 'x' added to it, making it 1. If I press Enter/Return, the value 'x' will get 1 added to it, making it 2. And then, if I press the Spacebar, the displayed number, which was 1, will get the value 'x' added to it, making it 3. Now, if I press the Backspace button, the displayed number will get the value 'x' subtracted from it, making it 1. Now if I press Escape, the value 'x' will get 1 subtracted from it, making it 1. Now, if I press the Backspace, the displayed number, which was 1, will get the value 'x' subtracted from it, making it 0." "Example" 0 64


goto mn

:mkdn
echo set stat=n>done.dat
goto :eof

:helpwithit
"Help.chm"
goto mn

:procinit
if "%~1"=="read" goto pread
if "%~1"=="write" goto pwrite
if "%~1"=="delete" goto pdelete
if "%~1%"=="reset" goto preset
if "%~1%"=="custom" goto pcust
goto :eof

:pcust
cls
echo Editing the current count...
echo 1) OK
echo 2) Cancel
"data\Fn.dll" kbd
set chec=0
if %errorlevel%==49 set chec=1
if %errorlevel%==50 set chec=2
if %chec%==1 goto pcute
goto a

:pcute
cls
set /p "yy=Enter the new value: "
set /a x=yy
goto a


:pwrite
echo %x% > "data\num.dat"
goto a

:pread
if not exist "data\num.dat" goto :edoesntex
set /p snum=<"data\num.dat"
set /a x=%snum%
goto a

:pdelete
cls
if not exist "data\num.dat" goto a
echo Press Y to delete the saved data.
"data\Fn.dll" kbd
set r=%errorlevel%
if %r%==89 del /f /q "data\num.dat" >nul
if %r%==121 del /f /q "data\num.dat" >nul
goto a

:preset
set /a x=0
goto a

:edoesntex
call :ppp "No data saved yet!" "Error" 0 16
goto a

:eof