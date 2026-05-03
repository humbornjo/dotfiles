# Host

For a full-feature proxy use, download mihomo

```bash
# MacOS
brew install mihomo
```

Configure control page by downloading releases [ui](https://github.com/Zephyruso/zashboard) and extract to `/etc/mihomo/ui` (personal preference).

Save your clash.meta compatiable config file to `/etc/mihomo/config.yaml`, and make sure the following fields settled.

```yaml
external-ui: /etc/mihomo/ui
external-controller: 0.0.0.0:9090
```

Bare matel run with `sudo mihomo -d /etc/mihomo` so that tun mode is allowed.

For systemd-like control, here is a launchd manifest.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.<USER>.mihomo</string>

    <key>ProgramArguments</key>
    <array>
        <string>mihomo</string>
        <string>-d</string>
        <string>/etc/mihomo</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <dict>
        <key>NetworkState</key>
        <true/>
    </dict>

    <key>LimitLoadToSessionType</key>
    <array>
        <string>System</string>
    </array>
</dict>
</plist>
```

# Docker

Refer to `./docker-compose.yml`
