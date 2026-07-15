@echo off
rem Launch Flush Rush. Edit GODOT below if Godot isn't on your PATH.
rem Typical install: C:\Godot\Godot_v4.5-stable_win64.exe

set GODOT=godot
where %GODOT% >nul 2>nul
if errorlevel 1 (
    if exist "C:\Godot\Godot_v4.5-stable_win64.exe" (
        set GODOT=C:\Godot\Godot_v4.5-stable_win64.exe
    ) else (
        echo Could not find Godot. Edit run.bat and set the GODOT path.
        exit /b 1
    )
)

"%GODOT%" --path "%~dp0" %*
