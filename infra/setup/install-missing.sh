#!/usr/bin/env bash

# === B2W Tool Installer ===
# Installs missing global tools for the monorepo

set -e

# Ensure Bash >= 4
if [[ "${BASH_VERSINFO:-0}" -lt 4 ]]; then
  echo "❌ Bash 4.0+ is required to run this script."
  echo "➡️  Try running with Homebrew Bash: /opt/homebrew/bin/bash $0"
  exit 1
fi

echo "Installing missing tools for B2W Stack..."
echo "----------------------------------------"

# Helper: check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Helper: check if package is globally installed
pnpm_installed() {
  pnpm list -g --depth=0 "$1" >/dev/null 2>&1
}

# Tool install map
declare -A PNPM_TOOLS=(
  ["tailwindcss"]="Tailwind CSS"
  ["vitest"]="Vitest"
  ["playwright"]="Playwright"
  ["vega-lite"]="Vega-Lite CLI"
)

# Install via pnpm
for pkg in "${!PNPM_TOOLS[@]}"; do
  if pnpm_installed "$pkg"; then
    echo "✔︎ ${PNPM_TOOLS[$pkg]} already installed"
  else
    echo "➕ Installing ${PNPM_TOOLS[$pkg]}..."
    pnpm add -g "$pkg"
  fi
done

# Android ADB
if ! command_exists "adb"; then
  echo "✘ Android ADB not found."
  echo "➡️  Please install Android Studio from:"
  echo "    https://developer.android.com/studio"
  echo ""
  echo "After installing, open Android Studio and:"
  echo "  1. Go to Preferences > SDK Manager"
  echo "  2. Install 'Android SDK Platform-Tools' and 'Command-line Tools (latest)'"
  echo ""
  echo "To activate adb in terminal, add this to your ~/.zshrc:"
  echo '  export ANDROID_HOME=$HOME/Library/Android/sdk'
  echo '  export PATH="$ANDROID_HOME/platform-tools:$PATH"'
else
  echo "✔︎ Android ADB found"
fi

echo "✅ All missing tools installed or queued. Restart terminal if PATHs were updated."
