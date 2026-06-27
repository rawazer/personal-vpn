#!/usr/bin/env bash

readonly PROJECT_ROOT="/opt/personal-vpn"

readonly CONFIG_DIR="/etc/personal-vpn"

readonly KEY_DIR="${CONFIG_DIR}/keys"

readonly CLIENT_DIR="${CONFIG_DIR}/clients"

readonly EXIT_SUCCESS=0
readonly EXIT_GENERAL_ERROR=1
readonly EXIT_ALREADY_EXISTS=2
readonly EXIT_INVALID_ARGUMENT=3
readonly EXIT_PERMISSION_DENIED=4

require_root() {

    if [[ $EUID -ne 0 ]]; then
        error "This script must be run as root."

        exit $EXIT_PERMISSION_DENIED

    fi

}

log() {

    echo "[INFO] $*"

}

error() {

    echo "[ERROR] $*" >&2

}

warn() {

    echo "[WARN] $*"

}
