# Documentation Index

Tài liệu tổng hợp cho plugin `flutter_plugin_ic_nfc`.

## 📚 Tài liệu chính

### [README.md](README.md)
Tài liệu chính của plugin, bao gồm:
- Giới thiệu và tính năng
- Yêu cầu hệ thống
- Hướng dẫn cài đặt chi tiết
- Cấu hình Android và iOS
- Hướng dẫn sử dụng với ví dụ code
- API Reference
- Troubleshooting

**Đọc đầu tiên:** Nếu bạn mới bắt đầu sử dụng plugin.

### [QUICK_START.md](QUICK_START.md)
Hướng dẫn nhanh để bắt đầu:
- Cài đặt nhanh
- Cấu hình tối thiểu
- Ví dụ code cơ bản

**Đọc khi:** Bạn muốn bắt đầu nhanh chóng.

## 🔧 Tài liệu cho Developers

### [RELEASE_GUIDE.md](RELEASE_GUIDE.md)
Hướng dẫn chi tiết về release và versioning:
- Quy tắc Semantic Versioning
- Quy trình release từng bước
- Cách đóng gói plugin (Git/ZIP)
- Cách phân phối plugin
- Cập nhật khi SDK thay đổi
- Checklist release

**Đọc khi:** Bạn cần đóng gói và release plugin.

### [UPGRADE_SDK_GUIDE.md](UPGRADE_SDK_GUIDE.md)
Hướng dẫn nâng cấp VNPT NFC SDK và cấu hình Maven Local:
- Quy trình cập nhật file AAR
- Cấu hình file `publish_aar.sh` và `build.gradle`
- Cách build và làm sạch cache repository local
- Xác minh phiên bản SDK được resolve

**Đọc khi:** Bạn cần nâng cấp phiên bản Native SDK VNPT NFC.

### [CHANGELOG.md](CHANGELOG.md)
Lịch sử thay đổi của plugin:
- Tất cả các version đã release
- Tính năng mới
- Bug fixes
- Breaking changes

**Đọc khi:** Bạn muốn biết những gì đã thay đổi giữa các version.

## 👥 Tài liệu cho Người dùng

### [UPDATE_GUIDE.md](UPDATE_GUIDE.md)
Hướng dẫn cập nhật plugin:
- Cách kiểm tra version hiện tại
- Cập nhật từ Git repository
- Cập nhật từ ZIP file
- Xử lý breaking changes
- Migration guide
- Troubleshooting khi update

**Đọc khi:** Bạn cần cập nhật plugin lên version mới.

### [RELEASE_NOTES_TEMPLATE.md](RELEASE_NOTES_TEMPLATE.md)
Template cho release notes:
- Format chuẩn cho release notes
- Các section cần có
- Ví dụ và best practices

**Đọc khi:** Bạn cần tạo release notes cho version mới.

## 🛠️ Scripts và Tools

### `scripts/package.sh`
Script đóng gói plugin thành ZIP file:
- Tự động tạo ZIP file
- Loại bỏ files không cần thiết
- Tạo checksum
- Verify các file quan trọng

**Sử dụng:**
```bash
./scripts/package.sh
```

### `scripts/release.sh`
Script tự động hóa quy trình release:
- Tự động bump version
- Chạy tests và analyzer
- Tạo git tag
- Đóng gói plugin
- Push lên remote

**Sử dụng:**
```bash
./scripts/release.sh
# hoặc
./scripts/release.sh 0.0.2 patch
```

## 📋 Checklist nhanh

### Khi bắt đầu sử dụng plugin
1. ✅ Đọc [README.md](README.md)
2. ✅ Xem [QUICK_START.md](QUICK_START.md)
3. ✅ Cài đặt và cấu hình theo hướng dẫn
4. ✅ Test với ví dụ code

### Khi cần cập nhật plugin
1. ✅ Đọc [UPDATE_GUIDE.md](UPDATE_GUIDE.md)
2. ✅ Xem [CHANGELOG.md](CHANGELOG.md) để biết thay đổi
3. ✅ Kiểm tra breaking changes
4. ✅ Backup code hiện tại
5. ✅ Cập nhật và test

### Khi cần release version mới
1. ✅ Đọc [RELEASE_GUIDE.md](RELEASE_GUIDE.md)
2. ✅ Update version trong pubspec.yaml
3. ✅ Update CHANGELOG.md
4. ✅ Chạy `./scripts/release.sh`
5. ✅ Tạo release notes từ template
6. ✅ Phân phối cho người dùng

## 🔗 Liên kết nhanh

- **Cài đặt:** [README.md#cài-đặt](README.md#cài-đặt)
- **Sử dụng:** [README.md#sử-dụng](README.md#sử-dụng)
- **Troubleshooting:** [README.md#troubleshooting](README.md#troubleshooting)
- **API Reference:** [README.md#api-reference](README.md#api-reference)
- **Release:** [RELEASE_GUIDE.md](RELEASE_GUIDE.md)
- **Update:** [UPDATE_GUIDE.md](UPDATE_GUIDE.md)
- **Upgrade SDK & Maven Local:** [UPGRADE_SDK_GUIDE.md](UPGRADE_SDK_GUIDE.md)

## 📞 Hỗ trợ

Nếu bạn không tìm thấy thông tin cần thiết:
1. Kiểm tra [Troubleshooting](README.md#troubleshooting) trong README
2. Xem [CHANGELOG.md](CHANGELOG.md) để biết các thay đổi gần đây
3. Liên hệ team phát triển

---

**Last Updated:** 2024
**Plugin Version:** 0.0.1

