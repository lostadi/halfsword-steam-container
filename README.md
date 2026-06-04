# Half Sword - Local Free & Open Source on M1 Max (64GB)

**No cloud. No paid software. Purely local, free, open source.**

Half Sword is a Windows game but runs well via Proton on Linux. Best free local way on Apple Silicon:

## Recommended: UTM + Linux VM + Proton

- UTM: free open source VM app for Mac
- Run Linux (Ubuntu/Debian) VM
- Steam + Proton inside the VM
- Play Half Sword (Proton handles the Windows bits)

This gives good performance without the overhead of full Windows emulation.

See `UTM-LINUX-PROTON.md` for the full guide.

Quick commands:
- `bash setup-parallels-env.sh` — current menu + status
- `bash start-steam-linux.sh` — launch the Docker Linux+Steam container alternative

Shared folder `~/HalfSword-Shared` is prepared for easy file transfer.

Other files in this dir cover the Windows emulation attempts (Docker/UTM) if you want a full Windows desktop (expect worse gaming perf).

All tools and guides here are free/open source.
