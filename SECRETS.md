# Required GitHub Actions secrets

仓库 Settings → Secrets and variables → Actions：

| Secret | 用途 |
|--------|------|
| `GITLAB_DEPLOY_TOKEN_USER` | 只读克隆 `ty/aure-desktop`（`gitlab.igora.ai`） |
| `GITLAB_DEPLOY_TOKEN_PASS` | 同上 |
| `QINIU_ACCESS_KEY` | 七牛 AccessKey |
| `QINIU_SECRET_KEY` | 七牛 SecretKey |
| `QINIU_S3_ENDPOINT` | 七牛 S3 兼容端点（华北 z1：`https://s3-cn-north-1.qiniucs.com`） |
| `QINIU_CDN_BASE_URL` | CDN 根，如 `https://crm-cdn.joywo.net`（刷新缓存用） |
| `MAC_CSC_LINK` | macOS 签名证书 `.p12` 的 base64（可选，无则无法正式签名） |
| `APPLE_ID` | Apple 公证账号（可选） |
| `APPLE_APP_SPECIFIC_PASSWORD` | Apple 应用专用密码（可选） |
| `APPLE_TEAM_ID` | Apple Team ID（可选） |

仓库 env（workflow 内已写死，一般无需 Secret）：

- `QINIU_BUCKET=jiuwo-crm`
- `RELEASE_PREFIX=releases/aureink`

本机一键写入（需已 `gh auth`）：

```bash
source ~/.domain   # 或 export QINIU_* / GITLAB_*
./scripts/set-secrets-from-env.sh
```
