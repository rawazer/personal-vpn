#!/usr/bin/env bash

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

load_configuration() {

    log "Loading deployment configuration..."

    [[ -f "$CONFIG_FILE" ]] ||
        die "Configuration file not found: $CONFIG_FILE"

    # shellcheck source=/dev/null
    source "$CONFIG_FILE"
}

validate() {

    log "Validating deployment..."

    [[ -f "$TEMPLATE_DIR/wg0.conf.tpl" ]] ||
        die "Template not found: $TEMPLATE_DIR/wg0.conf.tpl"

    [[ -f "$SERVER_KEY" ]] ||
        die "Server private key not found: $SERVER_KEY"

    : "${VPN_INTERFACE:?VPN_INTERFACE is not set}"
    : "${VPN_PORT:?VPN_PORT is not set}"
    : "${VPN_SERVER_IP:?VPN_SERVER_IP is not set}"
    : "${VPN_SUBNET:?VPN_SUBNET is not set}"

}

render() {

    log "Rendering WireGuard configuration..."

    readonly SERVER_PRIVATE_KEY="$(<"$SERVER_KEY")"

    TMP_FILE="$(mktemp)"

    trap 'rm -f "$TMP_FILE"' EXIT

    sed \
        -e "s|@VPN_SERVER_IP@|${VPN_SERVER_IP}|g" \
        -e "s|@VPN_PORT@|${VPN_PORT}|g" \
        -e "s|@SERVER_PRIVATE_KEY@|${SERVER_PRIVATE_KEY}|g" \
        "$TEMPLATE_DIR/wg0.conf.tpl" >"$TMP_FILE"

    chmod 600 "$TMP_FILE"

}

install() {

    log "Installing WireGuard configuration..."

    mkdir -p "$WG_CONFIG_DIR"

    mv "$TMP_FILE" "$WG_CONFIG_FILE"

}

verify() {

    log "Verifying deployment..."

    [[ -f "$WG_CONFIG_FILE" ]] ||
        die "Deployment failed."

    [[ "$(stat -c '%a' "$WG_CONFIG_FILE")" == "600" ]] ||
        die "Unexpected permissions on $WG_CONFIG_FILE"

}

main() {

    require_root

    load_configuration

    validate

    render

    install

    verify

    log "Deployment completed successfully."

}

main "$@"
