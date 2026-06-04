# M1 Max (64 GB Unified RAM) Guide for Half Sword

**GeForce NOW is the best choice for you right now.**

Your M1 Max 64GB is perfect for it (just decodes the stream). See the new `GEFORCE-NOW-SETUP.md`.

Half Sword has **confirmed working reports** on M1-series Macs (local methods):

- **CrossOver**: "Runs Well" (CodeWeavers). Specific YouTube tutorials show M1 Max users getting high frame rates.
- **Whisky**: Platinum rating (demo at least). Reddit users on M1 Pro report 30-45 FPS on High with demo/playtest. Expect similar or better on Max + 64 GB.
- Performance notes from users: 40-60 FPS range on medium/high in the demo, physics combat works, some drops in very hectic scenes because the game isn't fully optimized yet.

The full Windows container (dockur) is still not the best path here (see below).

---

## Best Options for Your Hardware (Ranked)

### 1. CrossOver or Whisky (Best local performance for this game)

These translate the Windows game directly to Metal (Apple's graphics). Much less overhead than a full VM for games that work.

**Start with free Whisky:**

1. Download: https://getwhisky.app/
2. Install Whisky.
3. Create a new Bottle. Give it a good name (e.g. "HalfSword").
4. In Whisky settings for the bottle, you can allocate more resources if the UI allows (your 64 GB host makes this comfortable).
5. Download Steam Windows installer (store.steampowered.com/about/).
6. Run the installer inside the bottle.
7. Log into Steam.
8. Install Half Sword (or the demo/playtest first to test).
9. Launch.

**If you want better support / newer Wine + easier fixes → CrossOver (paid, has 14-day trial):**

- Download from https://www.codeweavers.com/crossover
- There's a dedicated "How to play Half Sword on Mac" video using CrossOver + Steam on M1 Max: search YouTube for "How To Play Half Sword On Mac" (shows full setup, fixing stalled downloads, launching).
- CrossOver often has one-click installers or "CXPatcher" for D3DMetal improvements.

**Tips specific to M1 Max + 64 GB + Half Sword:**
- The game is physics-heavy (ragdolls, sword collisions). Give the bottle/translation layer as much memory as possible.
- Start on Medium settings. Users report stable 40+ FPS.
- Turn V-Sync off.
- If downloads stall in Steam inside the bottle: common fix in the tutorials (restart bottle or specific settings).
- Use latest Whisky/CrossOver versions (as of 2026 they have good GPTK/D3DMetal support).
- If you see shader compilation hitches first time, let it finish — subsequent runs are smoother.

### 2. UTM (Best completely free & open source "Windows VM/container")

**100% free and open source** — no paid software, no trials, no subscriptions.

See the dedicated guide: **UTM-SETUP.md** (in this folder).

- UTM: https://mac.getutm.app/ (GitHub version is completely free and OSS).
- Official Windows 11 ARM ISO (free from Microsoft): https://www.microsoft.com/en-us/software-download/windows11arm64
- Allocate 6-8 cores + 16-24 GB RAM on your 64 GB M1 Max.

This is the closest free OSS equivalent to a full contained Windows desktop.

**Gaming note**: Limited 3D acceleration in Windows guests, so Half Sword runs software-rendered. Playable at low settings, but not ideal. Use for the "Windows environment" feel.

### 3. dockur/windows Container (True open source "Windows container")

We already prepared this for you — fully OSS: https://github.com/dockur/windows

Use the file we tuned:
```bash
cd /Users/ustad/halfsword-steam-container
docker compose -f docker-compose.macos-try.yml up -d
```

Access the web viewer at http://localhost:8006. It auto-installs Windows + Steam setup.

Slower on macOS due to emulation layers, but exactly what you originally asked for ("windows container") and 100% free/open source.

Run `bash setup-parallels-env.sh` for the current checklist.

### 4. GeForce NOW (Easiest free way to actually play the game)

Even with your powerful Mac, cloud streaming can look and feel better.

- Half Sword is officially supported.
- Free tier available (queues on free; Priority for better).
- No local install, high settings, works great on M1 Max.

https://play.geforcenow.com/

### 5. Whisky (Free local translation layer - project archived but last builds still work)

Half Sword demo is rated Platinum.

Download last release from: https://github.com/Whisky-App/Whisky/releases

Many M1 Max users got 30-60 FPS with it. If the archived version works for you, it's a great free local option.

### (The dockur container details are covered in section 3 above and in the files we prepared.)

Run `bash /Users/ustad/halfsword-steam-container/setup-parallels-env.sh` anytime for the latest checklist, disk check, and direct links.
- But: Multiple layers of emulation (Apple Silicon → Docker's Linux VM using hypervisor → QEMU emulating x86 Windows). 
- Result: Noticeably slow, especially for a CPU/physics heavy game like Half Sword. Users report it's "very slow" and not suitable for gaming.

How to try it anyway (with your high RAM):

```bash
cd /Users/ustad/halfsword-steam-container
docker compose -f docker-compose.macos-try.yml up -d
```

Then go to http://localhost:8006 .

Inside: same as before — SteamSetup.exe on desktop.

For actual play, don't rely on this. If you really want a containerized approach on Mac, a better (still advanced) route is:
- Run a Linux VM in UTM or Parallels (allocate 16-24 GB RAM).
- Inside the Linux VM, install Steam natively + Proton.
- Half Sword works well via Proton on Linux.
- Stream out with Sunshine/Moonlight or just play in the VM window.

---

## Quick Decision Guide for Your Rig

- Want to play **today with least pain** → GeForce NOW.
- Want **free local** and good performance → **Whisky** first.
- Want **best supported local experience** → **CrossOver** (try the trial, watch the Half Sword specific video).
- Want **full Windows desktop "container"** → **Parallels** (leverage your 64 GB RAM hard).
- Want to tinker with the thing I built → Use the macos-try compose or the Linux VM + Steam-Headless route.

Your 64 GB unified memory is the secret sauce — it lets you over-allocate to any of these without the system swapping or stuttering.

Let me know which one you're going to try first and I can give even more precise commands, settings tweaks for Half Sword (graphics.ini, launch options, etc.), or help set up file sharing / controls.

You have the hardware to make this work nicely. Let's get you swinging swords. ⚔️
