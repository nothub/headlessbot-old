# headlessbot ![logo](src/main/resources/assets/headlessbot/icon.png)

A headless Minecraft bot built with [3arthqu4ke/HeadlessMc](https://github.com/3arthqu4ke/HeadlessMc)
and [cabaletta/baritone](https://github.com/cabaletta/baritone).

---

## Usage

[Tools required](https://github.com/nothub/headlessbot/blob/trunk/devbox.json#L3)
for execution and development are managed with [Devbox](https://github.com/jetify-com/devbox).

## Bot

Execute `devbox run bot` to start the bot.

### Server

Execute `devbox run server` to start a local test server.

### Monitoring

Execute `devbox run monitoring` to start some monitoring stuff.

Visit Grafana at [127.0.0.1:3000](http://127.0.0.1:3000/login) and check the dashboard.

## Behavior

The bots behavior is represented as [behavior tree](https://en.wikipedia.org/wiki/Behavior_tree).

## TODO

(Assorted Ideas)

### General / Misc

- [X] test disconnect/kick
- [X] expiring flags
- [X] global cooldowns
- [ ] inventory utils
- [ ] port [old player utils](https://github.com/nothub/headlessbot/blob/old/src/main/java/not/hub/headlessbot/util/PlayerStuff.java)
- [ ] more block groups
- [ ] baritone settings
- [ ] permission groups (admin commands)
- [ ] player standing (friend/foe) system
- [ ] config file
- [ ] http api for remote control
- [ ] webhook logs

### Behavior Tree

- [X] Tree walking
- [X] Composite nodes
- [X] Decorator nodes
- [ ] Port [old behavior](https://github.com/nothub/headlessbot/blob/old/src/main/java/not/hub/headlessbot/fsm/behaviour/Controller.java)
- [ ] WebUI
  - [ ] tree viewer
  - [ ] tree editor
  - [ ] tree manager

### Monitoring

- [X] Prometheus exporter

### Modules

- [ ] module system for non-tick based reactive logic
- [ ] [AutoArmor](https://github.com/nothub/headlessbot/blob/old/src/main/java/not/hub/headlessbot/modules/AutoArmorModule.java)
- [ ] [AutoTotem](https://github.com/nothub/headlessbot/blob/old/src/main/java/not/hub/headlessbot/modules/AutoTotemModule.java)
- [ ] Autoeat
- [ ] [BaritoneSettings](https://github.com/nothub/headlessbot/blob/old/src/main/java/not/hub/headlessbot/modules/BaritoneSettingsModule.java)
- [ ] Blink
- [ ] [ChatCommands](https://github.com/nothub/headlessbot/blob/old/src/main/java/not/hub/headlessbot/modules/ChatCommandsModule.java)
- [ ] [ChatSpam](https://github.com/nothub/headlessbot/blob/old/src/main/java/not/hub/headlessbot/modules/ChatSpamModule.java)
- [ ] CrystalAura
- [ ] [DataExport](https://github.com/nothub/headlessbot/blob/old/src/main/java/not/hub/headlessbot/modules/DataExportModule.java)
- [ ] [DisconnectDetector](https://github.com/nothub/headlessbot/blob/old/src/main/java/not/hub/headlessbot/modules/DisconnectDetectorModule.java)
- [ ] InventoryCleanup
- [ ] Jesus
- [ ] KillAura
- [ ] Noslow
- [ ] [Respawn](https://github.com/nothub/headlessbot/blob/old/src/main/java/not/hub/headlessbot/modules/RespawnModule.java)
- [ ] Safewalk
- [ ] Step
- [ ] [StuckDetector](https://github.com/nothub/headlessbot/blob/old/src/main/java/not/hub/headlessbot/modules/StuckDetectorModule.java)
- [ ] Velocity
- [ ] Visualrange (say hi to players)

### Chat Commands

- [ ] command system
- [ ] clear (clear area)
- [ ] take (go to player, pick up dropped items and check containers in range)
- [ ] guard (patrol and kill mobs around anchor position)
- [ ] chatlog (upload latest chatlog as paste)
- [ ] nbt (dump current inventory nbt data as paste)
- [ ] names (get old names of player)
- [ ] search (get infos from ddg/google/etc.)
- [ ] yt (search videos)
