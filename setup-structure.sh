#!/bin/bash

# === B2W Monorepo Structure Setup ===
# Creates core folder structure and validates base setup

set -e

printf "\n=== Ensuring Monorepo Directory Structure ===\n\n"

MONOREPO_ROOT=$(pwd)

# Create folder structure
mkdir -p $MONOREPO_ROOT/apps/_template-app/{ui,cli,api,qr,mobile,cdn}
mkdir -p $MONOREPO_ROOT/packages/{core,ui,utils,types}
mkdir -p $MONOREPO_ROOT/infra/setup
mkdir -p $MONOREPO_ROOT/workflows/{generate,update,deploy}

# Placeholder app generator
cat << 'EOF' > $MONOREPO_ROOT/workflows/generate/create-app.sh
#!/bin/bash
echo "⚠️  create-app.sh is a placeholder."
echo "To scaffold a new app manually:"
echo "cp -r apps/_template-app apps/<your-app-name>"
echo "Then customize your new app."
EOF
chmod +x $MONOREPO_ROOT/workflows/generate/create-app.sh

# Add minimal package.json
if [ ! -f package.json ]; then
  echo '{ "name": "b2w-monorepo", "private": true, "workspaces": ["apps/*", "apps/*/*", "packages/*"] }' > package.json
  echo "Created minimal package.json"
fi

# Ensure setup scripts are executable
chmod +x $MONOREPO_ROOT/infra/setup/*.sh 2>/dev/null || true

printf "\n=== BOOTSTRAP STEP 2: Checking Environment ===\n"
$MONOREPO_ROOT/infra/setup/check-b2w-env.sh || echo "⚠️  Environment check script not found"

printf "\n=== SETUP COMPLETE ===\n"
echo "You can now start building inside this folder."
echo "Run this script again to ensure structure stays up to date."
