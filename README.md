# B2W Monorepo Seed

A minimal, portable, automation-ready monorepo for local-first, offline-capable apps.

## 🔧 Features
- One-command structure setup: `setup-structure.sh`
- Environment validation and install via `infra/setup/*.sh`
- `pnpm` workspace support
- Tailwind, Vitest, Playwright preconfigured
- Scales from prototype to production handoff

## 📦 Structure
```txt
b2w-monorepo/
├── apps/
│   └── _template-app/
│       ├── ui/           # Web interface (SPA, PWA)
│       ├── cli/          # Local terminal tools
│       ├── api/          # Sync/server interface or routing layer
│       ├── qr/           # Minimal QR interface (tokenized links)
│       ├── mobile/       # Native mobile app (placeholder)
│       └── cdn/          # Static assets for global edge delivery
├── packages/
│   ├── core/
│   ├── ui/
│   ├── utils/
│   └── types/
├── infra/
│   └── setup/
│       ├── setup-structure.sh    # Creates and validates structure
│       ├── check-b2w-env.sh      # Environment validation
│       └── install-missing.sh    # Installs needed tools (runs `pnpm setup` if needed)
├── workflows/
│   ├── generate/
│   │   └── create-app.sh         # Placeholder script for new app scaffolding
│   ├── update/
│   └── deploy/
├── package.json                  # Declares workspaces
├── pnpm-workspace.yaml           # Locked dependencies and workspace config
├── setup-structure.sh            # Entry point setup script
```

## 🚀 Quickstart
```bash
# 1. Make scripts executable
chmod +x *.sh

# 2. Run structure + env check
./setup-structure.sh
```

## 📁 Workspaces
Defined in `pnpm-workspace.yaml`:
```yaml
packages:
  - 'apps/*'
  - 'apps/*/*'
  - 'packages/*'
```

## ✅ Status
Tested and verified on macOS + pnpm v10. Supports GitHub or local-first workflows.
Handles missing pnpm global bin directory on fresh installs by running `pnpm setup` automatically.

---
© B2W Platform – All rights reserved.
