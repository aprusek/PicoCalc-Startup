# Picocalc MMBASIC Startup

This document describes the two-stage autorun startup system used on this Picocalc.

---

## Overview

Startup uses a two-stage approach:

1. **FLASH.BAS** — a minimal hook file stored in flash memory that runs automatically at boot
2. **AUTO.BAS** — the main environment setup script stored on the SD card (`B:\AUTO\AUTO.BAS`)

---

## Stage 1: FLASH.BAS (Flash Hook)

`FLASH.BAS` is a minimal program whose only job is to call the second-stage loader on the SD card.

### Saving to Flash

Save or update the file using one of:

```basic
FLASH SAVE 1
```
or, if slot 1 is already occupied:
```basic
FLASH OVERWRITE 1
```

### Setting Autorun

To run `FLASH.BAS` automatically at every startup:

```basic
OPTION AUTORUN 1
```

This tells MMBASIC to run the program stored in flash slot 1 on every boot.

---

## Stage 2: AUTO.BAS (Environment Setup)

Located at `B:\AUTO\AUTO.BAS`, this script handles all environment configuration:

- Sets up the runtime environment
- Changes the current directory to `B:\BASIC`
- Launches the menu by running `B:\AUTO\MENU`

---

## Boot Sequence

```
Power On
   │
   ▼
MMBASIC starts
   │
   ▼
Program stored in FLASH 1 is run (FLASH.BAS)
   │
   ▼
FLASH.BAS calls B:\AUTO\AUTO.BAS
   │
   ▼
AUTO.BAS sets up environment, changes dir to B:\BASIC
   │
   ▼
AUTO.BAS runs B:\AUTO\MENU
```

---

## File Summary

| File        | Location           | Purpose                              |
|-------------|--------------------|--------------------------------------|
| `FLASH.BAS` | Flash slot 1       | Minimal autorun hook; calls AUTO.BAS |
| `AUTO.BAS`  | `B:\AUTO\AUTO.BAS` | Environment setup and menu launcher  |
| `MENU.BAS`  | `B:\AUTO\MENU`     | Main interactive menu                |
