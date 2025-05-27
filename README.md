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
│       └── ui/                   # Starter Svelte+Vite+Tailwind UI
├── packages/
│   ├── core/
│   ├── ui/
│   ├── utils/
│   └── types/
├── infra/
│   └── setup/
│       ├── setup-structure.sh    # Creates and validates structure
│       ├── check-b2w-env.sh      # Environment validation
│       └── install-missing.sh    # Installs needed tools
├── workflows/
│   ├── generate/
│   ├── update/
│   └── deploy/
├── package.json                  # Declares metadata
├── pnpm-lock.yaml               # Locked dependencies
├── pnpm-workspace.yaml          # Declares monorepo packages
├── setup-structure.sh           # Entry point setup script
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
  - 'packages/*'
```

## ✅ Status
Tested and verified on macOS + pnpm v10. Supports GitHub or local-first workflows.

---
© B2W Platform – All rights reserved.
