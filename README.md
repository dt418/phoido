# Phối đồ sơ mi

Trang tĩnh một file, host trên Cloudflare Pages: https://phoido.danhthanh.dev

Secrets cần có trong GitHub (Settings → Secrets and variables → Actions):
`CLOUDFLARE_API_TOKEN`, `CLOUDFLARE_ACCOUNT_ID`, `CLOUDFLARE_ZONE_ID`.

Thứ tự lần đầu: merge PR → Actions → "Setup Cloudflare" → Run workflow (một lần) → Actions → "Deploy" → Re-run.
Sau đó mỗi lần push lên `main` tự deploy; mỗi PR có bản preview.

GitHub Pages: https://dt418.github.io/phoido/ (workflow `Deploy GitHub Pages`; cần bật Settings → Pages → Source: GitHub Actions).
