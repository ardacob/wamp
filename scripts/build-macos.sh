#!/bin/bash
set -euo pipefail
repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_dir="$repo_dir/outputs/WAMP.app"
build_dir="$repo_dir/work/build"
mkdir -p "$app_dir/Contents/MacOS" "$app_dir/Contents/Resources" "$build_dir/module-cache"
cp "$repo_dir/macos/Info.plist" "$app_dir/Contents/Info.plist"
cp "$repo_dir/web/index.html" "$app_dir/Contents/Resources/player.html"
cp "$repo_dir/assets/WAMP.icns" "$app_dir/Contents/Resources/WAMP.icns"
for architecture in arm64 x86_64; do
  xcrun swiftc -swift-version 5 -O -target "${architecture}-apple-macos12.0" \
    -module-cache-path "$build_dir/module-cache" "$repo_dir/macos/WAMP.swift" \
    -o "$build_dir/WAMP-$architecture"
done
lipo -create "$build_dir/WAMP-arm64" "$build_dir/WAMP-x86_64" \
  -output "$app_dir/Contents/MacOS/WAMP"
codesign --force --deep --sign - "$app_dir"
printf 'Built: %s\n' "$app_dir"
