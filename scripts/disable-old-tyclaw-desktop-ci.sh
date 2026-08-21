#!/usr/bin/env bash
# Run while authenticated as feiandxs (or org admin on tyclaw-release)
set -euo pipefail
REPO=feiandxs/tyclaw-release
# Build Desktop Release + Check Notarization Status (+ optional Build Core if unused)
for id in 249232519 307066664; do
  echo "Disabling workflow $id on $REPO"
  gh api -X PUT "repos/$REPO/actions/workflows/$id/disable"
done
gh api "repos/$REPO/actions/workflows" --jq '.workflows[]|select(.path|test("desktop|notary"))|{id,name,state,path}'
