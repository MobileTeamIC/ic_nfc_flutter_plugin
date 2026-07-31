# Hướng dẫn Nâng cấp VNPT NFC SDK & Cấu hình Maven Local

Tài liệu này hướng dẫn chi tiết cách nâng cấp thư viện Native SDK (`vnpt-nfc-sdk`) cho plugin Flutter và cách cấu hình kho lưu trữ Maven Local (`local-maven`) để giải quyết các phụ thuộc (dependencies) AAR nội bộ.

---

## 💡 Tổng quan về Cơ chế Maven Local

Do thư viện `vnpt-nfc-sdk` và `scanqr-ic-sdk` là các file đóng gói dưới dạng `.aar` nội bộ của VNPT và không được tải lên Maven Central công khai, chúng ta sử dụng một kho lưu trữ Maven cục bộ dạng thư mục nằm ngay trong dự án tại đường dẫn:

```
android/local-maven/
```

Khi build dự án Android, Gradle sẽ tìm kiếm và giải quyết các SDK này thông qua cấu hình repository trong [`android/build.gradle`](file:///Users/devj666/Documents/WorkPlace/VNPT/Flutter-Plugin/github-flutter-plugin/nfc_flutter_plugin/android/build.gradle):

```groovy
repositories {
    maven { url "${projectDir}/local-maven" }
}
```

---

## 🛠️ Quy trình Nâng cấp SDK (Ví dụ: Nâng cấp lên v1.8.7)

### Bước 1: Thêm file `.aar` mới vào thư mục `libs`
Đầu tiên, bạn cần copy file AAR của phiên bản SDK mới vào thư mục:
```
android/libs/
```
*Ví dụ:* Sau khi thêm `vnpt_nfc_sdk-release-v1.8.7.aar`, thư mục sẽ trông như sau:
```
android/libs/
├── scanqr_ic_sdk-release-v1.0.6.aar
├── vnpt_nfc_sdk-release-v1.8.6.aar   # (Phiên bản cũ - có thể giữ lại làm backup)
└── vnpt_nfc_sdk-release-v1.8.7.aar   # (Phiên bản mới)
```

---

### Bước 2: Cập nhật cấu hình Script Publish
Mở file [`publish_aar.sh`](file:///Users/devj666/Documents/WorkPlace/VNPT/Flutter-Plugin/github-flutter-plugin/nfc_flutter_plugin/publish_aar.sh) và chỉnh sửa thông tin khai báo trong mảng `DEPENDENCIES` (dòng 12-15). 

Cập nhật thông tin định dạng: `"groupId|artifactId|version|aarFileName"`

```bash
# Sửa đổi dòng chỉ định vnpt-nfc-sdk sang phiên bản mới:
DEPENDENCIES=(
  "com.vnpt|vnpt-nfc-sdk|1.8.7|vnpt_nfc_sdk-release-v1.8.7.aar"
  "com.vnpt|scanqr-ic-sdk|1.0.6|scanqr_ic_sdk-release-v1.0.6.aar"
)
```

---

### Bước 3: Cập nhật dependency trong `build.gradle`
Mở file [`android/build.gradle`](file:///Users/devj666/Documents/WorkPlace/VNPT/Flutter-Plugin/github-flutter-plugin/nfc_flutter_plugin/android/build.gradle) và tìm đến block `dependencies`. Cập nhật phiên bản của `vnpt-nfc-sdk`:

```groovy
dependencies {
    // Cập nhật từ 1.8.6 lên 1.8.7
    implementation 'com.vnpt:vnpt-nfc-sdk:1.8.7'
    implementation 'com.vnpt:scanqr-ic-sdk:1.0.6'
    // ... các dependencies khác
}
```

---

### Bước 4: Xóa Maven Local cũ và chạy Script Publish
Để tránh xung đột cache hoặc lưu trữ dư thừa phiên bản cũ, hãy xóa thư mục `local-maven` trước khi tạo lại:

1. Mở Terminal tại thư mục gốc của plugin.
2. Thực hiện dọn dẹp và chạy script:

```bash
# Xóa thư mục maven local cũ
rm -rf android/local-maven

# Cấp quyền thực thi cho script (nếu chưa làm)
chmod +x publish_aar.sh

# Chạy script để deploy AAR vào local-maven dưới cấu trúc repository chuẩn
./publish_aar.sh
```

**Mô tả kết quả thành công:**
Script sẽ phân tích cấu hình từ `DEPENDENCIES` và sao chép tệp AAR, đồng thời tự động sinh các file metadata `.pom` và `maven-metadata.xml`.
```
Publishing AARs to local Maven repo: .../android/local-maven
→ Publishing vnpt_nfc_sdk-release-v1.8.7.aar as com.vnpt:vnpt-nfc-sdk:1.8.7
→ Publishing scanqr_ic_sdk-release-v1.0.6.aar as com.vnpt:scanqr-ic-sdk:1.0.6
✅ Finished publishing AARs to .../android/local-maven
```

---

### Bước 5: Clean dự án và Build thử nghiệm
Sau khi publish thành công lên Local Maven, tiến hành xóa caches của Gradle và Flutter để ép tải lại dependency mới:

```bash
# 1. Clean Flutter cache
flutter clean
flutter pub get

# 2. Build thử nghiệm ứng dụng ví dụ (example app)
cd example
flutter build apk --debug
```

---

## 🔍 Xác minh Phiên bản SDK đang sử dụng

Để chắc chắn Gradle của dự án Android đang sử dụng chính xác phiên bản `1.8.7` vừa cấu hình, chạy lệnh sau trong thư mục `example/android`:

```bash
./gradlew :flutter_plugin_ic_nfc:dependencies --configuration releaseRuntimeClasspath | grep vnpt-nfc-sdk
```

**Kết quả hiển thị mong đợi:**
```
+--- com.vnpt:vnpt-nfc-sdk:1.8.7
```

---

## ⚠️ Một số lưu ý quan trọng
1. **Quản lý Git:** Thư mục `android/local-maven/` là thư mục sinh tự động khi build, do đó **không nên** commit thư mục này lên git repo chính (nếu dự án phân phối trực tiếp mã nguồn).
2. **Rollback:** Nếu phiên bản mới gặp lỗi, bạn chỉ cần tải phiên bản cũ (ví dụ `1.8.6`) từ Git hoặc file lưu trữ, đổi lại cấu hình ở **Bước 2** & **Bước 3** và chạy lại **Bước 4**.
