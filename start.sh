#!/usr/bin/env bash
set -euo pipefail

echo "Half Sword Steam Windows Container starter"
echo

if ! command -v docker &> /dev/null; then
  echo "Docker not found. Please install Docker + Compose first."
  exit 1
fi

# Detect if we look like we have KVM (Linux)
if [[ -e /dev/kvm ]]; then
  echo "KVM detected. Using the Windows dockur container (docker-compose.yml)."
  COMPOSE_FILE="docker-compose.yml"
else
  echo "No /dev/kvm detected (common on macOS or inside VMs)."
  echo "You can still try the Windows container (will be slow/unaccelerated)."
  echo
  echo "For better gaming results on Linux hosts, consider the Steam-Headless compose instead."
  echo "  docker compose -f docker-compose.steam-headless.yml up -d"
  echo
  read -rp "Proceed with the (slow on this host) Windows container anyway? [y/N] " yn
  case $yn in
    [Yy]* ) COMPOSE_FILE="docker-compose.yml";;
    * ) echo "Exiting. Use the Steam-Headless file on a Linux machine with GPU, or run natively / via Whisky / GFN on macOS."; exit 0;;
  esac
fi

echo "Starting with $COMPOSE_FILE ..."
docker compose -f "$COMPOSE_FILE" up -d

echo
echo "Done. Open http://localhost:8006 in your browser to watch the Windows install."
echo "After it's ready, use RDP on localhost:3389 with user 'Docker' and the password you set in .env."
echo
echo "See README.md for full instructions, macOS alternatives (GeForce NOW is the quickest), and how to stream the game back to your Mac with low latency (Parsec or Sunshine+Moonlight)."
