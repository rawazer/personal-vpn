#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"

log "Checking wg..."
command -v wg >/dev/null

log "Checking wg-quick..."
command -v wg-quick >/dev/null

log "Checking WireGuard kernel support..."
sudo ip link add dev wg-test type wireguard
sudo ip link delete wg-test

log "All prerequisites satisfied."
