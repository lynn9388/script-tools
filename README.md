# script-tools

Some helpful scripts for daily usage.

## Ubuntu

- [ubuntu.sh](ubuntu/ubuntu.sh)
  - Use [glider](https://github.com/nadoo/glider) to connect to proxy server
- [backup.sh](ubuntu/backup.sh)
  - Compress every virtual machine folder for VMware
  - Use [Resilio Sync Home](https://www.resilio.com/) to backup data
- [config-ip.sh](ubuntu/config-ip.sh)
  - Config static IP for Ubuntu Server 18.04
- [network-util.sh](ubuntu/network-util.sh)
  - Test if an IP address is valid

## Windows

- [config-ip.bat](windows/config-ip.bat)
  - Steps to avoid manually select "Run as administrator" from context menu
    - Create a shortcut for this batch
    - Click *Properties* from the context menu to open *Shortcut Properties*
    - Click *Advanced* from the *Shortcut* tab
    - Check *Run as administrator* in the popup window
    - Save and close popup windows
    - Just double clicks the shortcut to run the batch file as administrator