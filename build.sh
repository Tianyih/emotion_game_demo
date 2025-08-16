#!/bin/bash

# Install Flutter
echo "Installing Flutter..."
curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.5-stable.tar.xz
tar xf flutter.tar.xz
export PATH="$PATH:$PWD/flutter/bin"

# Get Flutter dependencies
echo "Getting Flutter dependencies..."
flutter pub get

# Build for web
echo "Building for web..."
flutter build web --release

echo "Build completed!"
