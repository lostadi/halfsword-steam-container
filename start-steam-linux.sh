#!/bin/bash
# Launch free open source Linux + Steam + Proton container for Half Sword
# This is a containerized Linux environment with Steam (using Proton for the Windows game).
# Much better for gaming performance than full Windows emulation on Apple Silicon.
# You can play directly if GPU works in Docker, or stream via Sunshine/Moonlight.

set -e

cd "$(dirname "$0")"

echo "=== Starting Steam Linux Container (Proton for Half Sword) ==="

# Check Docker daemon is running (important on macOS - start Docker Desktop first!)
if ! docker info >/dev/null 2>&1; then
  echo "ERROR: Docker daemon not running."
  echo "On macOS: Open Docker Desktop app (from Applications or Spotlight) and wait until it says 'Docker Desktop is running' (whale icon in menu bar)."
  echo "Then re-run this script."
  exit 1
fi

# Auto-detect UID/GID for current user (important for file permissions)
PUID=$(id -u)
PGID=$(id -g)

if [ "$PUID" -eq 0 ]; then
  echo "ERROR: Running as root (PUID=0). Do NOT use sudo!"
  echo "Run this script as your normal user (without sudo)."
  exit 1
fi

echo "Using PUID=$PUID PGID=$PGID for your user"

HOST_ARCH=$(uname -m)
if [ "$HOST_ARCH" = "arm64" ] || [ "$HOST_ARCH" = "aarch64" ]; then
  echo "Detected arm64 host (Apple Silicon). Image will run emulated (platform: linux/amd64)."
  echo "Gaming/3D will be limited; consider the UTM Linux VM path for better results on Mac."
fi

# Update the compose with detected IDs (simple sed for the env lines)
cp docker-compose.steam-headless.yml docker-compose.steam-headless.yml.bak 2>/dev/null || true
sed -i '' "s/- PUID=[0-9]*/- PUID=$PUID/" docker-compose.steam-headless.yml
sed -i '' "s/- PGID=[0-9]*/- PGID=$PGID/" docker-compose.steam-headless.yml

# Set a default Sunshine password if not changed (user should change it)
if grep -q "SUNSHINE_PASS=changeme123" docker-compose.steam-headless.yml || grep -q "SUNSHINE_PASS=halfsword123" docker-compose.steam-headless.yml; then
  echo "Warning: Using default Sunshine password. Edit docker-compose.steam-headless.yml to set a secure one (SUNSHINE_PASS=yourpassword)."
fi

echo "Pulling image via docker compose (respects platform: in the yml; may need 'docker login ghcr.io' for GHCR rate limits)..."

# Use compose pull so the image name + platform stays defined only in the compose file (single source of truth).
# Capture stderr+stdout to inspect for auth hints on failure.
set +e
PULL_OUTPUT=$(docker compose -f docker-compose.steam-headless.yml pull 2>&1)
PULL_STATUS=$?
set -e
echo "$PULL_OUTPUT"

if [ $PULL_STATUS -ne 0 ]; then
  echo ""
  if echo "$PULL_OUTPUT" | grep -qiE 'denied|unauthorized|authentication|forbidden|login required|token'; then
    echo "Pull failed with auth/permission error (common on ghcr.io for unauthenticated pulls or rate limits)."
    echo "Fix: Authenticate to GitHub Container Registry:"
    echo "  1. Go to https://github.com/settings/tokens (create a classic PAT with ONLY 'read:packages' scope)."
    echo "  2. Run: docker login ghcr.io -u YOUR_GITHUB_USERNAME"
    echo "     (paste the token as the password when prompted)"
    echo "  3. Then re-run this script: bash start-steam-linux.sh"
  else
    echo "Pull failed (see docker output above for details)."
    echo "Common fixes on macOS/Apple Silicon:"
    echo "  - The compose now specifies platform: linux/amd64 (image only published for amd64)."
    echo "  - Ensure Docker Desktop is running (whale icon) and can pull images."
    echo "  - Try forcing in terminal: docker compose -f docker-compose.steam-headless.yml pull"
    echo "  - Alternative image (Docker Hub): change 'image:' to josh5/steam-headless:latest (and keep platform)."
  fi
  echo ""
  exit 1
fi

echo "Starting container..."
docker compose -f docker-compose.steam-headless.yml up -d

echo "Waiting for noVNC web UI to become reachable on :8080 (can take 20-60s)..."
for i in $(seq 1 40); do
  if curl -s -o /dev/null -w "%{http_code}" --max-time 2 http://localhost:8080 2>/dev/null | grep -qE '200|302|401|403'; then
    echo "✅ Web UI is responding!"
    break
  fi
  if [ $i -eq 40 ]; then
    echo "Still not responding after ~40s. It may come up soon, or check logs."
  else
    printf "."
    sleep 2
  fi
done
echo ""

echo "✅ Container started!"
echo "Web UI (noVNC desktop): http://localhost:8080"
echo "The container creates a 'default' linux user (uid from PUID). The noVNC web UI typically needs no extra password for the browser page."
echo "Sunshine (Moonlight) auth uses the SUNSHINE_* values from the yml."
echo ""
echo "Inside the container:"
echo "- Launch Steam, log in, install Half Sword (it should use Proton)."
echo "- For remote play from your Mac: use Moonlight client to connect to Sunshine (ports forwarded)."
echo ""
echo "To stop: docker compose -f docker-compose.steam-headless.yml down"
echo ""
echo "Note: On macOS (Apple Silicon), the amd64-only image runs emulated via Rosetta in Docker. 3D/GPU accel + gaming perf will be poor. For best results, use the UTM Linux VM method instead (see UTM-LINUX-PROTON.md)."
