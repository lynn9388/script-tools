REM Please update the variables below before you run it
SET ethernet-adapter-name=Ethernet
SET wifi-adapter-name=Wi-Fi
SET ethernet-static-ip=192.168.1.90
SET wifi-static-ip=192.168.1.90

@echo off
cls
color 0A

:check_Permissions
fsutil dirty query %systemdrive% >nul
if %errorLevel% == 0 (
    goto loop
) else (
    echo ######
    echo #     # #      ######   ##    ####  ######    #####  #    # #    #      ##    ####
    echo #     # #      #       #  #  #      #         #    # #    # ##   #     #  #  #
    echo ######  #      #####  #    #  ####  #####     #    # #    # # #  #    #    #  ####
    echo #       #      #      ######      # #         #####  #    # #  # #    ######      #
    echo #       #      #      #    # #    # #         #   #  #    # #   ##    #    # #    #
    echo #       ###### ###### #    #  ####  ######    #    #  ####  #    #    #    #  ####
    echo=
    echo    #    ######  #     # ### #     # ###  #####  ####### ######     #    ####### ####### ######     ### ###
    echo   # #   #     # ##   ##  #  ##    #  #  #     #    #    #     #   # #      #    #     # #     #    ### ###
    echo  #   #  #     # # # # #  #  # #   #  #  #          #    #     #  #   #     #    #     # #     #    ### ###
    echo #     # #     # #  #  #  #  #  #  #  #   #####     #    ######  #     #    #    #     # ######      #   #
    echo ####### #     # #     #  #  #   # #  #        #    #    #   #   #######    #    #     # #   #
    echo #     # #     # #     #  #  #    ##  #  #     #    #    #    #  #     #    #    #     # #    #     ### ###
    echo #     # ######  #     # ### #     # ###  #####     #    #     # #     #    #    ####### #     #    ### ###
    pause
    Exit
)

:loop
echo 1 DHCP %ethernet-adapter-name%
echo 2 Static %ethernet-adapter-name% (%ethernet-static-ip%)
echo 3 DHCP %wifi-adapter-name%
echo 4 Static %wifi-adapter-name% (%wifi-static-ip%)
echo 5 Show IP Configuration
echo 6 Exit
echo|set /p=Please choose a option:

set/p sel=
if "%sel%"=="1" goto DHCP-Ethernet
if "%sel%"=="2" goto Static-Ethernet
if "%sel%"=="3" goto DHCP-Wifi
if "%sel%"=="4" goto Static-Wifi
if "%sel%"=="5" goto Show-IP-Configuration
if "%sel%"=="6" EXIT
echo=
echo Please choose a valid option
goto loop

:DHCP-Ethernet
netsh interface ip set address name=%ethernet-adapter-name% source=dhcp
netsh interface ip delete dns %ethernet-adapter-name% all
ipconfig /flushdns
goto Show-IP-Configuration

:Static-Ethernet
netsh interface ip set address name=%ethernet-adapter-name% source=static addr=%ethernet-static-ip% mask=255.255.255.0 gateway=192.168.1.1
netsh interface ip set dns name=%ethernet-adapter-name% source=static addr=192.168.1.1
ipconfig /flushdns
goto Show-IP-Configuration

:DHCP-Wifi
netsh interface ip set address name=%wifi-adapter-name% source=dhcp
netsh interface ip delete dns %wifi-adapter-name% all
ipconfig /flushdns
goto Show-IP-Configuration

:Static-Wifi
netsh interface ip set address name=%wifi-adapter-name% source=static addr=%wifi-static-ip% mask=255.255.255.0 gateway=192.168.1.1
netsh interface ip set dns name=%wifi-adapter-name% source=static addr=192.168.1.1
ipconfig /flushdns
goto Show-IP-Configuration

:Show-IP-Configuration
netsh interface ip show addresses %ethernet-adapter-name%
netsh interface ip show addresses %wifi-adapter-name%

echo=
goto loop