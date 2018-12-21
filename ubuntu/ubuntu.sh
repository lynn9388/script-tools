#!/bin/bash

PS3="Please enter your choice (press q to quit): "
options=(
    "Heroku"
    "HTTP/SOCKS5"
    "Shadowsocks"
    "Local"

    "Set HTTP_PROXY"
    "Unset HTTPS_PROXY"

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
    echo "${export_http_proxy}" >> ~/.bashrc
    echo "${export_https_proxy}" >> ~/.bashrc
    eval "${export_http_proxy}"
    eval "${export_https_proxy}"
}

UnsetHttpProxy() {
    sed -i "/export HTTPS\?_PROXY/d" ~/.bashrc
    unset http_proxy
    unset https_proxy
}

select option in "${options[@]}"; do
    case "${REPLY}" in
        1)  ExecuteCommand "Heroku" "cd ~/Documents/Git/shadowsocks-heroku;node local.js"
            ;;
        2)  ExecuteCommand "HTTP/SOCKS5" "glider -listen mixed://:1080 -forward socks5://127.0.0.1:1081 -verbose"
            ;;
        3)  ExecuteCommand "Shadowsocks" "glider -listen ss://CHACHA20-IETF:PASSWORD@:8488 -forward socks5://127.0.0.1:1081 -verbose"
            ;;
        4)  ExecuteCommand "Local" "glider -listen ss://CHACHA20-IETF:PASSWORD@:8388 -verbose"
            ;;
        5)  SetHttpProxy
            ;;
        6)  UnsetHttpProxy
            ;;
        7)  ssh-add ~/.ssh/id_rsa
            ;;
        q)  break
            ;;
    esac
done
