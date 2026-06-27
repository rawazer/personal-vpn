#!/usr/bin/env bash

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

readonly PRIVATE_KEY="${KEY_DIR}/server.key"
readonly PUBLIC_KEY="${KEY_DIR}/server.pub"

main() {

    require_root

    if [[ -e "$PRIVATE_KEY" || -e "$PUBLIC_KEY" ]]; then
        die "Server keys already exist." "$EXIT_ALREADY_EXISTS"
    fi

    umask 077

    wg genkey > "$PRIVATE_KEY" 

    wg pubkey < "$PRIVATE_KEY" > "$PUBLIC_KEY"

    chmod 600 "$PRIVATE_KEY"
    chmod 644 "$PUBLIC_KEY"

    echo
    echo "Server public key:"
    echo "------------------"
    read -r pubkey < "$PUBLIC_KEY"
    printf "%s\n" "$pubkey"

    echo
    echo "Server keypair successfully generated."
}

main "$@"
