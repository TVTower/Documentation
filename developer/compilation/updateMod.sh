#!/bin/bash

# Use this script on a fresh BlitzMax-NG installation to clone the latest
# modules source from GitHub. Also delete any unneeded mods.

cd mod

rm -rf audio.mod
git clone https://github.com/bmx-ng/audio.mod.git

rm -rf crypto.mod

rm -rf image.mod
git clone https://github.com/bmx-ng/image.mod.git

rm -rf maxgui.mod
git clone https://github.com/bmx-ng/maxgui.mod.git

rm -rf mky.mod

rm -rf sdl.mod
git clone https://github.com/bmx-ng/sdl.mod.git

rm -rf steam.mod

rm -rf text.mod
git clone https://github.com/bmx-ng/text.mod.git