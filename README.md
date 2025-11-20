# Flutter Plugin NFC

Plugin Flutter để tích hợp NFC SDK cho việc đọc thông tin từ thẻ căn cước công dân (CCCD) và hộ chiếu (Passport) trên Android và iOS.

## 📋 Mục lục

- [Tính năng](#tính-năng)
- [Yêu cầu hệ thống](#yêu-cầu-hệ-thống)
- [Cài đặt](#cài-đặt)
- [Cấu hình](#cấu-hình)
- [Sử dụng](#sử-dụng)
- [API Reference](#api-reference)
- [Troubleshooting](#troubleshooting)
- [Changelog](#changelog)
- [Release & Versioning](#release--versioning)
- [License](#license)

## ✨ Tính năng

- ✅ Đọc thông tin từ thẻ CCCD/Passport qua NFC
- ✅ Hỗ trợ quét QR code để lấy thông tin
- ✅ Hỗ trợ nhập MRZ (Machine Readable Zone)
- ✅ Hỗ trợ nhập thủ công thông tin thẻ
- ✅ Tích hợp UI SDK sẵn có
- ✅ Hỗ trợ đa ngôn ngữ (Tiếng Việt, Tiếng Anh)
- ✅ Hỗ trợ Android và iOS

## 🔧 Yêu cầu hệ thống

### Flutter
- Flutter SDK: `>=3.3.0`
- Dart SDK: `^3.7.2`

## 📦 Cài đặt

### Sử dụng Git Repository

1. **Thêm dependency vào `pubspec.yaml`:**

```yaml
dependencies:
  flutter_plugin_ic_nfc:
    git:
      url: https://your-private-git-repo.com/flutter_plugin_ic_nfc.git
      ref: v0.0.1 
```


3. **Chạy lệnh:**

```bash
flutter pub get
```


## ⚙️ Cấu hình

### Android


```xml
<key>NFCReaderUsageDescription</key>
<string>Ứng dụng cần quyền NFC để đọc thông tin từ thẻ căn cước công dân</string>
<key>NSCameraUsageDescription</key>
<string>Ứng dụng sử dụng máy ảnh để quét thông tin Căn cước gắn chip hoặc Hộ chiếu</string>
<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
  <array>
        <string>A0000002471001</string>
        <string>A0000002472001</string>
        <string>00000000000000</string>
  </array>
```

3. **Cài đặt CocoaPods dependencies:**

```bash
cd ios
pod install
cd ..
```

## 🚀 Sử dụng

### Import package

```dart
import 'package:flutter_plugin_ic_nfc/nfc/nfc.dart';
```

### 1. QR Code → NFC

Sử dụng khi bạn đã có QR code từ thẻ CCCD/Passport:

```dart
final result = await ICNfc.instance.qrToNfcSimple(
  accessToken: 'your_access_token',
  tokenId: 'your_token_id',
  tokenKey: 'your_token_key',
  accessTokenEKYC: 'your_ekyc_access_token',
  tokenIdEKYC: 'your_ekyc_token_id',
  tokenKeyEKYC: 'your_ekyc_token_key',
  baseUrl: 'https://your-api-url.com',
  languageSdk: NfcLanguage.icekycVi,
  isShowTutorial: true,
  isEnableGotIt: true,
  isEnableUploadImage: true,
  isEnablePostcodeMatching: false,
  inputClientSession: '',
  readingTagsNFC: [],
  nameVideoHelpNFC: '',
);

// Xử lý kết quả
if (result['success'] == true) {
  print('Thành công: ${result['data']}');
} else {
  print('Lỗi: ${result['error']}');
}
```

### 2. MRZ → NFC

Sử dụng khi bạn đã có thông tin MRZ từ passport:

```dart
final result = await ICNfc.instance.mrzToNfcSimple(
  accessToken: 'your_access_token',
  tokenId: 'your_token_id',
  tokenKey: 'your_token_key',
  accessTokenEKYC: 'your_ekyc_access_token',
  tokenIdEKYC: 'your_ekyc_token_id',
  tokenKeyEKYC: 'your_ekyc_token_key',
  baseUrl: 'https://your-api-url.com',
  languageSdk: NfcLanguage.icekycVi,
  // ... các tham số khác
);
```

### 3. NFC với UI (Nhập thủ công)

Sử dụng khi người dùng nhập thông tin thẻ thủ công:

```dart
final result = await ICNfc.instance.onlyNfcWithUiSimple(
  idNumber: '001234567890',
  birthday: '01/01/1990',
  expiredDate: '01/01/2030',
  accessToken: 'your_access_token',
  tokenId: 'your_token_id',
  tokenKey: 'your_token_key',
  accessTokenEKYC: 'your_ekyc_access_token',
  tokenIdEKYC: 'your_ekyc_token_id',
  tokenKeyEKYC: 'your_ekyc_token_key',
  baseUrl: 'https://your-api-url.com',
  languageSdk: NfcLanguage.icekycVi,
  // ... các tham số khác
);
```

### 4. NFC không có UI

Sử dụng khi bạn muốn tự xử lý UI:

```dart
final result = await ICNfc.instance.onlyNfcWithoutUiSimple(
  idNumber: '001234567890',
  birthday: '01/01/1990',
  expiredDate: '01/01/2030',
  accessToken: 'your_access_token',
  tokenId: 'your_token_id',
  tokenKey: 'your_token_key',
  accessTokenEKYC: 'your_ekyc_access_token',
  tokenIdEKYC: 'your_ekyc_token_id',
  tokenKeyEKYC: 'your_ekyc_token_key',
  baseUrl: 'https://your-api-url.com',
  languageSdk: NfcLanguage.icekycVi,
  // ... các tham số khác
);
```

### Sử dụng với NfcConfig (Advanced)

Nếu bạn cần cấu hình chi tiết hơn:

```dart
import 'package:flutter_plugin_ic_nfc/nfc/services/nfc_config.dart';
import 'package:flutter_plugin_ic_nfc/nfc/services/nfc_presentation.dart';

final config = NfcPresets.qrToNfc(
  accessToken: 'your_access_token',
  // ... các tham số khác
);

final result = await ICNfc.instance.qrToNfc(config);
```

## 📚 API Reference

### ICNfc

Singleton class chính để sử dụng plugin.

#### Methods

- `qrToNfcSimple(...)` - QR Code → NFC với named parameters
- `mrzToNfcSimple(...)` - MRZ → NFC với named parameters
- `onlyNfcWithUiSimple(...)` - NFC với UI SDK, nhập thủ công
- `onlyNfcWithoutUiSimple(...)` - NFC không có UI, nhập thủ công
- `qrToNfc(NfcConfig config)` - QR Code → NFC với config tùy chỉnh
- `mrzToNfc(NfcConfig config)` - MRZ → NFC với config tùy chỉnh
- `onlyNfcWithUi(NfcConfig config)` - NFC với UI, config tùy chỉnh
- `onlyNfcWithoutUi(NfcConfig config)` - NFC không UI, config tùy chỉnh

### NfcLanguage

Enum hỗ trợ ngôn ngữ:
- `NfcLanguage.icekycVi` - Tiếng Việt
- `NfcLanguage.icekycEn` - Tiếng Anh


## 🔍 Troubleshooting

### Android

**Lỗi: NFC không hoạt động**
- Kiểm tra thiết bị có hỗ trợ NFC không
- Kiểm tra NFC đã được bật trong Settings
- Kiểm tra quyền NFC trong AndroidManifest.xml

**Lỗi: Build failed với AAR files**
- Đảm bảo file `.aar` trong `android/libs/` đã được thêm đúng
- Kiểm tra `build.gradle` có reference đến các file AAR

**Lỗi: ClassNotFoundException**
- Clean và rebuild project:
  ```bash
  flutter clean
  flutter pub get
  cd android && ./gradlew clean && cd ..
  flutter build apk
  ```

### iOS

**Lỗi: NFC không hoạt động**
- Kiểm tra thiết bị là iPhone 7 trở lên
- Kiểm tra NFC Capability đã được thêm trong Xcode
- Kiểm tra Info.plist có NFCReaderUsageDescription

**Lỗi: Pod install failed**
- Xóa Pods và cài lại:
  ```bash
  cd ios
  rm -rf Pods Podfile.lock
  pod install
  cd ..
  ```

**Lỗi: Framework not found**
- Đảm bảo các XCFramework trong `ios/SDK/` đã được thêm đúng
- Kiểm tra `flutter_plugin_ic_nfc.podspec` có reference đến frameworks

### Chung

**Lỗi: Method channel error**
- Đảm bảo plugin đã được import đúng
- Kiểm tra version Flutter và Dart SDK
- Chạy `flutter doctor` để kiểm tra môi trường
