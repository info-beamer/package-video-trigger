[![Import](https://cdn.infobeamer.com/s/img/import.png)](https://info-beamer.com/use?url=https://github.com/info-beamer/package-video-trigger)

# Description

Starts a video upon receiving a remote signal delivered by UDP: Use
[info-beamer hosted](https://info-beamer.com/hosted) to easily deploy
the video to any number of Pis. Then trigger simultaneous video playback
from another machine by sending a UDP package to each Pi.

# Installation

- [Install](https://info-beamer.com/doc/installing-hosted) info-beamer hosted OS
  on a Pi.
- Before you boot up the device, add the file
  `/config/bind_address` to the first partition of your SD card and
  put in `0.0.0.0`. This will make the info-beamer process
  running on the device reachable from outside. See also the
  [documentation](https://info-beamer.com/doc/device-configuration#exposeinfobeamerports).
  If you skip this step, the following commands *won't* work!
- If your network has DHCP but doesn't guarantee stable IP addresses,
  you might want to statically configure your network. See the
  [documentation](https://info-beamer.com/doc/device-configuration#staticnetworkconfiguration)
  for that.
- Import this package (click the orange button above)
- Create a setup based on this package and configure the video you want to play.
- Assign the setup to your device
- Find out the IP address of your device. You can see the
  local IP address of each device on the device detail page.

From another machine, if bash is used as a shell (of course replace the IP with the IP of your device):

```
$ echo root/trigger: > /dev/udp/192.168.1.XXX/4444
```

This will trigger your video. If you want to abort the current playback, use

```
$ echo root/abort: > /dev/udp/192.168.1.XXX/4444
```

You can of course use any other network capable programming language
to send those UDP packets instead of using bash. And there's no reason
to just use a single Pi: The more, the better :-)
