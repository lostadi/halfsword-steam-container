#!/bin/bash
set -e
echo "=== Half Sword - Local Free & Open Source Setup (M1 Max 64GB) ==="
echo "No cloud. No paid software. Local only."
echo

mkdir -p "$HOME/HalfSword-Shared"
echo "✅ Shared folder: ~/HalfSword-Shared (for game files, easy access from VM/container)"

echo
df -h / | tail -1
echo

echo "=== Recommended: UTM Linux VM + Proton (best performance for the game) ==="
echo "1. Download UTM (free OSS): https://mac.getutm.app/"
echo "2. Create Ubuntu/Debian VM (8-16GB RAM, 4-6 cores recommended)"
echo "3. Share the ~/HalfSword-Shared folder into the VM"
echo "4. In VM: install Steam, enable Proton, play Half Sword"
echo "Full guide: cat UTM-LINUX-PROTON.md"
echo

echo "=== Alternative: Linux Steam in Docker container ==="
echo "  bash start-steam-linux.sh"
echo "  (or manually: docker compose -f docker-compose.steam-headless.yml up -d)"
echo "  Web desktop: http://localhost:8080"
echo "  Note: GPU/3D perf limited on macOS Docker; use for testing or with streaming (Sunshine/Moonlight)"
echo

echo "Other (if you want full Windows desktop anyway - performance will suffer for games):"
echo "  UTM Windows: cat UTM-SETUP.md"
echo "  Docker Windows (slow): docker compose -f docker-compose.macos-try.yml up -d ; http://localhost:8006"
echo

echo "Run this script again for this menu."
