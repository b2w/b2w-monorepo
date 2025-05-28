#!/bin/bash

# B2W Monorepo Environment Check Script
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

echo -e "\n== Core Tools =="
print_check git "Git" "git --version"
print_check node "Node.js" "node -v"
print_check npm "npm" "npm -v"
print_check pnpm "pnpm" "pnpm -v"
print_check vite "Vite" "vite --version"

echo -e "\n== Dev Environment =="
print_check brew "Homebrew" "brew --version | head -n 1"
print_check code "VS Code (code CLI)" "which code"
print_check docker "Docker" "docker --version"

echo -e "\n== Deployment Tools =="
print_check aws "AWS CLI" "aws --version"

echo -e "\n== Frontend Tools =="
for tool in tailwindcss vitest playwright; do
  if pnpm list -g "$tool" &> /dev/null; then
    echo "✔︎ $tool: $(pnpm list -g --depth=0 $tool | grep $tool)"
  else
    echo "✘ $tool: Not found"
  fi
done

# Vega-Lite CLI check (any of its aliases)
if command -v vl2svg &> /dev/null || command -v vl2png &> /dev/null; then
  echo "✔︎ Vega-Lite CLI tools (vl2svg, vl2png...) detected"
else
  echo "✘ Vega-Lite CLI: Not found"
  echo "  ➡️  If installed via pnpm, ensure PNPM_HOME is in your PATH:"
  echo "      export PNPM_HOME=\$HOME/Library/pnpm"
  echo "      export PATH=\"\$PNPM_HOME:\$PATH\""
fi

echo -e "\n== Mobile / Android SDK =="
print_check adb "ADB (Android Debug Bridge)" "adb version | head -n 1"

echo -e "\n✅ Environment check complete. Review any ✘ above before proceeding."
