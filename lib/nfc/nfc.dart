import 'services/enum_nfc.dart';
import 'services/nfc_config.dart';
import 'services/nfc_method_channel.dart';
import 'services/nfc_presentation.dart';

class ICNfc {
  const ICNfc();

  static const ICNfc _instance = ICNfc();
  static ICNfc get instance => _instance;

  static const NfcMethodChannel _methodChannel = NfcMethodChannel();


  Future<Map<String, dynamic>> qrToNfc(ICNfcConfig config) {
    return _methodChannel.startQrToNfc(config);
  }


  Future<Map<String, dynamic>> mrzToNfc(ICNfcConfig config) {
    return _methodChannel.startMrzToNfc(config);
  }


  Future<Map<String, dynamic>> onlyNfcWithUi(ICNfcConfig config) {
    return _methodChannel.startOnlyNfc(config);
  }


  Future<Map<String, dynamic>> onlyNfcWithoutUi(ICNfcConfig config) {
    return _methodChannel.startOnlyNfcWithoutUi(config);
  }

  /// QR → NFC 
  Future<Map<String, dynamic>> qrToNfcSimple({
    String accessToken = '',
    String tokenId = '',
    String tokenKey = '',
    String accessTokenEKYC = '',
    String tokenIdEKYC = '',
    String tokenKeyEKYC = '',
    String baseUrl = '',
    ICNfcLanguage languageSdk = ICNfcLanguage.icnfc_vi,
    bool isShowTutorial = false,
    bool isEnableGotIt = false,
    bool isEnableUploadImage = true,
    bool isEnablePostcodeMatching = false,
    String inputClientSession = '',
    List<String> readingTagsNFC = const [],
    String nameVideoHelpNFC = '',
  }) {
    final config = NfcPresets.qrToNfc(
      accessToken: accessToken,
      tokenId: tokenId,
      tokenKey: tokenKey,
      accessTokenEKYC: accessTokenEKYC,
      tokenIdEKYC: tokenIdEKYC,
      tokenKeyEKYC: tokenKeyEKYC,
      baseUrl: baseUrl,
      languageSdk: languageSdk,
      isShowTutorial: isShowTutorial,
      isEnableGotIt: isEnableGotIt,
      isEnableUploadImage: isEnableUploadImage,
      isEnablePostcodeMatching: isEnablePostcodeMatching,
      inputClientSession: inputClientSession,
      readingTagsNFC: readingTagsNFC,
      nameVideoHelpNFC: nameVideoHelpNFC,
    );
    return qrToNfc(config);
  }

  /// MRZ → NFC 
  ///
  /// Nội bộ dùng [NfcPresets.mrzToNfc] để tạo [NfcConfig].
  Future<Map<String, dynamic>> mrzToNfcSimple({
    String accessToken = '',
    String tokenId = '',
    String tokenKey = '',
    String accessTokenEKYC = '',
    String tokenIdEKYC = '',
    String tokenKeyEKYC = '',
    String baseUrl = '',
    ICNfcLanguage languageSdk = ICNfcLanguage.icnfc_vi,
    bool isShowTutorial = false,
    bool isEnableGotIt = false,
    bool isEnableUploadImage = true,
    bool isEnablePostcodeMatching = false,
    String inputClientSession = '',
    List<String> readingTagsNFC = const [],
    String nameVideoHelpNFC = '',
  }) {
    final config = NfcPresets.mrzToNfc(
      accessToken: accessToken,
      tokenId: tokenId,
      tokenKey: tokenKey,
      accessTokenEKYC: accessTokenEKYC,
      tokenIdEKYC: tokenIdEKYC,
      tokenKeyEKYC: tokenKeyEKYC,
      baseUrl: baseUrl,
      languageSdk: languageSdk,
      isShowTutorial: isShowTutorial,
      isEnableGotIt: isEnableGotIt,
      isEnableUploadImage: isEnableUploadImage,
      isEnablePostcodeMatching: isEnablePostcodeMatching,
      inputClientSession: inputClientSession,
      readingTagsNFC: readingTagsNFC,
      nameVideoHelpNFC: nameVideoHelpNFC,
    );
    return mrzToNfc(config);
  }

  /// Manual NFC with SDK UI với named parameters đơn giản.
  ///
  /// Nội bộ dùng [NfcPresets.manualWithUi] để tạo [NfcConfig].
  Future<Map<String, dynamic>> onlyNfcWithUiSimple({
    required String idNumber,
    required String birthday,
    required String expiredDate,
    String accessToken = '',
    String tokenId = '',
    String tokenKey = '',
    String accessTokenEKYC = '',
    String tokenIdEKYC = '',
    String tokenKeyEKYC = '',
    String baseUrl = '',
    ICNfcLanguage languageSdk = ICNfcLanguage.icnfc_vi,
    bool isShowTutorial = true,
    bool isEnableGotIt = true,
    bool isEnableUploadImage = true,
    bool isEnablePostcodeMatching = false,
    String inputClientSession = '',
    List<String> readingTagsNFC = const [],
    String nameVideoHelpNFC = '',
  }) {
    final config = NfcPresets.manualWithUi(
      accessToken: accessToken,
      tokenId: tokenId,
      tokenKey: tokenKey,
      accessTokenEKYC: accessTokenEKYC,
      tokenIdEKYC: tokenIdEKYC,
      tokenKeyEKYC: tokenKeyEKYC,
      baseUrl: baseUrl,
      idNumber: idNumber,
      birthday: birthday,
      expiredDate: expiredDate,
      languageSdk: languageSdk,
      isShowTutorial: isShowTutorial,
      isEnableGotIt: isEnableGotIt,
      isEnableUploadImage: isEnableUploadImage,
      isEnablePostcodeMatching: isEnablePostcodeMatching,
      inputClientSession: inputClientSession,
      readingTagsNFC: readingTagsNFC,
      nameVideoHelpNFC: nameVideoHelpNFC,
    );
    return onlyNfcWithUi(config);
  }

  /// Thực hiện quét NFC không có UI
  ///
  /// Nội bộ dùng [NfcPresets.manualWithoutUi] để tạo [NfcConfig].
  Future<Map<String, dynamic>> onlyNfcWithoutUiSimple({
    required String idNumber,
    required String birthday,
    required String expiredDate,
    String accessToken = '',
    String tokenId = '',
    String tokenKey = '',
    String accessTokenEKYC = '',
    String tokenIdEKYC = '',
    String tokenKeyEKYC = '',
    String baseUrl = '',
    ICNfcLanguage languageSdk = ICNfcLanguage.icnfc_vi,
    bool isEnableUploadImage = true,
    bool isEnablePostcodeMatching = false,
    String inputClientSession = '',
    List<String> readingTagsNFC = const [],
    String nameVideoHelpNFC = '',
  }) {
    final config = NfcPresets.manualWithoutUi(
      idNumber: idNumber,
      birthday: birthday,
      expiredDate: expiredDate,
      accessToken: accessToken,
      tokenId: tokenId,
      tokenKey: tokenKey,
      accessTokenEKYC: accessTokenEKYC,
      tokenIdEKYC: tokenIdEKYC,
      tokenKeyEKYC: tokenKeyEKYC,
      baseUrl: baseUrl,
      languageSdk: languageSdk,
      isEnableUploadImage: isEnableUploadImage,
      isEnablePostcodeMatching: isEnablePostcodeMatching,
      inputClientSession: inputClientSession,
      readingTagsNFC: readingTagsNFC,
      nameVideoHelpNFC: nameVideoHelpNFC,
    );
    return onlyNfcWithoutUi(config);
  }
}
