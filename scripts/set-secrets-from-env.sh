#!/usr/bin/env bash
set -euo pipefail
REPO="${REPO:-khasaba/aure-desktop-release}"

required=(
  GITLAB_DEPLOY_TOKEN_USER
  GITLAB_DEPLOY_TOKEN_PASS
  QINIU_ACCESS_KEY
  QINIU_SECRET_KEY
  QINIU_S3_ENDPOINT
  QINIU_CDN_BASE_URL
)

optional=(
  MAC_CSC_LINK
  APPLE_ID
  APPLE_APP_SPECIFIC_PASSWORD
  APPLE_TEAM_ID
)

# Defaults from common local env names
: "${QINIU_ACCESS_KEY:=${QINIU_ACCESS_KEY-}}"
: "${QINIU_SECRET_KEY:=${QINIU_SECRET_KEY-}}"
: "${QINIU_S3_ENDPOINT:=${QINIU_S3_ENDPOINT:-https://s3-cn-north-1.qiniucs.com}}"
: "${QINIU_CDN_BASE_URL:=${QINIU_CDN_BASE_URL:-https://crm-cdn.joywo.net}}"

missing=()
for key in "${required[@]}"; do
  if [[ -z "${!key:-}" ]]; then
    missing+=("$key")
  fi
done
if ((${#missing[@]})); then
  echo "Missing env vars: ${missing[*]}" >&2
  echo "Export them first (source ~/.domain for Qiniu), then re-run." >&2
  exit 1
fi

for key in "${required[@]}"; do
  printf '%s' "${!key}" | gh secret set "$key" --repo "$REPO"
  echo "set $key"
done

for key in "${optional[@]}"; do
  if [[ -n "${!key:-}" ]]; then
    printf '%s' "${!key}" | gh secret set "$key" --repo "$REPO"
    echo "set $key"
  else
    echo "skip optional $key (unset)"
  fi
done

echo "All available secrets set on $REPO"
