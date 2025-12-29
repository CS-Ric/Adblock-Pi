# Household Pi AdBlock (AdGuard Home)

A Raspberry Pi–based network-wide ad blocking solution using AdGuard Home.
Designed for home networks to block ads, trackers, and malicious domains
across all devices including mobile apps and smart TVs.

## Features
- Network-wide ad and tracker blocking
- Works with mobile apps and smart TVs
- Low-cost Raspberry Pi deployment
- Optional remote management (Tailscale-ready)
- DNS-level protection (no client apps required)

## Hardware
- Raspberry Pi Zero 2 W / Raspberry Pi 4
- MicroSD card (16GB+)
- Ethernet or Wi-Fi

## Installation
```bash
git clone https://github.com/yourusername/household-pi-adblock.git
cd household-pi-adblock
chmod +x scripts/install_adguard.sh
./scripts/install_adguard.sh
