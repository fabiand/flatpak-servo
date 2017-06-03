Simple way to build a flatpak around the Servo nightly binary builds.
The worst bit are the two binary blobs.

> Tested on Fedora 25

```bash
# Pre-requirement
$ pkcon install flatpak

# Build
$ make

# Run the flatpak-ed Servo
$ flatpak run org.servo.Servo

# OR

$ make run-app
```
