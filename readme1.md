# PicoCalc MMBasic Startup Configuration

A reference guide for configuring the PicoCalc to boot into MMBasic with the correct settings and auto-start behaviour.

---

## Prerequisites

- PicoCalc device
- microSD card (FAT32 formatted)
- MMBasic firmware `.uf2` file (for the RP2040)
- A USB cable for flashing

---

## Flashing the Firmware

1. Hold the **BOOTSEL** button on the Raspberry Pi Pico while connecting it via USB. It will mount as a mass storage device (`RPI-RP2`).
2. Copy the MMBasic `.uf2` firmware file onto the `RPI-RP2` drive.
3. The Pico will reboot automatically once the file is copied. The drive will disappear — this is expected.

> **Tip:** If you need to re-flash, hold BOOTSEL again on power-up.

---

## SD Card Setup

MMBasic looks for configuration files and programs on the root of the microSD card. Ensure the card is formatted as **FAT32** before use.

Recommended root directory structure:

```
/
├── MMBASIC.CFG      # Runtime configuration options
├── AUTORUN.BAS      # Auto-executed program on startup (optional)
└── programs/        # Your BASIC programs
```

Insert the SD card into the PicoCalc before powering on.

---

## Configuration File (`MMBASIC.CFG`)

The `MMBASIC.CFG` file on the SD card root controls runtime behaviour. Each option is set on its own line using the format `OPTION <key> <value>`.

### Common Options

| Option | Example Value | Description |
|---|---|---|
| `OPTION DISPLAY` | `40, 14` | Console dimensions (columns, rows) |
| `OPTION BAUDRATE` | `115200` | Serial baud rate |
| `OPTION SDCARD` | `SPI, 10, 11, 12, 13` | SD card SPI pin mapping |
| `OPTION AUTORUN` | `ON` | Enable auto-running `AUTORUN.BAS` on boot |
| `OPTION LCDPANEL` | `ST7789, LANDSCAPE, ...` | Display driver and orientation |
| `OPTION TOUCH` | `...` | Touch controller configuration (if applicable) |

### Example `MMBASIC.CFG`

```
OPTION AUTORUN ON
OPTION DISPLAY 53, 20
OPTION BAUDRATE 115200
```

> Options are persisted in flash memory once set via the MMBasic prompt using `OPTION <key> <value>`. Editing the `.CFG` file directly is an alternative for bulk configuration.

---

## Auto-Start Program (`AUTORUN.BAS`)

When `OPTION AUTORUN ON` is set, MMBasic will automatically load and run `AUTORUN.BAS` from the SD card root on every boot.

### Example `AUTORUN.BAS`

```basic
' PicoCalc startup script
CLS
PRINT "Booting PicoCalc..."
PAUSE 500

' Launch your main program
RUN "programs/main.bas"
```

To disable auto-run temporarily, you can:
- Hold a key during boot (device-dependent behaviour)
- Or set `OPTION AUTORUN OFF` at the MMBasic prompt, then reset

---

## Boot Sequence Summary

```
Power on
  └─> MMBasic firmware initialises
        └─> Reads OPTION settings from flash
              └─> Mounts SD card
                    └─> If AUTORUN ON → runs AUTORUN.BAS
                          └─> Falls through to interactive prompt if no AUTORUN
```

---

## Useful MMBasic Prompt Commands

| Command | Description |
|---|---|
| `OPTION AUTORUN ON/OFF` | Enable or disable auto-start |
| `FILES` | List files on the SD card |
| `RUN "filename.bas"` | Run a program manually |
| `LOAD "filename.bas"` | Load a program into memory |
| `EDIT` | Open the built-in editor |
| `RESET` | Soft reset the device |

---

## Troubleshooting

**SD card not detected** — Confirm it is FAT32 formatted and fully seated. Check SPI pin options match your hardware revision.

**AUTORUN not firing** — Verify `OPTION AUTORUN ON` is set and `AUTORUN.BAS` exists in the SD card root (filename must be exact).

**Blank display on boot** — Check `OPTION LCDPANEL` matches your display driver and that the display orientation is correct.

**Firmware not flashing** — Ensure BOOTSEL is held before the USB cable is connected, not after.

---

## References

- [MMBasic Language Manual](https://mmbasic.com)
- [PicoCalc Hardware Documentation](https://www.clockworkpi.com)
- [Raspberry Pi Pico Datasheet](https://datasheets.raspberrypi.com/pico/pico-datasheet.pdf)
