#!/usr/bin/env bash
set -euo pipefail

# -----------------------------
# Configuration
# -----------------------------
ADGUARD_VERSION="v0.107.52"
INSTALL_DIR="/opt/adguardhome"
INSTALL_SCRIPT="install_adguardhome.sh"

# -----------------------------
# Pre-flight checks
# -----------------------------
if [[ $EUID -ne 0 ]]; then
  echo "[!] Please run this script with sudo"
  exit 1
fi

echo "[+] Starting AdGuard Home installation"
echo "[+] Target version: ${ADGUARD_VERSION}"

# -----------------------------
# Dependencies
# -----------------------------
echo "[+] Installing required packages"
apt-get update -y
apt-get install -y curl tar

# -----------------------------
# Download installer
# -----------------------------
echo "[+] Downloading AdGuard Home installer"
curl -fsSL \
  "https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/${ADGUARD_VERSION}/scripts/install.sh" \
  -o "${INSTALL_SCRIPT}"

chmod +x "${INSTALL_SCRIPT}"

echo "[+] Installer downloaded locally for inspection"

# -----------------------------
# Run installer
# -----------------------------
echo "[+] Running AdGuard Home installer"
./"${INSTALL_SCRIPT}" \
  -s \
  -d "${INSTALL_DIR}"

# -----------------------------
# Cleanup
# -----------------------------
rm -f "${INSTALL_SCRIPT}"

# -----------------------------
# Post-install info
# -----------------------------
IP_ADDRESS=$(hostname -I | awk '{print $1}')

echo "----------------------------------------"
echo "[✓] AdGuard Home installed successfully"
echo "Dashboard URL:"
echo "  http://${IP_ADDRESS}:3000"
echo
echo "Next steps:"
echo "1. Open the dashboard in your browser"
echo "2. Complete the initial setup wizard"
echo "3. Set your router DNS to ${IP_ADDRESS}"
echo "----------------------------------------"
