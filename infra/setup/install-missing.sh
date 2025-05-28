#!/bin/bash

# ==========================================
# B2W Monorepo Install Missing Tools Script
# ==========================================

set -e

echo "Installing missing tools for B2W Stack..."
echo "----------------------------------------"

# Ensure pnpm global bin is available
if ! pnpm bin -g &> /dev/null; then
  echo "⚠️  pnpm global bin directory not found. Attempting to run 'pnpm setup'..."
  pnpm setup || {
    echo "❌ Failed to run 'pnpm setup'. Please configure your PNPM_HOME manually."
    exit 1
  }
  echo "✅ Ran 'pnpm setup'. You may need to restart your terminal."
fi

# Ensure pnpm global bin is on PATH
GLOBAL_BIN=$(pnpm bin -g)
if [[ ":$PATH:" != *":$GLOBAL_BIN:"* ]]; then
  echo "⚠️  Global pnpm bin directory ($GLOBAL_BIN) is not in your PATH."
  echo "   Add the following to your ~/.zshrc or ~/.bashrc:"
  echo "     export PATH=\"$GLOBAL_BIN:\$PATH\""
fi

# Install Tailwind CSS if missing
if ! pnpm list -g tailwindcss &>/dev/null; then
  echo "Installing Tailwind CSS..."
  pnpm add -g tailwindcss
else
  echo "✔︎ Tailwind CSS already added (detected via pnpm)"
fi

# Install Vitest if missing
if ! pnpm list -g vitest &>/dev/null; then
  echo "Installing Vitest..."
  pnpm add -g vitest || echo "❌ Failed to install Vitest"
else
  echo "✔︎ Vitest already added"
fi

# Install Playwright if missing
if ! pnpm list -g playwright &>/dev/null; then
  echo "Installing Playwright..."
  pnpm add -g playwright || echo "❌ Failed to install Playwright"
else
  echo "✔︎ Playwright already added"
fi

# Check ADB
if ! command -v adb &> /dev/null; then
  echo "✘ Android ADB not found."
  echo "➡️  Please install Android Studio from:"
  echo "    https://developer.android.com/studio"
  echo
  echo "After installing, open Android Studio and:"
  echo "  1. Go to Preferences > SDK Manager"
  echo "  2. Install 'Android SDK Platform-Tools' and 'Command-line Tools (latest)'"
  echo
  echo "To activate adb in terminal, add this to your ~/.zshrc:"
  echo "  export ANDROID_HOME=\$HOME/Library/Android/sdk"
  echo "  export PATH=\$PATH:\$ANDROID_HOME/platform-tools"
else
  echo "✔︎ Android ADB found"
fi

echo -e "\n✅ All missing tools installed or queued. Restart terminal if PATHs were updated."
