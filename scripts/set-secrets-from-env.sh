#!/usr/bin/env bash
set -euo pipefail
REPO="${REPO:-khasaba/aure-desktop-release}"
required=(
  GITLAB_DEPLOY_TOKEN_USER
  GITLAB_DEPLOY_TOKEN_PASS
  MAC_CSC_LINK
  APPLE_ID
  APPLE_APP_SPECIFIC_PASSWORD
  APPLE_TEAM_ID
  R2_ACCESS_KEY_ID
  R2_SECRET_ACCESS_KEY
  R2_ENDPOINT
)
missing=()
for key in "${required[@]}"; do
  if [[ -z "${!key:-}" ]]; then
    missing+=("$key")
  fi
done
if ((${#missing[@]})); then
  echo "Missing env vars: ${missing[*]}" >&2
  echo "Export them first, then re-run." >&2
  exit 1
fi
for key in "${required[@]}"; do
  printf '%s' "${!key}" | gh secret set "$key" --repo "$REPO"
  echo "set $key"
done
echo "All secrets set on $REPO"
