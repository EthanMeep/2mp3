@echo off
:Main
title 2MP3 v1.4 by Nightsanity
setlocal
cd "%~d0%~p0"
color 0a
if not exist "downloads" md "downloads"
if not exist "bin\youtube-dl.exe" "bin\wget.exe" https://yt-dl.org/downloads/latest/youtube-dl.exe -O "bin\youtube-dl.exe" & title 2MP3 v1.4 by Nightsanity
cls
type "bin\copyright.txt"
echo.
if exist "bin\proxy.txt" (
for /f "delims=" %%I in (bin\proxy.txt) do endlocal & set proxy=%%I
)
set YTDL=bin\youtube-dl.exe
set ffmpeg=bin\ffmpeg.exe
set URL=
echo Paste Url:
set /p URL=""
if "%URL%"=="" start "" "downloads" & endlocal & goto Main
if "%URL%"=="u" goto Update
if "%URL%"=="x" goto ForceUpdate
if "%URL%"=="h" goto HelpInfo
if "%URL%"=="f" call :FileInput
if "%URL%"=="p" start "" "bin\proxy.txt" & echo Press enter when done editing... & pause >nul & endlocal & goto Main
(echo "%URL%" | findstr /i /c:".xml" >nul) && (goto XML) || (echo. >nul)
(echo "%URL%" | findstr /i /c:"vevo" >nul) && (goto Vevo) || (echo. >nul)
(echo "%URL%" | findstr /i /c:"vimeo" >nul) && (goto Vimeo) || (echo. >nul)
(echo "%URL%" | findstr /i /c:"dailymotion" >nul) && (goto Dailymotion) || (echo. >nul)
(echo "%URL%" | findstr /i /c:"nicovideo" >nul) && (goto Nicovideo) || (echo. >nul)
(echo "%URL%" | findstr "dropbox" | findstr ".mp3" >nul) && (goto Dropbox) || (echo. >nul)
(echo "%URL%" | findstr /i /c:"youtu" >nul) && (goto YouTube) || (echo. >nul)
(echo "%URL%" | findstr /i /c:"soundcloud" >nul) && (goto Soundcloud) || (echo. >nul)
endlocal & goto Main
:XML
"%YTDL%" -o "%%(title)s.%%(ext)s" "%URL%"
move /Y "*.mp3" "downloads" > NUL 2>&1
pause
endlocal & goto Main
:Vimeo
"%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 "%URL%"
move /Y "*.mp3" "downloads" > NUL 2>&1
pause
endlocal & goto Main
:Vevo
"%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 "%URL%"
move /Y "*.mp3" "downloads" > NUL 2>&1
pause
endlocal & goto Main
:Dailymotion
"%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 "%URL%"
move /Y "*.mp3" "downloads" > NUL 2>&1
pause
endlocal & goto Main
:Nicovideo
set HOME=%~d0%~p0
if not exist ".netrc" (
echo.
echo machine niconico>>.netrc
echo login test@gmail.com>>.netrc
echo password abc123>>.netrc
echo Press ENTER to add login credentials...
pause >nul
Start notepad ".netrc"
)
:LOOP
tasklist | find /i "notepad" >nul 2>&1
IF ERRORLEVEL 1 (
  GOTO CONTINUE
) ELSE (
  cls
  echo Replace email and password.
  echo Waiting for notepad to exit...
  GOTO LOOP
)
:CONTINUE
"%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 --netrc "%URL%"
move /Y "*.mp3" "downloads" > NUL 2>&1
pause
endlocal & goto Main
:Dropbox
"%YTDL%" -o "%%(title)s.%%(ext)s" "%URL%"
move /Y "*.mp3" "downloads" > NUL 2>&1
pause
endlocal & goto Main
:Soundcloud
"%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 "%URL%"
move /Y "*.mp3" "downloads" > NUL 2>&1
pause
endlocal & goto Main
:YouTube
"%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 "%URL%"
if not exist "*.mp3" (
echo.
echo Fuck You grabing alternative audio stream...
(echo "%URL%" | findstr /i /c:"youtu.be" >nul) && (goto alt_url) || (goto default_url)
:default_url
set result=%URL:www.youtube.com=playit.pk% & goto alt_stream
:alt_url
set result=%URL:youtu.be/=playit.pk/watch?v=% & goto alt_stream
:alt_stream
"%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 "%result%"
)
if not exist "*.mp3" echo. & echo Trying Proxy... & "%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 --proxy "%proxy%" "%URL%"
move /Y "*.mp3" "downloads" > NUL 2>&1
pause
endlocal & goto Main
:Update
cls
"bin\youtube-dl.exe" --update & timeout /t 5 > nul & pause
endlocal & goto Main
:ForceUpdate
del "bin\youtube-dl.exe" 2>NUL
endlocal & goto Main
:FileInput
del "%temp%\fileinput.exe" 2>NUL
setlocal enabledelayedexpansion
set chooser=%temp%\fileinput.exe
>"%temp%\c.cs" echo using System;using System.Windows.Forms;
>>"%temp%\c.cs" echo class dummy{[STAThread]
>>"%temp%\c.cs" echo public static void Main^(^){
>>"%temp%\c.cs" echo OpenFileDialog f= new OpenFileDialog^(^);
>>"%temp%\c.cs" echo f.InitialDirectory=Environment.CurrentDirectory;
>>"%temp%\c.cs" echo f.RestoreDirectory = true;
>>"%temp%\c.cs" echo string formats = "txt files (*.txt)|*.txt|All files (*.*)|*.*" ;
>>"%temp%\c.cs" echo f.Filter= formats;
>>"%temp%\c.cs" echo f.Multiselect = false;
>>"%temp%\c.cs" echo f.ShowHelp=true;
>>"%temp%\c.cs" echo f.ShowDialog^(^);
>>"%temp%\c.cs" echo foreach ^(String filename in f.FileNames^) {
>>"%temp%\c.cs" echo     Console.WriteLine^(filename^);
>>"%temp%\c.cs" echo         }
>>"%temp%\c.cs" echo     }
>>"%temp%\c.cs" echo  }
for /f "delims=" %%I in ('dir /b /s "%windir%\microsoft.net\*csc.exe"') do (
if not exist "!chooser!" "%%I" /nologo /out:"!chooser!" "%temp%\c.cs" 2>NUL
)
del "%temp%\c.cs"
setlocal disabledelayedexpansion	
for /f "delims=" %%I in ('%chooser%') do endlocal & set InputFile=%%~I
if "%InputFile%"=="" goto:eof
echo File Input: %InputFile%
echo.
setlocal enabledelayedexpansion
for /f "tokens=*" %%a in ('type "%InputFile%"') do (
set line=%%a
(echo "!line!" | findstr /i /c:"vevo" >nul) && ("%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 "!line!") || (echo. >nul)
(echo "!line!" | findstr /i /c:"vimeo" >nul) && ("%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 "!line!") || (echo. >nul)
(echo "!line!" | findstr /i /c:"dailymotion" >nul) && ("%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 "!line!") || (echo. >nul)
(echo "!line!" | findstr "dropbox" | findstr ".mp3" >nul 2>&1) && ("%YTDL%" -o "%%(title)s.%%(ext)s" "!line!") || (echo. >nul)
(echo "!line!" | findstr /i /c:"nicovideo" >nul) && ("%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 --netrc "!line!") || (echo. >nul)
(echo "!line!" | findstr /i /c:"youtu" >nul) && ("%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 "!line!") || (echo. >nul)
(echo "!line!" | findstr /i /c:"soundcloud" >nul) && ("%YTDL%" -o "%%(title)s.%%(ext)s" --extract-audio --audio-format mp3 --audio-quality 0 "!line!") || (echo. >nul)

)
move /Y "*.mp3" "downloads" > NUL 2>&1
if "!line!"=="" echo [Error]: Text file is empty...
pause
goto:eof
:HelpInfo
cls
type "bin\readme.txt"
echo.
pause
endlocal & goto Main