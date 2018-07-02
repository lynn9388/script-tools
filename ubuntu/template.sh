#!/bin/bash

SCRIPT_NAME="$(basename "$0")"
USAGE="Usage: ${SCRIPT_NAME} [OPTION]..."

HelpInfo() {
    cat << EOM
${USAGE}
Shell script template.
Example: ${SCRIPT_NAME} -o=value

Options:
    -o, --option=VALUE  message of thi option

Miscellaneous:
    -h, --help          display this help and exit

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
        -h|--help)
            HelpInfo
            exit 0
            ;;
        -o=*|--option=*)
            OPTION="${i#*=}"
            shift
            ;;
        *)  printf "%s: unrecognized option '%s'\n" "${SCRIPT_NAME}" "$i"
            DefaultInfo
            exit 1
            ;;
    esac
done

echo "OPTION = ${OPTION}"
