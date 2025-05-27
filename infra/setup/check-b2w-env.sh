#!/bin/bash

# ==========================================
# B2W Monorepo Environment Check Script
# ==========================================

set -e

print_check() {
  if command -v $1 &> /dev/null; then
    echo "✔︎ $2: $(eval $3)"
  else
    echo "✘ $2: Not found"
  fi
}

echo "Checking B2W Stack Environment..."
echo "----------------------------------"

# Core Tools
echo "\n== Core Tools =="
print_check git "Git" "git --version"
print_check node "Node.js" "node -v"
print_check npm "npm" "npm -v"
print_check pnpm "pnpm" "pnpm -v"
print_check vite "Vite" "vite --version"

# Dev Environment
echo "\n== Dev Environment =="
print_check brew "Homebrew" "brew --version | head -n 1"
print_check code "VS Code (code CLI)" "code --version | head -n 1"
print_check docker "Docker" "docker --version"

# Deployment Tools
echo "\n== Deployment Tools =="
print_check aws "AWS CLI" "aws --version"

# Frontend Tools
echo "\n== Frontend Tools =="
if pnpm list -g tailwindcss &> /dev/null; then
  echo "✔︎ Tailwind CSS: found via pnpm"
else
  echo "✘ Tailwind CSS: Not found"
fi
print_check vitest "Vitest" "vitest --version"
print_check playwright "Playwright" "playwright --version"

# Mobile Tools
echo "\n== Mobile / Android SDK =="
print_check adb "ADB (Android Debug Bridge)" "adb version | head -n 1"

# Final Message
echo "\n✅ Environment check complete. Review any ✘ above before proceeding."
