# Flutter Plugin NFC
GitHub: https://github.com/MobileTeamIC/ic_nfc_flutter_plugin.git 

Plugin Flutter để tích hợp NFC SDK cho việc đọc thông tin từ thẻ căn cước công dân (CCCD) và hộ chiếu (Passport) trên Android và iOS.


## 📦 Cài đặt

### Sử dụng Git Repository

1. **Thêm dependency vào `pubspec.yaml`:**

```yaml
dependencies:
  flutter_plugin_ic_nfc:
    git:
      url: https://github.com/MobileTeamIC/ic_nfc_flutter_plugin.git
      ref: v1.0.0
```


3. **Chạy lệnh:**

```bash
flutter pub get
```


## ⚙️ Cấu hình

### Android
Thêm cấu hình vào app `android/build.gradle.kts`
```kts
allprojects {
    repositories {
        google()
        mavenCentral()
        mavenLocal()
        maven { url = uri("${rootDir}/../../android/libs-maven-local") }
    }
}
```
Trỏ tới đường dẫn `android/libs-maven-local` của plugin `flutter_plugin_ic_nfc`

### iOS
Thêm dòng sau vào `Info.plist`
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

### 2. MRZ → NFC

### 3. NFC với UI


### 4. NFC không có UI

### Sử dụng với NfcConfig (Advanced)

