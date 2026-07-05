#!/bin/bash
set -e
cd "$(dirname "$0")"

APP="TickBar.app"
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"

# --- Icon ---
swiftc -O makeicon.swift -o /tmp/ms_makeicon -framework Cocoa
/tmp/ms_makeicon /tmp/ms_icon_1024.png

ICONSET="/tmp/AppIcon.iconset"
rm -rf "$ICONSET"; mkdir -p "$ICONSET"
sips -z 16   16   /tmp/ms_icon_1024.png --out "$ICONSET/icon_16x16.png"      >/dev/null
sips -z 32   32   /tmp/ms_icon_1024.png --out "$ICONSET/icon_16x16@2x.png"   >/dev/null
sips -z 32   32   /tmp/ms_icon_1024.png --out "$ICONSET/icon_32x32.png"      >/dev/null
sips -z 64   64   /tmp/ms_icon_1024.png --out "$ICONSET/icon_32x32@2x.png"   >/dev/null
sips -z 128  128  /tmp/ms_icon_1024.png --out "$ICONSET/icon_128x128.png"    >/dev/null
sips -z 256  256  /tmp/ms_icon_1024.png --out "$ICONSET/icon_128x128@2x.png" >/dev/null
sips -z 256  256  /tmp/ms_icon_1024.png --out "$ICONSET/icon_256x256.png"    >/dev/null
sips -z 512  512  /tmp/ms_icon_1024.png --out "$ICONSET/icon_256x256@2x.png" >/dev/null
sips -z 512  512  /tmp/ms_icon_1024.png --out "$ICONSET/icon_512x512.png"    >/dev/null
cp /tmp/ms_icon_1024.png "$ICONSET/icon_512x512@2x.png"
iconutil -c icns "$ICONSET" -o "$APP/Contents/Resources/AppIcon.icns"

# --- Sounds ---
python3 gensounds.py
cp sounds/*.wav "$APP/Contents/Resources/"

# --- Binary ---
swiftc -O main.swift -o "$APP/Contents/MacOS/TickBar" -framework Cocoa
cp Info.plist "$APP/Contents/Info.plist"

echo "Done: $(pwd)/$APP"
echo "Run:  open \"$(pwd)/$APP\""
