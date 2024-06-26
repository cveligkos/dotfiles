#!/usr/bin/env bash

set -euo pipefail

xrandr --output DisplayPort-0 --mode 2560x1440 --pos 1440x685 --dpi 109 --rate 144 --set TearFree on --primary \
       --output DisplayPort-1 --mode 2560x1440 --pos 4000x685 --dpi 109 --rate 144 --set TearFree on \
       --output HDMI-A-0      --mode 2560x1440 --pos 0x0      --dpi 109 --rate 144 --set TearFree on --rotate left
