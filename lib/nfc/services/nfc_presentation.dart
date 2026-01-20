import 'enum_nfc.dart';
import 'nfc_config.dart';

/// Predefined configurations for common NFC use cases
class NfcPresets {
  /// QR -> NFC flow
  /// Quét mã QR Code trên CCCD/Hộ chiếu sau đó đọc chip NFC
  static ICNfcConfig qrToNfc({
    // Authentication
    String accessToken = '',
    String tokenId = '',
    String tokenKey = '',
    String accessTokenEKYC = '',
    String tokenIdEKYC = '',
    String tokenKeyEKYC = '',
    String baseUrl = '',

    // UI/Language settings
    ICNfcLanguage languageSdk = ICNfcLanguage.icnfc_vi,
    bool isShowTutorial = false,
    bool isEnableGotIt = false,
    bool isDisableTutorial = false,
    bool isShowLogo = false,
    ModeButtonHeaderBar modeButtonHeaderBar = ModeButtonHeaderBar.leftButton,
    String nameVideoHelpNFC = '',

    // NFC reading options
    bool isEnableUploadImage = false,
    bool isEnablePostcodeMatching = false,
    String inputClientSession = '',
    String challengeCode = '',
    List<int> readingTagsNFC = const [],
    bool isEnableCheckChipClone = false,
    bool isEnableWaterMark = false,
    bool isEnableAddIdCheckData = false,
    bool isEnableUploadDG = false,
    int numberTimesRetryScanNFC = 3,

    // Environment URLs
    String urlUploadImage = '',
    String urlUploadDataNFC = '',
    String urlUploadLogSDK = '',
    String urlPostcodeMatching = '',

    // Transaction info
    String transactionId = '',
    String transactionPartnerId = '',
    String transactionPartnerIDUploadNFC = '',
    String transactionPartnerIDRecentLocation = '',
    String transactionPartnerIDOriginalLocation = '',

    // Security
    String publicKey = '',
    bool isEnableEncrypt = false,
    String nameSSLPinning = '',
    bool isEnableCheckSimulator = false,
    bool isEnableCheckJailbroken = false,
    Map<String, String>? headersRequest,

    // Upload mode
    NfcModeUploadFile modeUploadFile = NfcModeUploadFile.icnfcDefault,
    NfcFlow flowNFC = NfcFlow.icnfcNtb,
  }) => ICNfcConfig(
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
    isDisableTutorial: isDisableTutorial,
    isShowLogo: isShowLogo,
    modeButtonHeaderBar: modeButtonHeaderBar,
    nameVideoHelpNFC: nameVideoHelpNFC,
    isEnableUploadImage: isEnableUploadImage,
    isEnablePostcodeMatching: isEnablePostcodeMatching,
    inputClientSession: inputClientSession,
    challengeCode: challengeCode,
    readingTagsNFC: readingTagsNFC,
    isEnableCheckChipClone: isEnableCheckChipClone,
    isEnableWaterMark: isEnableWaterMark,
    isEnableAddIdCheckData: isEnableAddIdCheckData,
    isEnableUploadDG: isEnableUploadDG,
    numberTimesRetryScanNFC: numberTimesRetryScanNFC,
    urlUploadImage: urlUploadImage,
    urlUploadDataNFC: urlUploadDataNFC,
    urlUploadLogSDK: urlUploadLogSDK,
    urlPostcodeMatching: urlPostcodeMatching,
    transactionId: transactionId,
    transactionPartnerId: transactionPartnerId,
    transactionPartnerIDUploadNFC: transactionPartnerIDUploadNFC,
    transactionPartnerIDRecentLocation: transactionPartnerIDRecentLocation,
    transactionPartnerIDOriginalLocation: transactionPartnerIDOriginalLocation,
    publicKey: publicKey,
    isEnableEncrypt: isEnableEncrypt,
    nameSSLPinning: nameSSLPinning,
    isEnableCheckSimulator: isEnableCheckSimulator,
    isEnableCheckJailbroken: isEnableCheckJailbroken,
    headersRequest: headersRequest,
    modeUploadFile: modeUploadFile,
    flowNFC: flowNFC,
  );

  /// MRZ -> NFC flow (no manual inputs needed)
  /// Quét mã MRZ trên CCCD/Hộ chiếu sau đó đọc chip NFC
  static ICNfcConfig mrzToNfc({
    // Authentication
    String accessToken = '',
    String tokenId = '',
    String tokenKey = '',
    String accessTokenEKYC = '',
    String tokenIdEKYC = '',
    String tokenKeyEKYC = '',
    String baseUrl = '',

    // UI/Language settings
    ICNfcLanguage languageSdk = ICNfcLanguage.icnfc_vi,
    bool isShowTutorial = false,
    bool isEnableGotIt = false,
    bool isDisableTutorial = false,
    bool isShowLogo = false,
    ModeButtonHeaderBar modeButtonHeaderBar = ModeButtonHeaderBar.leftButton,
    String nameVideoHelpNFC = '',

    // NFC reading options
    bool isEnableUploadImage = true,
    bool isEnablePostcodeMatching = false,
    String inputClientSession = '',
    String challengeCode = '',
    List<int> readingTagsNFC = const [],
    bool isEnableCheckChipClone = false,
    bool isEnableWaterMark = false,
    bool isEnableAddIdCheckData = false,
    bool isEnableUploadDG = false,
    int numberTimesRetryScanNFC = 3,

    // Environment URLs
    String urlUploadImage = '',
    String urlUploadDataNFC = '',
    String urlUploadLogSDK = '',
    String urlPostcodeMatching = '',

    // Transaction info
    String transactionId = '',
    String transactionPartnerId = '',
    String transactionPartnerIDUploadNFC = '',
    String transactionPartnerIDRecentLocation = '',
    String transactionPartnerIDOriginalLocation = '',

    // Security
    String publicKey = '',
    bool isEnableEncrypt = false,
    String nameSSLPinning = '',
    bool isEnableCheckSimulator = false,
    bool isEnableCheckJailbroken = false,
    Map<String, String>? headersRequest,

    // Upload mode
    NfcModeUploadFile modeUploadFile = NfcModeUploadFile.icnfcDefault,
    NfcFlow flowNFC = NfcFlow.icnfcNtb,
  }) => ICNfcConfig(
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
    isDisableTutorial: isDisableTutorial,
    isShowLogo: isShowLogo,
    modeButtonHeaderBar: modeButtonHeaderBar,
    nameVideoHelpNFC: nameVideoHelpNFC,
    isEnableUploadImage: isEnableUploadImage,
    isEnablePostcodeMatching: isEnablePostcodeMatching,
    inputClientSession: inputClientSession,
    challengeCode: challengeCode,
    readingTagsNFC: readingTagsNFC,
    isEnableCheckChipClone: isEnableCheckChipClone,
    isEnableWaterMark: isEnableWaterMark,
    isEnableAddIdCheckData: isEnableAddIdCheckData,
    isEnableUploadDG: isEnableUploadDG,
    numberTimesRetryScanNFC: numberTimesRetryScanNFC,
    urlUploadImage: urlUploadImage,
    urlUploadDataNFC: urlUploadDataNFC,
    urlUploadLogSDK: urlUploadLogSDK,
    urlPostcodeMatching: urlPostcodeMatching,
    transactionId: transactionId,
    transactionPartnerId: transactionPartnerId,
    transactionPartnerIDUploadNFC: transactionPartnerIDUploadNFC,
    transactionPartnerIDRecentLocation: transactionPartnerIDRecentLocation,
    transactionPartnerIDOriginalLocation: transactionPartnerIDOriginalLocation,
    publicKey: publicKey,
    isEnableEncrypt: isEnableEncrypt,
    nameSSLPinning: nameSSLPinning,
    isEnableCheckSimulator: isEnableCheckSimulator,
    isEnableCheckJailbroken: isEnableCheckJailbroken,
    headersRequest: headersRequest,
    modeUploadFile: modeUploadFile,
    flowNFC: flowNFC,
  );

  /// Manual NFC with SDK UI
  /// Nhập thủ công số CCCD, ngày sinh, ngày hết hạn và hiển thị UI hướng dẫn
  static ICNfcConfig manualWithUi({
    // Required inputs for NFC reading
    required String idNumber,
    required String birthday,
    required String expiredDate,

    // Authentication
    String accessToken = '',
    String tokenId = '',
    String tokenKey = '',
    String accessTokenEKYC = '',
    String tokenIdEKYC = '',
    String tokenKeyEKYC = '',
    String baseUrl = '',

    // UI/Language settings
    ICNfcLanguage languageSdk = ICNfcLanguage.icnfc_vi,
    bool isShowTutorial = false,
    bool isEnableGotIt = false,
    bool isDisableTutorial = false,
    bool isShowLogo = false,
    ModeButtonHeaderBar modeButtonHeaderBar = ModeButtonHeaderBar.leftButton,
    String nameVideoHelpNFC = '',
    String textReadyNFC = '',
    String textScanningNFC = '',
    String textFinishNFC = '',
    String textDetectedNFC = '',

    // NFC reading options
    bool isEnableUploadImage = true,
    bool isEnablePostcodeMatching = false,
    String inputClientSession = '',
    String challengeCode = '',
    List<int> readingTagsNFC = const [],
    bool isEnableCheckChipClone = false,
    bool isEnableWaterMark = false,
    bool isEnableAddIdCheckData = false,
    bool isEnableUploadDG = false,
    int numberTimesRetryScanNFC = 3,
    bool isAnimatedDismissed = true,

    // Environment URLs
    String urlUploadImage = '',
    String urlUploadDataNFC = '',
    String urlUploadLogSDK = '',
    String urlPostcodeMatching = '',

    // Transaction info
    String transactionId = '',
    String transactionPartnerId = '',
    String transactionPartnerIDUploadNFC = '',
    String transactionPartnerIDRecentLocation = '',
    String transactionPartnerIDOriginalLocation = '',

    // Security
    String publicKey = '',
    bool isEnableEncrypt = false,
    String nameSSLPinning = '',
    bool isEnableCheckSimulator = false,
    bool isEnableCheckJailbroken = false,
    Map<String, String>? headersRequest,

    // Upload mode
    NfcModeUploadFile modeUploadFile = NfcModeUploadFile.icnfcDefault,
    NfcFlow flowNFC = NfcFlow.icnfcNtb,
  }) => ICNfcConfig(
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
    isShowTutorial: isShowTutorial,
    isEnableGotIt: isEnableGotIt,
    isDisableTutorial: isDisableTutorial,
    isShowLogo: isShowLogo,
    modeButtonHeaderBar: modeButtonHeaderBar,
    nameVideoHelpNFC: nameVideoHelpNFC,
    textReadyNFC: textReadyNFC,
    textScanningNFC: textScanningNFC,
    textFinishNFC: textFinishNFC,
    textDetectedNFC: textDetectedNFC,
    isEnableUploadImage: isEnableUploadImage,
    isEnablePostcodeMatching: isEnablePostcodeMatching,
    inputClientSession: inputClientSession,
    challengeCode: challengeCode,
    readingTagsNFC: readingTagsNFC,
    isEnableCheckChipClone: isEnableCheckChipClone,
    isEnableWaterMark: isEnableWaterMark,
    isEnableAddIdCheckData: isEnableAddIdCheckData,
    isEnableUploadDG: isEnableUploadDG,
    numberTimesRetryScanNFC: numberTimesRetryScanNFC,
    isAnimatedDismissed: isAnimatedDismissed,
    urlUploadImage: urlUploadImage,
    urlUploadDataNFC: urlUploadDataNFC,
    urlUploadLogSDK: urlUploadLogSDK,
    urlPostcodeMatching: urlPostcodeMatching,
    transactionId: transactionId,
    transactionPartnerId: transactionPartnerId,
    transactionPartnerIDUploadNFC: transactionPartnerIDUploadNFC,
    transactionPartnerIDRecentLocation: transactionPartnerIDRecentLocation,
    transactionPartnerIDOriginalLocation: transactionPartnerIDOriginalLocation,
    publicKey: publicKey,
    isEnableEncrypt: isEnableEncrypt,
    nameSSLPinning: nameSSLPinning,
    isEnableCheckSimulator: isEnableCheckSimulator,
    isEnableCheckJailbroken: isEnableCheckJailbroken,
    headersRequest: headersRequest,
    modeUploadFile: modeUploadFile,
    flowNFC: flowNFC,
  );

  /// Manual NFC without SDK UI (NFCOutside mode)
  /// Nhập thủ công và đọc NFC ngay trong ứng dụng (không có UI hướng dẫn)
  /// Không bao gồm các tham số về customUI vì không cần thiết
  static ICNfcConfig manualWithoutUi({
    // Required inputs for NFC reading
    required String idNumber,
    required String birthday,
    required String expiredDate,

    // Authentication
    String accessToken = '',
    String tokenId = '',
    String tokenKey = '',
    String accessTokenEKYC = '',
    String tokenIdEKYC = '',
    String tokenKeyEKYC = '',
    String baseUrl = '',

    // NFC reading options (không bao gồm các tùy chọn UI)
    bool isEnableUploadImage = false,
    bool isEnablePostcodeMatching = false,
    String inputClientSession = '',
    String challengeCode = '',
    List<int> readingTagsNFC = const [],
    bool isEnableCheckChipClone = false,
    bool isEnableAddIdCheckData = false,
    bool isEnableUploadDG = false,
    int numberTimesRetryScanNFC = 3,

    // Environment URLs
    String urlUploadImage = '',
    String urlUploadDataNFC = '',
    String urlUploadLogSDK = '',
    String urlPostcodeMatching = '',

    // Transaction info
    String transactionId = '',
    String transactionPartnerId = '',
    String transactionPartnerIDUploadNFC = '',
    String transactionPartnerIDRecentLocation = '',
    String transactionPartnerIDOriginalLocation = '',

    // Security
    String publicKey = '',
    bool isEnableEncrypt = false,
    String nameSSLPinning = '',
    bool isEnableCheckSimulator = false,
    bool isEnableCheckJailbroken = false,
    Map<String, String>? headersRequest,

    // Upload mode
    NfcModeUploadFile modeUploadFile = NfcModeUploadFile.icnfcDefault,
    NfcFlow flowNFC = NfcFlow.icnfcNtb,
  }) => ICNfcConfig(
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
    isEnableUploadImage: isEnableUploadImage,
    isEnablePostcodeMatching: isEnablePostcodeMatching,
    inputClientSession: inputClientSession,
    challengeCode: challengeCode,
    readingTagsNFC: readingTagsNFC,
    isEnableCheckChipClone: isEnableCheckChipClone,
    isEnableAddIdCheckData: isEnableAddIdCheckData,
    isEnableUploadDG: isEnableUploadDG,
    numberTimesRetryScanNFC: numberTimesRetryScanNFC,
    urlUploadImage: urlUploadImage,
    urlUploadDataNFC: urlUploadDataNFC,
    urlUploadLogSDK: urlUploadLogSDK,
    urlPostcodeMatching: urlPostcodeMatching,
    transactionId: transactionId,
    transactionPartnerId: transactionPartnerId,
    transactionPartnerIDUploadNFC: transactionPartnerIDUploadNFC,
    transactionPartnerIDRecentLocation: transactionPartnerIDRecentLocation,
    transactionPartnerIDOriginalLocation: transactionPartnerIDOriginalLocation,
    publicKey: publicKey,
    isEnableEncrypt: isEnableEncrypt,
    nameSSLPinning: nameSSLPinning,
    isEnableCheckSimulator: isEnableCheckSimulator,
    isEnableCheckJailbroken: isEnableCheckJailbroken,
    headersRequest: headersRequest,
    modeUploadFile: modeUploadFile,
    flowNFC: flowNFC,
  );
}
