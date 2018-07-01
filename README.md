# script-tools

Some helpful scripts for Daily Usage.

## Ubuntu

- [ubuntu.sh](ubuntu/ubuntu.sh)
  - Use [glider](https://github.com/nadoo/glider) to connect to proxy server
  - Use [rclone](https://github.com/ncw/rclone) to mount Google Drive
- [backup.sh](ubuntu/backup.sh)
  - Compress every virtual machine folder for VMware
  - Use [Resilio Sync Home](https://www.resilio.com/) to backup data

## Windows

- [switch_ip.bat](windows/switch_ip.bat)
  - Steps to avoid manually select "Run as administrator" from context menu
    - Create a shortcut for this batch
    - Click *Properties* from the context menu to open *Shortcut Properties*
    - Click *Advanced* from the *Shortcut* tab
    - Check *Run as administrator* in the popup window
    - Save and close popup windows
    - Just double clicks the shortcut to run the batch file as administrator