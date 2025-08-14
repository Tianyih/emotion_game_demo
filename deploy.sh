#!/bin/bash

# Deploy Flutter Web to GitHub Pages
# This script builds the Flutter web app and prepares it for GitHub Pages deployment

set -e

echo "🚀 Starting Flutter Web deployment process..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

echo "📦 Getting Flutter dependencies..."
flutter pub get

echo "🔍 Running Flutter analyze..."
flutter analyze

echo "🧪 Running tests..."
flutter test

echo "🏗️  Building Flutter web app..."
# Build for GitHub Pages with correct base href
flutter build web --release --base-href "/emotion_game_demo/"

echo "✅ Build completed successfully!"
echo "📁 Build files are located in: build/web/"
echo ""
echo "📋 Next steps to deploy to GitHub Pages:"
echo "1. Commit all changes to your repository"
echo "2. Push to GitHub"
echo "3. Enable GitHub Pages in your repository settings"
echo "4. Select 'GitHub Actions' as the source"
echo "5. The GitHub Actions workflow will automatically deploy your app"
echo ""
echo "🌐 Your app will be available at: https://[your-username].github.io/emotion_game_demo/"
