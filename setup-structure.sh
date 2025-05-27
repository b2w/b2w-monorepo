#!/bin/bash

# ==========================================
# B2W Monorepo Structure Setup Script
# ==========================================
#
# FIRST-TIME USE INSTRUCTIONS:
#
# 1. You just unzipped the `b2w-monorepo.zip` to a clean folder.
# 2. Now open a terminal in the folder `b2w-monorepo`
# 3. Make sure all scripts are executable:
#      chmod +x *.sh
# 4. Run the structure setup script:
#      ./setup-structure.sh
#
# This will:
# - Ensure the full monorepo folder structure exists (fills in missing folders)
# - Check environment and install dependencies
# - Maintain and update monorepo structure over time
#
# To re-check your environment or install dependencies later, use:
#   ./infra/setup/check-b2w-env.sh
#   ./infra/setup/install-missing.sh

# === STRUCTURE SETUP LOGIC START ===

set -e

MONOREPO_ROOT="."

# Step 1: Ensure monorepo structure always exists
echo "
=== Ensuring Monorepo Directory Structure ==="
mkdir -p $MONOREPO_ROOT/{apps/_template-app/ui,packages/{core,ui,utils,types},infra/setup,workflows/{generate,update,deploy}}
find $MONOREPO_ROOT -type d -exec touch {}/.gitkeep \;

# Step 1b: Create minimal package.json if missing
if [[ ! -f "$MONOREPO_ROOT/package.json" ]]; then
  echo '{"name": "b2w-monorepo", "private": true, "workspaces": []}' > "$MONOREPO_ROOT/package.json"
  echo "Created minimal package.json"
fi

# Step 2: Check environment and optionally install missing tools
if [[ -f "infra/setup/check-b2w-env.sh" ]]; then
  echo "
=== BOOTSTRAP STEP 2: Checking Environment ==="
  chmod +x infra/setup/check-b2w-env.sh
  ./infra/setup/check-b2w-env.sh
fi

if [[ -f "infra/setup/install-missing.sh" ]]; then
  read -p "Install missing tools if needed? (y/n): " yn
  if [[ $yn == "y" ]]; then
    chmod +x infra/setup/install-missing.sh
    ./infra/setup/install-missing.sh
  fi
fi

if [[ -f "package.json" ]]; then
  pnpm install || echo "⚠️ pnpm install failed — try running it manually."
else
  echo "ℹ️ No package.json found — skipping pnpm install."
fi

# Step 3: Final message
echo "
=== SETUP COMPLETE ==="
echo "You can now start building inside this folder."
echo "Run this script again to ensure structure stays up to date."
