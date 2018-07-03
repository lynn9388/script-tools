#!/bin/bash

SCRIPT_NAME="$(basename "$0")"
USAGE="Usage: ${SCRIPT_NAME} [OPTION]..."

HelpInfo() {
    cat << EOM
${USAGE}
Config static IP for Ubuntu Server 18.04.
Example: ${SCRIPT_NAME} -i=192.168.1.2/24 -g=192.168.1.1

Options:
    -g, --gateway=DEFAULT_GATEWAY   set default gateway
    -i, --ip=IP_ADDRESS             set IP address and subnet mask

Miscellaneous:
    -h, --help                      display this help and exit

Report bugs to: https://github.com/lynn9388/script-tools
EOM
}

DefaultInfo() {
    printf "%s\n\nTry '${SCRIPT_NAME} --help' for more information.\n" "${USAGE}"
}

# Print default info when run shell script without arguments
if [ $# -eq 0 ]; then
    DefaultInfo
    exit 1
fi

# Parse command line arguments
for i in "$@"; do
    case "$i" in
        -g=*|--gateway=*)
            DEFAULT_GATEWAY="${i#*=}"
            shift
            ;;
        -i=*|--ip=*)
            IP_ADDRESS="${i#*=}"
            shift
            ;;
        -h|--help)
            HelpInfo
            exit 0
            ;;
        *)  printf "%s: unrecognized option '%s'\n" "${SCRIPT_NAME}" "$i"
            DefaultInfo
            exit 1
            ;;
    esac
done

if [ \( -z "${DEFAULT_GATEWAY}" \) -o \( -z "${IP_ADDRESS}" \) ]; then
    printf "%s: invalid configuration ip=%s gateway=%s\n" "${SCRIPT_NAME}" "${IP_ADDRESS}" "${DEFAULT_GATEWAY}"
    DefaultInfo
    exit 1
fi

CheckUser() {
    if [ "$EUID" -ne 0 ]; then
        echo "Please run as root."
        exit
    fi
}

BackupFiles() {
    for entry in ./*; do
        if [ ! "${entry}" = "*.backup" ]; then
            dir=$(dirname "${entry}")
            name=$(basename "${entry}")
            time=$(date +"%Y-%m-%d_%H%M%S")
            cp -r "${entry}" "$dir/.$name.$time.backup"
        fi
    done
}

GenerateConfigFile() {
    cat > 50-cloud-init.yaml << EOF
# This file is generated from information provided by
# the datasource.  Changes to it will not persist across an instance.
# To disable cloud-init's network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        ens33:
            addresses: [${IP_ADDRESS}]
            dhcp4: no
            optional: true
            gateway4: ${DEFAULT_GATEWAY}
    version: 2
EOF
}

CheckUser
cd /etc/netplan
BackupFiles
GenerateConfigFile
netplan apply
