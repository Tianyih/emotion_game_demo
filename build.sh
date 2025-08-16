#!/bin/bash

set -e  # Exit on any error

echo "Starting build process..."

# Install Flutter
echo "Installing Flutter..."
curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.5-stable.tar.xz
tar xf flutter.tar.xz
export PATH="$PATH:$PWD/flutter/bin"

# Check Flutter installation
echo "Checking Flutter installation..."
flutter --version

# Get Flutter dependencies
echo "Getting Flutter dependencies..."
flutter pub get

# Build for web
echo "Building for web..."
flutter build web --release

# List build output
echo "Build output contents:"
ls -la build/web/

echo "Build completed!"
