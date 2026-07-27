# aure-desktop-release

Aureink 桌面端发版 CI（个人仓库）。从 GitLab `ty/aure-desktop` 拉源码，在 GitHub Actions 上打包并上传 Cloudflare R2。

## 触发

```bash
# 预览包（无 tag）
gh workflow run build-desktop.yml -R khasaba/aure-desktop-release -f os=all

# 稳定版（指定 GitLab tag，例如 v2.4.1）
gh workflow run build-desktop.yml -R khasaba/aure-desktop-release -f os=all -f tag=v2.4.1
```

也支持 `repository_dispatch`：`event_type=build-release`，payload `{ "tag": "vX.Y.Z", "os": "all" }`。

## Secrets

见 [SECRETS.md](./SECRETS.md)。配齐后才能签名、公证并上传 R2。

## 产物

上传到 R2 bucket `files` 前缀 `releases/tyclaw/`（与现网 download-worker 一致）。
