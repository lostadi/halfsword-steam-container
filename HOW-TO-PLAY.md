# How to Play Half Sword (macOS focused)

**GeForce NOW is now the top recommendation** (completely free tier available, official support for the game, no local Windows needed at all).

New dedicated guide: `GEFORCE-NOW-SETUP.md`

This folder has the container/VM setups you requested earlier, **plus** the practical free ways to play today.

---

## 1. FASTEST: GeForce NOW (Recommended right now)

Half Sword is officially available on NVIDIA GeForce NOW.

Steps:
1. Go to https://play.geforcenow.com/ or open the GeForce NOW app on your Mac.
2. Sign in with your NVIDIA / Steam / Epic account (it links to your Steam library).
3. Search for "Half Sword".
4. Click Play.
5. If prompted, you may need a paid Priority or Ultimate membership for shorter queues / higher settings.
6. Play directly in browser or the app. Controls work with mouse/keyboard or controller.

Pros: No download of the game, high-end hardware in the cloud, works great on Mac.
Cons: Requires stable low-latency internet (wired or good 5GHz WiFi), some regions have queues.

Alternative cloud: Boosteroid also supports it.

---

## 2. Local on Mac (Free): Whisky

Whisky is the go-to free tool for running Windows Steam games on Apple Silicon.

Steps:
1. Download Whisky from https://getwhisky.app/
2. Install it (it will prompt for Rosetta 2 if needed).
3. Open Whisky → Create a new Bottle (choose a name like "Steam").
4. In the bottle, click the folder icon or "Open C: drive" → go to the desktop or downloads.
5. Download the Windows Steam installer from https://store.steampowered.com/about/ (get SteamSetup.exe).
6. Drag SteamSetup.exe into the bottle's C: drive (or run it from Whisky).
7. Run the installer inside the bottle.
8. Once Steam is installed and you log in, install Half Sword as normal.
9. Launch the game from Steam inside the Whisky bottle.

Tips:
- Use Proton-like layers if offered, or DXVK/VKD3D options in Whisky for better performance.
- Half Sword is Unreal Engine based — most people get it running with some tweaking.
- Check AppleGamingWiki or ProtonDB comments for Half Sword + Whisky specific tips.

---

## 3. Local on Mac (Free & Open Source): UTM for full Windows VM

See **UTM-SETUP.md** for detailed steps.

- Completely free and open source.
- Download UTM: https://mac.getutm.app/
- Windows 11 ARM ISO (free from Microsoft): https://www.microsoft.com/en-us/software-download/windows11arm64
- Then install Steam + Half Sword inside the VM.

Note: Limited 3D for Windows games.

---

## 4. The Windows Container You Asked For (dockur/windows) - OSS & Free

We have everything ready in this folder (docker-compose.macos-try.yml).

It is 100% open source and free.

See the section below "Trying it locally on your Mac anyway" and the updated guides.

---

## 5. Other Free Local Options

- **Whisky** (last builds still used by many, though project is archived): https://github.com/Whisky-App/Whisky/releases
- **Linux VM in UTM + Proton**: Better game compatibility for Half Sword (good Proton reports). Use the steam-headless compose we have if you spin up Linux (note: docker variant is amd64-only, best on native Linux hardware).

All options here are free/open source focused. No Parallels or paid software.

On this Mac it can boot but will be **painfully slow**.

### On a Linux host with KVM (best for the container)

1. Copy this entire `halfsword-steam-container` folder to the Linux machine (scp, rsync, USB, etc.).

2. On the Linux machine:
   ```bash
   cd halfsword-steam-container
   docker compose up -d
   # or use the helper:
   ./start.sh
   ```

3. Open browser to http://<linux-ip>:8006 and watch Windows install itself (5-20 minutes).

4. When desktop appears:
   - There should be `SteamSetup.exe` on the Desktop (downloaded by the install.bat).
   - Double-click it and install Steam.
   - Log into Steam.
   - Search your library for **Half Sword** and install it.

5. For playing from your Mac (don't use the web viewer or basic RDP for gaming):
   - Inside Windows, install one of these:
     - **Parsec** → https://parsec.app/downloads (easiest, great Mac client)
     - **Sunshine** → https://github.com/LizardByte/Sunshine (free, use Moonlight client on Mac)
   - On your Mac, install the client (Moonlight from App Store or website) and connect.

RDP (port 3389):
- Mac App Store → Microsoft Remote Desktop
- Add PC: the Linux host IP, port 3389
- User: Docker   Password: admin
- (Change the password inside Windows immediately.)

### Trying it locally on your Mac anyway (very slow)

We created a special file for this:

```bash
cd /Users/ustad/halfsword-steam-container
docker compose -f docker-compose.macos-try.yml up -d
```

- It forces `KVM: "N"` and uses a separate storage folder (`windows-macos`).
- It will eventually boot Windows (very slowly).
- Same steps inside: run SteamSetup.exe, etc.
- Expect single-digit FPS or heavy lag for Half Sword. This is only for "I want to see the container work".

To stop:
```bash
docker compose -f docker-compose.macos-try.yml down
```

To completely reset that attempt:
```bash
docker compose -f docker-compose.macos-try.yml down -v
rm -rf windows-macos
```

### Using the Steam-Headless alternative (Linux + Proton)

If you have a Linux machine (or are OK with emulation on Mac):

```bash
cd /Users/ustad/halfsword-steam-container
docker compose -f docker-compose.steam-headless.yml up -d
```

- This runs real Linux Steam + Proton (Half Sword works well according to ProtonDB).
- Built-in Sunshine for streaming.
- Edit the file first to set your STEAM_USER / SUNSHINE_PASS etc.
- On Apple Silicon Mac: image is amd64-only → runs emulated in Docker (poor 3D perf). Use on real amd64 Linux hardware for best results.
- Much lighter than full Windows for this game.

---

## Quick Links

- GeForce NOW: https://play.geforcenow.com/
- Whisky: https://getwhisky.app/
- CrossOver: https://www.codeweavers.com/crossover
- dockur/windows: https://github.com/dockur/windows
- Steam-Headless: https://github.com/Steam-Headless/docker-steam-headless
- Half Sword ProtonDB: https://www.protondb.com/app/2397300

---

**My honest recommendation for you today:**

1. Try **GeForce NOW** first — you could be playing in < 5 minutes.
2. If you want local and free → install **Whisky** next.
3. Use the container files only if you have (or want to set up) a Linux box with decent CPU/GPU that you can stream from.

Tell me which path you want to take and I can give more detailed screenshots-style steps or help debug. 

Enjoy the swords! ⚔️
