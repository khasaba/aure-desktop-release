# Required GitHub Actions secrets

在仓库 Settings → Secrets and variables → Actions 配置：

| Secret | 用途 |
|--------|------|
| `GITLAB_DEPLOY_TOKEN_USER` | 只读克隆 `ty/aure-desktop` |
| `GITLAB_DEPLOY_TOKEN_PASS` | 同上 |
| `MAC_CSC_LINK` | macOS 签名证书 `.p12` 的 base64 |
| `APPLE_ID` | Apple 公证账号 |
| `APPLE_APP_SPECIFIC_PASSWORD` | Apple 应用专用密码 |
| `APPLE_TEAM_ID` | Apple Team ID |
| `R2_ACCESS_KEY_ID` | Cloudflare R2 |
| `R2_SECRET_ACCESS_KEY` | Cloudflare R2 |
| `R2_ENDPOINT` | R2 S3 API endpoint，形如 `https://<accountid>.r2.cloudflarestorage.com` |

本机一键写入（需已 `export GH_TOKEN=...`）：

```bash
./scripts/set-secrets-from-env.sh
```

脚本从环境变量读取同名值并调用 `gh secret set`。
