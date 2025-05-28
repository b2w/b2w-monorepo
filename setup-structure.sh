#!/bin/bash

# === B2W Monorepo Structure Setup ===
# Creates core folder structure and validates base setup

set -e

printf "\n=== Ensuring Monorepo Directory Structure ===\n\n"

# Set root if running from subdir
MONOREPO_ROOT="$(pwd)"

# Create base folders
mkdir -p $MONOREPO_ROOT/apps/_template-app/{ui,cli,api,qr,mobile,cdn}
mkdir -p $MONOREPO_ROOT/packages/{core,ui,utils,types}
mkdir -p $MONOREPO_ROOT/infra/setup
mkdir -p $MONOREPO_ROOT/workflows/{generate,update,deploy}

# Create placeholder create-app.sh script
cat << 'EOF' > $MONOREPO_ROOT/workflows/generate/create-app.sh
#!/bin/bash

# Placeholder for B2W create-app script
# This script will eventually scaffold a new app based on _template-app
# Example usage (to be implemented): ./create-app.sh my-new-app

echo "⚠️  create-app.sh is a placeholder. To scaffold a new app manually:"
echo "cp -r apps/_template-app apps/<your-app-name>"
echo "Then customize your new app as needed."
EOF

chmod +x $MONOREPO_ROOT/workflows/generate/create-app.sh

# Add minimal package.json if not present
if [ ! -f "$MONOREPO_ROOT/package.json" ]; then
  echo '{ "name": "b2w-monorepo", "private": true, "workspaces": ["apps/*", "apps/*/*", "packages/*"] }' > "$MONOREPO_ROOT/package.json"
  echo "Created minimal package.json"
fi

printf "\n=== BOOTSTRAP STEP 2: Checking Environment ===\n"
if [ -f "$MONOREPO_ROOT/infra/setup/check-b2w-env.sh" ]; then
  bash "$MONOREPO_ROOT/infra/setup/check-b2w-env.sh"
else
  echo "⚠️  Environment check script not found"
fi

printf "\n=== SETUP COMPLETE ===\n"
echo "You can now start building inside this folder."
echo "Run this script again to ensure structure stays up to date."
