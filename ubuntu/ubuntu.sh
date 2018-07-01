#!/bin/bash

PS3="Please enter your choice (press q to quit): "
options=(
    "Connect to SIAT"
    "Connect to Heroku"

    "Set HTTP_PROXY"
    "Unset HTTPS_PROXY"

    "Mount Google Drive"
    "Unmount Google Drive"

    "Add ssh key to ssh-agent"
)

# Execute command in a new titled terminal
ExecuteCommand() {
    gnome-terminal --tab -t "$1" -- bash -c "$2"
}

export_http_proxy="export HTTP_PROXY='socks5://localhost:1080'"
export_https_proxy="export HTTPS_PROXY='socks5://localhost:1080'"

SetHttpProxy() {
    UnsetHttpProxy
    echo $export_http_proxy >> ~/.bashrc
    echo $export_https_proxy >> ~/.bashrc
    eval "$export_http_proxy"
    eval "$export_https_proxy"
}

UnsetHttpProxy() {
    sed -i "/export HTTPS\?_PROXY/d" ~/.bashrc
    unset http_proxy
    unset https_proxy
}

select option in "${options[@]}"
do
    case "$REPLY" in
        1)  pkill -f glider
            ExecuteCommand "SIAT" "glider -listen mixed://localhost:1080 -forward ss://CHACHA20-IETF:PASSWORD@192.168.127.128:8388 -verbose"
            ;;
        2)  pkill -f glider
            ExecuteCommand "Heroku" "glider -listen mixed://localhost:1080 -forward ss://CHACHA20-IETF:PASSWORD@192.168.127.128:8488 -verbose"
            ;;
        3)  SetHttpProxy
            ;;
        4)  UnsetHttpProxy
            ;;
        5)  SetHttpProxy
            mount_info="Please make sure Google Drive is accessible \(press Ctrl+C to unmount\)"
            ExecuteCommand "Google Drive" "echo $mount_info;rclone mount Google-Drive: ~/Google\ Drive"
            ;;
        6)  fusermount -u ~/Google\ Drive
            ;;
        7)  ssh-add ~/.ssh/id_rsa
            ;;
        q)  break
            ;;
    esac
done
