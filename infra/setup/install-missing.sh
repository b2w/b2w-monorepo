#!/bin/bash

# ==========================================
# B2W Monorepo Install Missing Tools Script
# ==========================================

set -e

echo "Installing missing tools for B2W Stack..."
echo "----------------------------------------"

# Tailwind CSS
if ! pnpm list -g tailwindcss &> /dev/null; then
  echo "Installing Tailwind CSS..."
  pnpm add -g tailwindcss || echo "❌ Failed to install Tailwind CSS"
else
  echo "✔︎ Tailwind CSS already added (detected via pnpm)"
fi

# Vitest
if ! command -v vitest &> /dev/null; then
  echo "Installing Vitest..."
  pnpm add -g vitest || echo "❌ Failed to install Vitest"
else
  echo "✔︎ Vitest already added"
fi

# Playwright
if ! command -v playwright &> /dev/null; then
  echo "Installing Playwright..."
  pnpm add -g playwright || echo "❌ Failed to install Playwright"
else
  echo "✔︎ Playwright already added"
fi

# ADB (Android Debug Bridge)
if ! command -v adb &> /dev/null; then
  echo "✘ Android ADB not found."
  echo "➡️  Please install Android Studio from:"
  echo "    https://developer.android.com/studio"
  echo ""
  echo "After installing, open Android Studio and:"
  echo "  1. Go to Preferences > SDK Manager"
  echo "  2. Install 'Android SDK Platform-Tools' and 'Command-line Tools (latest)'"
  echo ""
  echo "To activate adb in terminal, add this to your ~/.zshrc:"
  echo "  export ANDROID_HOME=$HOME/Library/Android/sdk"
  echo "  export PATH=$PATH:$ANDROID_HOME/platform-tools"
else
  echo "✔︎ Android ADB already installed"
fi

echo "\n✅ All missing tools installed or queued. Restart terminal if PATHs were updated."
