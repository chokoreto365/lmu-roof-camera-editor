# LMU Roof Camera Studio

A visual editor for **Le Mans Ultimate** camera config files (`.CAM`) that lets you place an on-board/roof camera where you actually want it — and still see the car.

> Unofficial tool. Not affiliated with Motorsport Games or Studio 397. Single-player use only, at your own risk.

![screenshot](docs/screenshot.png)

## Features

- Drag the camera in a side view (Y/Z) and top view (X/Z) preview.
- Precise numeric fields in centimetres and degrees; values are converted to metres/radians on write.
- Installs roof cameras for every car in one click — no manual file renaming or folder hunting.
- Per-car profiles, saved as individual `.CAM` files.
- Save while the game is running: after first-time setup, only the `.CAM` files are touched.
- Automatic backup of the original `Settings.JSON` and camera files, with one-click restore.
- Dedicated McLaren 720S preset using the `ONBOARD000` slot, for the "parameters work but the car is invisible" case.

## Quick start

1. Close Le Mans Ultimate completely.
2. Run `dist/LMU可视化车顶相机编辑器.exe` (uses the built-in .NET Framework, no extra runtime needed).
3. Confirm the game folder and press **扫描 / Scan**.
4. Pick a car, drag the orange camera dot or type values.
5. Press **保存当前车 CAM / Save this car** or **写入全部车辆 / Write all cars**.
6. Start the game, enter a track session, switch to **TVCOCKPIT** (or **ONBOARD000** for the 720S preset).

The first save enables `Broadcast Custom Cameras` in `Settings.JSON` (backed up automatically). That step requires the game to be closed.

## Axis convention

| Field | Unit | Meaning |
| --- | --- | --- |
| X | cm | positive = right |
| Y | cm | positive = up |
| Z | cm | **positive = rearward, negative = forward** (measured on the 720S) |
| Pitch | degrees | negative usually looks down |

Convention derived from in-game testing on the McLaren 720S. Other cars may differ; trust the picture, not the label.

## Saving while the game runs

1. Keep the game running and Alt+Tab to the editor.
2. Adjust and press **Save this car** — only the `.CAM` is written, `Settings.JSON` is untouched.
3. Back in game, **restart the track session** (or leave to the main menu and re-enter).

Sitting in the pit box, changing view, or pausing does not reload the camera. A full game restart is normally unnecessary.

## 720S: parameters move but no car is visible

That is a slot/model rendering issue, not a position issue. Use the external on-board slot:

1. Select the 720S and press **当前车建议值 / Recommended values** — the slot switches to `ONBOARD000`.
2. Save and reload the session.
3. In game switch to **ONBOARD000** — not TVCOCKPIT, not NOSE.
4. Move back with a larger Z until the framing looks right.

## Known limitations

- No live in-race editing: `.CAM` is not reliably hot-reloaded.
- In-game seat forward/up keys only affect the interior COCKPIT view.
- No process memory access, no injection, no anti-cheat bypass. With EAC active, Windows refuses external process reads outright.
- Cars never driven in-game may not appear in the list until the game writes its vehicle records.

## Build

```powershell
powershell -ExecutionPolicy Bypass -File build.ps1
```

Self test (isolated temp folder, does not touch real game config):

```powershell
& ".\dist\LMU可视化车顶相机编辑器.exe" --self-test "$env:TEMP\lmu-selftest.txt"
```

## License

MIT — see [LICENSE](LICENSE).
