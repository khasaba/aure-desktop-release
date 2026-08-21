#!/usr/bin/env bash
set -euo pipefail
REPO="${REPO:-khasaba/aure-desktop-release}"
TAG="${TAG:-v2.5.0}"
OS="${OS:-all}"

# Load local secrets if present
[[ -f "$HOME/.domain" ]] && source "$HOME/.domain"
[[ -f "$HOME/.secrets" ]] && source "$HOME/.secrets"

: "${QINIU_S3_ENDPOINT:=https://s3-cn-north-1.qiniucs.com}"
: "${QINIU_CDN_BASE_URL:=https://crm-cdn.joywo.net}"

need() { [[ -n "${!1:-}" ]] || { echo "missing $1"; exit 1; }; }
need QINIU_ACCESS_KEY
need QINIU_SECRET_KEY
need GITLAB_DEPLOY_TOKEN_USER
need GITLAB_DEPLOY_TOKEN_PASS

echo "==> Setting secrets on $REPO"
for key in QINIU_ACCESS_KEY QINIU_SECRET_KEY QINIU_S3_ENDPOINT QINIU_CDN_BASE_URL \
           GITLAB_DEPLOY_TOKEN_USER GITLAB_DEPLOY_TOKEN_PASS; do
  printf '%s' "${!key}" | gh secret set "$key" --repo "$REPO"
  echo "  set $key"
done
for key in MAC_CSC_LINK APPLE_ID APPLE_APP_SPECIFIC_PASSWORD APPLE_TEAM_ID; do
  if [[ -n "${!key:-}" ]]; then
    printf '%s' "${!key}" | gh secret set "$key" --repo "$REPO"
    echo "  set $key"
  else
    echo "  skip optional $key"
  fi
done

echo "==> Trigger Build Desktop Release tag=$TAG os=$OS"
gh workflow run build-desktop.yml -R "$REPO" -f "os=$OS" -f "tag=$TAG"
sleep 3
gh run list -R "$REPO" --workflow=build-desktop.yml --limit 3
echo "Watch: gh run watch -R $REPO"
