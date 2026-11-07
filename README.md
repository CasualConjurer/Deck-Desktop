<h1 align="center">Deck Desktop</h1>

An alternate custom configurated desktop environment for the Steam Deck built with [MangoWM](https://github.com/mangowm/mango) and [Noctalia Shell](https://github.com/noctalia-dev/noctalia). It installs alongside Plasma Desktop without changing most of the defuaults. 

---

### Important Notes
- This installation is for the CachyOS Handheld Edition, meaning there are no immutable drives present, and mostly everything is configurable
- ***DO NOT*** `git clone` into the `$HOME` directory unless you know what you are doing. Copy the files in their respective folders. (I will provide a Script in the future to automate this process) 
- Syncing is now handled by an `rclone` bash script. Please be advised of the possible file deletions in your $HOME folder 

---

#### Disabling the Autologin of Steam OS

On the usual install of steam OS on handhelds, the environments would be Desktop Mode (Plasma-Wayland) and Gamemode(Gamescope). Even with installing another Desktop Environment through Plasma, there is still no way of switching without in depth configuration. As a workaround, I found this [forum](https://discuss.cachyos.org/t/how-to-avoid-steamos-autologin/23162/13) that disables the autologin entirely, which greets you with `plasma login` every time you switch environments.

Files:

`/etc/sddm.conf.d/zzz-override-cachyos-settings.conf/` for `sddm`

`/etc/plasmalogin.conf.d/zzz-override-cachyos-settings.conf` for `plasma-login-manager`

Add the following to the file:

```
[Autologin]
Relogin=false
Session=
User=
```

Then reboot your device

---

> Requirements / Installed Packages

Most of the necessary packages are installed on standard CachyOS Handheld, these are the custom installed ones necessary for this configuration.

- `mango`
- `noctalia`
- `neovim`
- `superfile`


> Installation

Currently, the only install process would be copying everything (except the Readme file) into your `.config` folder, possibly replacing some of the default configs.

- Git clone in a projects directory of your choosing.
- modify the `dots-bisync.sh` script to check for any errors
- run `./dots-bisync.sh --resync --dry-run` to check for any errors. Then remove the `--dry-run`, then the `--resync`.
- You may now automate the syncing to a cron job.

> [!note] Sync Issues
> Please be advised that i have not tested this yet with individual user configurations. For now, the script will use the latest modified file as a main.

---

Feel free to message me for any bugs or features you might want, or contribute


#### To-Do List

- [ ] Keymaps button
- [ ] Install Script
- [ ] Sync Script
- [ ] Dots Documentation


