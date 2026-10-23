# AGENTS.md

Trang tĩnh một file: `index.html` (HTML, CSS, JS inline, ảnh nhúng base64). Trang phối đồ sơ mi "Hôm nay Thanh mặc gì?".

Quy tắc:
- Chỉ sửa `index.html` cho thay đổi giao diện hoặc logic. Không thêm framework hay bước build phức tạp.
- Không xoá hoặc thay các ảnh `data:image/jpeg` đã nhúng.
- Không dùng script ngoài. Style và font ngoài chỉ từ Google Fonts, khớp CSP trong `_headers`.
- Chạy `npm run check` và `npm run build` trước khi commit.
- Không commit token hay secret. Deploy do GitHub Actions (`.github/workflows/deploy.yml`) lên Cloudflare Pages project `phoido`, domain phoido.danhthanh.dev.
- Không đổi tên project `phoido` và không sửa workflow nếu không được yêu cầu.
