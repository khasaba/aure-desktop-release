# aure-desktop-release

Aureink 桌面端发版 CI（`khasaba` 个人仓，替代 `feiandxs/tyclaw-release`）。

- 源码：GitLab `gitlab.igora.ai/ty/aure-desktop`
- 打包：GitHub 托管 runner（`macos-latest` / `macos-15-intel` / `windows-latest`）
- 产物：七牛空间 `jiuwo-crm`，前缀 **`releases/aureink/`**
- 公网下载：`https://downloads.aure.ink/aure/...`（cheaptokens download-origin → CDN `https://crm-cdn.joywo.net`）

## 触发

```bash
# 预览包（无 tag）
gh workflow run build-desktop.yml -R khasaba/aure-desktop-release -f os=all

# 稳定版（指定 GitLab tag）
gh workflow run build-desktop.yml -R khasaba/aure-desktop-release -f os=all -f tag=v2.5.0

# 只打 Windows
gh workflow run build-desktop.yml -R khasaba/aure-desktop-release -f os=windows-x64 -f tag=v2.5.0
```

也支持 `repository_dispatch`：`event_type=build-release`，payload `{ "tag": "vX.Y.Z", "os": "all" }`。

## Secrets

见 [SECRETS.md](./SECRETS.md)。七牛必填；Apple / Windows 签名证书缺省时对应平台会失败（可先只跑有证书的平台）。

## 对象路径

```text
releases/aureink/changelog.yml
releases/aureink/macos/arm64/latest-mac.yml
releases/aureink/macos/arm64/Aureink-Mac-<ver>-Installer.zip
releases/aureink/macos/x64/...
releases/aureink/windows/x64/latest.yml
releases/aureink/windows/x64/Aureink-Windows-<ver>-Setup.exe
```

历史前缀 `releases/tyclaw/` 已废弃，请勿再写入。
