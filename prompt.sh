#!/usr/bin/env bash
# prompt — creates a WWW prompt template inside specs/<feature-name>/
# Usage: prompt <feature-name>
#
# OPTION A — tmux split + lazyvim (comment/uncomment to activate)
# OPTION B — $EDITOR fallback (active by default)

set -e

if [[ -z "$1" ]]; then
  echo "Usage: prompt <feature-name>"
  exit 1
fi

FEATURE=$(echo "$1" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
DATE=$(date +%Y%m%d)
BASE_DIR="./specs/${FEATURE}"

if [[ -d "$BASE_DIR" ]]; then
  VERSION=2
  while [[ -d "${BASE_DIR}-v${VERSION}" ]]; do
    VERSION=$((VERSION + 1))
  done
  BASE_DIR="${BASE_DIR}-v${VERSION}"
  FEATURE="${FEATURE}-v${VERSION}"
fi

mkdir -p "$BASE_DIR"
FILEPATH="${BASE_DIR}/prompt-${FEATURE}-${DATE}.md"

cat > "$FILEPATH" << 'TEMPLATE'
# FEATURE_NAME
Date: DATE_VALUE

## Why
# Concrete problem that generated this request.
# What is broken or missing today? What is the impact on the user?
#
# ❌ DON'T write: "Create the order list"
# ✅ Write: "User has no way to see past orders after checkout.
#           They return to home without purchase confirmation."

## What
# Expected behavior — happy path and error path.
# What the system must do, NOT how to implement it.
#
# ❌ DON'T write: "Use OrderProvider with two-column flex"
# ✅ Write: "Show order list with number, date, total.
#           Click opens detail. Order not found: 404."
#
# Architectural constraints (only if explicit and non-negotiable):
# ❌ DON'T write: "Use flex two columns" — that's layout, not a constraint
# ✅ Write: "OrderProvider wraps only /ordini/$orderId, not the parent layout"
#           "No tables. No sidebar."

## How
# Existing resources the agent can use — it decides how and where.
# List what exists and where to find it. Do not dictate usage.
#
# API:
# Ex: getOrder(orderId) — src/api/orders/
#
# Components:
# Ex: OrderSummaryPanel → src/routes/pagamento/riepilogo/$orderId.tsx
#     BillingAddressPanel → src/pages/shop/CheckoutShippingPage.tsx
#     CartVendorGroup → src/components/shop/CartVendorGroup.tsx
#
# Logic and patterns:
# Ex: OrderProvider → src/routes/pagamento/riepilogo/$orderId.tsx
#     auth pattern → src/routes/_authed/
#
# Layout (only if binding):
# Ex: "Vertical panels with Separator. No tables."

## Where
# Entry point + relevant files. No need to be exhaustive.
#
# entrypoint: src/...
# reference: src/...
TEMPLATE

sed -i "s/FEATURE_NAME/${FEATURE}/" "$FILEPATH"
sed -i "s/DATE_VALUE/${DATE}/" "$FILEPATH"

echo "Created: $FILEPATH"

# --- OPTION A: tmux split right + lazyvim ---
# tmux split-window -h -l 50% "nvim '$FILEPATH'"

# --- OPTION B: default editor (active) ---
${EDITOR:-vi} "$FILEPATH"
