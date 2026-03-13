# Changelog

Tất cả các thay đổi đáng chú ý trong project này sẽ được ghi lại trong file này.

Format dựa trên [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
và project này tuân theo [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Tính năng mới đang được phát triển

### Changed
- Thay đổi đang được phát triển

### Fixed
- Bug fixes đang được phát triển

## [0.0.1] - YYYY-MM-DD

### Added
- Initial release
- Hỗ trợ đọc NFC từ thẻ CCCD/Passport
- QR Code → NFC flow
- MRZ → NFC flow
- Manual NFC input với UI SDK
- Manual NFC input không có UI
- Hỗ trợ Android và iOS
- Hỗ trợ đa ngôn ngữ (Tiếng Việt, Tiếng Anh)

### Dependencies
- Flutter SDK: >=3.3.0
- Dart SDK: ^3.7.2
- Android minSdk: 21
- iOS: 12.0+

## [1.0.1] - 2026-02-12

### Update
 - Using pod 'OpenSSL-Universal', '~> 3.3.3001'
 - Remove SDK OpenSSL preserver path in podspec
 - Update  SDK android version to 1.8.3

## [1.0.2] - 2026-02-25

### Update
  - Revert OpenSSL using fix SDK 3.3.3001

## [1.0.3] - 2026-03-04

### Update
  - Add loadingColor option
  - Add chipDisappear event
  - Update onlyNfcWithoutUi to accept BuildContext
  Sample: 
  ```dart
     Future<void> _nfcWithoutUi() async {
      try {
        if (!_validateInputs()) return;

        final config = NfcPresets.manualWithoutUi(
          idNumber: _idCtrl.text.trim(),
          birthday: _dobCtrl.text.trim(),
          expiredDate: _expCtrl.text.trim(),
          accessToken: _accessToken,
          tokenId: _tokenId,
          tokenKey: _tokenKey,
          accessTokenEKYC: _accessTokenEKYC,
          tokenIdEKYC: _tokenIdEKYC,
          tokenKeyEKYC: _tokenKeyEKYC,
          baseUrl: _baseUrl,
          languageSdk: _language,
          numberTimesRetryScanNFC: _numberTimesRetryScanNFC,
          loadingColor: "#ffffff",
        );

        final result = await ICNfc.instance.onlyNfcWithoutUi(
          context,
          config,
        );
        _navigate(result);
      } on PlatformException catch (e) {
        final error = ICNFCError.fromString(e.message ?? '');
        _showError("${e.code} - ${error.description}");
      }
    }
  ```
  

## [1.0.4] - 2026-03-13

### Update
  - Fix bug android: đọc thẻ cccd mới bị lỗi
