#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

log "Checking wg..."
command -v wg >/dev/null

log "Checking wg-quick..."
command -v wg-quick >/dev/null

log "Checking WireGuard kernel support..."
sudo ip link add dev wg-test type wireguard
sudo ip link delete wg-test

log "All prerequisites satisfied."
