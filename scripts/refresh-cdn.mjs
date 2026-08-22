#!/usr/bin/env node
/**
 * Refresh Qiniu CDN URLs after release upload.
 * Env: QINIU_ACCESS_KEY, QINIU_SECRET_KEY
 * Args: absolute https URLs
 */
import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const qiniu = require("qiniu");

const accessKey = process.env.QINIU_ACCESS_KEY;
const secretKey = process.env.QINIU_SECRET_KEY;
const urls = process.argv.slice(2).filter(Boolean);

if (!accessKey || !secretKey) {
  console.error("missing QINIU_ACCESS_KEY / QINIU_SECRET_KEY");
  process.exit(1);
}
if (!urls.length) {
  console.error("usage: refresh-cdn.mjs <url> [url...]");
  process.exit(1);
}

const mac = new qiniu.auth.digest.Mac(accessKey, secretKey);
const cdnManager = new qiniu.cdn.CdnManager(mac);
cdnManager.refreshUrls(urls, (err, body, info) => {
  if (err || !info || info.statusCode !== 200) {
    console.error("refresh failed", err || body || info);
    process.exit(1);
  }
  console.log(JSON.stringify(body, null, 2));
});
