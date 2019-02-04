:: Define Variables
SET /p target="Enter target system name:- "

::copy PSExec to Local
MD "c:\pstools"
xcopy "\\<server>\<share>\pstools" "C:\pstools" /y

:: Check for previous install and remove ?

:: Set Path
cd C:\pstools

::Map System \ admin permission
net use \\%target%\c$ /user:<username> <password>
Copy \\<server>\<share>\ultraVNC.exe \\%target%\c$ /y

:: Install VNC
psexec \\%target% -u admin -p P(@dm)n c:\ultravnc.exe /verysilent

:: Copy .ini config file
Copy \\<server>\<share>\ultraVNC.ini "\\%target%\c$\Program Files (x86)\uvnc bvba\UltraVNC" /y

:: Set VNC to Run as a system service
psexec \\%target% -u admin -p P(@dm)n "C:\Program Files (x86)\uvnc bvba\UltraVNC\WinVNC.exe" -install

:: Set VNC to Run as a system service
sc \\%target% start uvnc_service start= auto

Echo UltraVNC Installed

Pause