#!/usr/bin/env bash

# shellcheck disable=SC2034

readonly PROJECT_ROOT="/opt/personal-vpn"

readonly CONFIG_DIR="/etc/personal-vpn"

readonly KEY_DIR="${CONFIG_DIR}/keys"

readonly CLIENT_DIR="${CONFIG_DIR}/clients"

readonly TEMPLATE_DIR="${PROJECT_ROOT}/templates"

readonly CONFIG_FILE="${CONFIG_DIR}/config.env"

readonly WG_CONFIG_DIR="/etc/wireguard"

readonly WG_CONFIG_FILE="${WG_CONFIG_DIR}/wg0.conf"

readonly SERVER_KEY="${KEY_DIR}/server.key"

readonly EXIT_SUCCESS=0
readonly EXIT_GENERAL_ERROR=1
readonly EXIT_ALREADY_EXISTS=2
readonly EXIT_INVALID_ARGUMENT=3
readonly EXIT_PERMISSION_DENIED=4

require_root() {

    if [[ $EUID -ne 0 ]]; then
        die "This script must be run as root." "$EXIT_PERMISSION_DENIED"
    fi

}

log() {

    printf "[INFO] %s\n" "$*"

}

error() {

    printf "[ERROR] %s\n" "$*" >&2

}

warn() {

    printf "[WARN] %s\n" "$*"

}

die() {

    error "$1"

    exit "${2:-$EXIT_GENERAL_ERROR}"

}
