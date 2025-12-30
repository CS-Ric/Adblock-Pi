#!/usr/bin/env bash
set -euo pipefail

# -----------------------------
# Configuration
# -----------------------------
INSTALL_DIR="/opt/adguardhome"
SERVICE_NAME="AdGuardHome"

# -----------------------------
# Pre-flight checks
# -----------------------------
if [[ $EUID -ne 0 ]]; then
  echo "[!] Please run this script with sudo"
  exit 1
fi

echo "[+] Starting AdGuard Home uninstall"

# -----------------------------
# Stop service if running
# -----------------------------
if systemctl list-units --full -all | grep -q "${SERVICE_NAME}.service"; then
  echo "[+] Stopping AdGuard Home service"
  systemctl stop ${SERVICE_NAME}
  systemctl disable ${SERVICE_NAME}
else
  echo "[i] AdGuard Home service not found"
fi

# -----------------------------
# Remove service file
# -----------------------------
if [[ -f /etc/systemd/system/${SERVICE_NAME}.service ]]; then
  echo "[+] Removing systemd service"
  rm -f /etc/systemd/system/${SERVICE_NAME}.service
  systemctl daemon-reload
fi

# -----------------------------
# Remove install directory
# -----------------------------
if [[ -d "${INSTALL_DIR}" ]]; then
  echo "[+] Removing installation directory: ${INSTALL_DIR}"
  rm -rf "${INSTALL_DIR}"
else
  echo "[i] Installation directory not found"
fi

# -----------------------------
# Free DNS port (optional notice)
# -----------------------------
echo "[i] DNS port 53 is now free"

# -----------------------------
# Completion
# -----------------------------
echo "----------------------------------------"
echo "[✓] AdGuard Home has been removed"
echo "If this device was set as your router DNS,"
echo "remember to update your router settings."
echo "----------------------------------------"
