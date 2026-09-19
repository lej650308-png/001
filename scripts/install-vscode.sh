#!/usr/bin/env bash
#
# Install Visual Studio Code on Debian/Ubuntu from Microsoft's official apt repo.
#
# Usage:  sudo ./scripts/install-vscode.sh
#
set -euo pipefail

KEYRING=/usr/share/keyrings/microsoft.gpg
SOURCE_LIST=/etc/apt/sources.list.d/vscode.list

if [[ $EUID -ne 0 ]]; then
  echo "This script needs root. Re-run with: sudo $0" >&2
  exit 1
fi

echo "==> Installing prerequisites"
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y --no-install-recommends ca-certificates curl gpg apt-transport-https

echo "==> Adding Microsoft signing key -> $KEYRING"
tmp_key=$(mktemp)
trap 'rm -f "$tmp_key"' EXIT
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > "$tmp_key"
install -D -o root -g root -m 644 "$tmp_key" "$KEYRING"

echo "==> Adding VS Code apt repository -> $SOURCE_LIST"
cat > "$SOURCE_LIST" <<REPO
deb [arch=amd64,arm64,armhf signed-by=$KEYRING] https://packages.microsoft.com/repos/code stable main
REPO

echo "==> Installing code"
apt-get update -qq
apt-get install -y code

echo "==> Installed: $(code --version --no-sandbox --user-data-dir=/tmp/vscode-verify 2>/dev/null | head -1)"
echo
echo "Headless host? The GUI needs an X/Wayland display. Instead use:"
echo "  code tunnel      # reach this machine from vscode.dev"
echo "  code serve-web   # browser-based VS Code on a local port"
