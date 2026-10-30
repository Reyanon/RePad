# RePad

Bluetooth controllers for the PS Vita and PS TV: a kernel plugin, written from scratch, MIT licensed.

## Features

- **Pairs controllers the Vita does not accept by itself** and reads them:
  - DualShock 4 (both versions)
  - DualSense
  - Switch Pro Controller
  - controllers that pair as one of these, such as the iine L1194 in Switch Pro mode
- **Works in every app and game:** controller 1 is added to the Vita's own controls (port 0).
- **Two players and more:** apps that read ports 1-4 get each controller on its own port.
  - While an app does that, controller 1 is no longer added to port 0, so the Vita's own controls and a controller can
    be two players.
- **Steady ports:** controller slots stay put while another controller disconnects. A controller that connects again gets
  its port back.
- **Safe on the PS TV:** the DualShock 3 / 4 controllers the system serves itself are left alone. RePad's controllers
  take only the ports the system leaves free.
- **Safe on an unknown firmware:** RePad checks every function it hooks before it hooks any. If a check fails, it does
  not start at all and the controls stay as the system has them.
- **For app authors** (see `src/repad.h`):
  - the controller's real kind, found in the port info;
  - a command that tells RePad to stand aside or serve again, without a restart.

## Install

Firmware 3.60-3.74 with HENkaku / Ensō and taiHEN.

1. Copy `repad.skprx` (from Releases) to `ur0:tai/`.
2. Add this line under `*KERNEL` in `ur0:tai/config.txt`:
   ```
   *KERNEL
   ur0:tai/repad.skprx
   ```
3. Reboot.

The Re series emulators ([ReSys12](https://github.com/Reyanon/ReSys12), [ReST-V](https://github.com/Reyanon/ReST-V),
[ReiREM](https://github.com/Reyanon/ReiREM)) bundle RePad. Set Settings > Controls > Input engine to RePad: no install is
needed.

Do not install RePad together with another Bluetooth controller plugin (VitaControl, ds4vita, ...). If VitaControl is
loaded, RePad does not start.

## Use

### PS Vita 1000 / 2000 (handheld)

1. Put the controller in pairing mode:
   - DualShock 4: hold Share + PS until the light bar flashes.
   - DualSense: hold Create + PS until the light flashes.
   - Switch Pro: hold the sync button on top.
2. On the Vita: Settings > Devices > Bluetooth Devices, and select the controller.
3. Later on, press the controller's PS / HOME button to connect it again.

How apps see the controllers:

- **Single-player games:** the controller and the Vita's own buttons both work.
- **Multi-player apps** (those that read ports 1-4): the Vita is 1P and the controller is 2P. Two controllers can be 1P and 2P.

The 1000 and the 2000 work the same.

### PS TV

- The PS TV pairs DualShock 3 / 4 by itself. RePad leaves those to the system.
- RePad adds the controllers the PS TV does not accept, such as the DualSense and the Switch Pro. Pair them in
  Settings > Devices > Bluetooth Devices as above.
- The system's controllers keep ports 1, 2, ...; RePad's controllers take the next free ports.
- Not yet tested on a PS TV: reports are welcome.

### Button layout

- Sony controllers: as on the Vita. L1 / L2 = L, R1 / R2 = R.
- Switch Pro, by position: A = Circle, B = Cross, X = Triangle, Y = Square, L / ZL = L, R / ZR = R, - = Select,
  \+ = Start, HOME = PS.

## Known limits

- A controller that connected before RePad started (when an app loads it) has to connect again.
- Not working:
  - DataFrog S80: it does not connect.
  - Xbox controllers: no driver yet.
  - DualShock 3 on a handheld Vita: no driver yet.

## Build

Needs [VitaSDK](https://vitasdk.org).

```
bash build.sh        # build/repad.skprx
```

## License

MIT, see `LICENSE`.
