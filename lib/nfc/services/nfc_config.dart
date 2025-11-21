import 'package:flutter/foundation.dart';

import 'enum_nfc.dart';

/// Configuration class for NFC SDK parameters
class ICNfcConfig {
  final String? accessToken;
  final String? tokenId;
  final String? tokenKey;

  final String? accessTokenEKYC;
  final String? tokenIdEKYC;
  final String? tokenKeyEKYC;

  final String? baseUrl;

  // Optional SDK presentation options (currently hardcoded in iOS, reserved for future)
  final ICNfcLanguage? languageSdk;
  final bool? isShowTutorial;
  final bool? isEnableGotIt;
  final bool? isDisableTutorial;

  // NFC reader (manual input) requirements
  final String? idNumber; // 12 digits
  final String? birthday; // yymmdd
  final String? expiredDate; // yymmdd
  final ReaderCardMode? readerCardMode;
  final bool? isEnableUploadImage;
  final bool? isEnablePostcodeMatching;
  final String? inputClientSession;
  final String? challengeCode;
  final List<String>? readingTagsNFC;
  final bool? isEnableCheckChipClone;
  final bool? isEnableWaterMark;
  final bool? isEnableAddIdCheckData;
  final bool? isEnableUploadDG;
  final String? textReadyNFC;
  final String? textScanningNFC;
  final String? textFinishNFC;
  final String? textDetectedNFC;
  final String? nameVideoHelpNFC;
  final String? publicKey;
  final bool? isEnableEncrypt;
  final NfcModeUploadFile? modeUploadFile;
  final NfcFlow? flowNFC;
  final int? numberTimesRetryScanNFC;
  final bool? isEnableCheckSimulator;
  final bool? isEnableCheckJailbroken;
  final bool? isAnimatedDismissed;

  // Environment URLs
  final String? urlUploadImage;
  final String? urlUploadDataNFC;
  final String? urlUploadLogSDK;
  final String? urlPostcodeMatching;

  // Request headers and transaction info
  final Map<String, String>? headersRequest;
  final String? transactionId;
  final String? transactionPartnerId;
  final String? transactionPartnerIDUploadNFC;
  final String? transactionPartnerIDRecentLocation;
  final String? transactionPartnerIDOriginalLocation;
  final String? nameSSLPinning;

  const ICNfcConfig({
    this.accessToken,
    this.tokenId,
    this.tokenKey,
    this.accessTokenEKYC,
    this.tokenIdEKYC,
    this.tokenKeyEKYC,
    this.baseUrl,
    this.languageSdk,
    this.isShowTutorial,
    this.isEnableGotIt,
    this.isDisableTutorial,
    this.idNumber,
    this.birthday,
    this.expiredDate,
    this.readerCardMode,
    this.isEnableUploadImage,
    this.isEnablePostcodeMatching,
    this.inputClientSession,
    this.challengeCode,
    this.readingTagsNFC,
    this.isEnableCheckChipClone,
    this.isEnableWaterMark,
    this.isEnableAddIdCheckData,
    this.isEnableUploadDG,
    this.textReadyNFC,
    this.textScanningNFC,
    this.textFinishNFC,
    this.textDetectedNFC,
    this.nameVideoHelpNFC,
    this.publicKey,
    this.isEnableEncrypt,
    this.modeUploadFile,
    this.flowNFC,
    this.numberTimesRetryScanNFC,
    this.isEnableCheckSimulator,
    this.isEnableCheckJailbroken,
    this.isAnimatedDismissed,
    this.urlUploadImage,
    this.urlUploadDataNFC,
    this.urlUploadLogSDK,
    this.urlPostcodeMatching,
    this.headersRequest,
    this.transactionId,
    this.transactionPartnerId,
    this.transactionPartnerIDUploadNFC,
    this.transactionPartnerIDRecentLocation,
    this.transactionPartnerIDOriginalLocation,
    this.nameSSLPinning,
  });

  /// Convert to Map for method channel. Only non-null fields included.
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    if (accessToken != null) {
      map['accessToken'] = accessToken;
    }
    if (tokenId != null) {
      map['tokenId'] = tokenId;
    }
    if (tokenKey != null) {
      map['tokenKey'] = tokenKey;
    }

    if (accessTokenEKYC != null) {
      map['accessTokenEKYC'] = accessTokenEKYC;
    }
    if (tokenIdEKYC != null) {
      map['tokenIdEKYC'] = tokenIdEKYC;
    }
    if (tokenKeyEKYC != null) {
      map['tokenKeyEKYC'] = tokenKeyEKYC;
    }

    if (baseUrl != null) {
      map['baseUrl'] = baseUrl;
    }

    if (idNumber != null) {
      map['idNumber'] = idNumber;
    }
    if (birthday != null) {
      map['birthday'] = birthday;
    }
    if (expiredDate != null) {
      map['expiredDate'] = expiredDate;
    }

    // Reserved for future enhancements on iOS side
    if (languageSdk != null) {
      map['languageSdk'] = languageSdk!.channelValue;
    }
    if (isShowTutorial != null) {
      map['isShowTutorial'] = isShowTutorial;
    }
    if (isEnableGotIt != null) {
      map['isEnableGotIt'] = isEnableGotIt;
    }
    if (isDisableTutorial != null) {
      map['isDisableTutorial'] = isDisableTutorial;
    }

    if (readerCardMode != null) {
      map['readerCardMode'] = readerCardMode!.channelValue;
    }
    if (isEnableUploadImage != null) {
      map['isEnableUploadImage'] = isEnableUploadImage;
    }
    if (isEnablePostcodeMatching != null) {
      map['isEnablePostcodeMatching'] = isEnablePostcodeMatching;
    }
    if (inputClientSession != null) {
      map['inputClientSession'] = inputClientSession;
    }
    if (challengeCode != null) {
      map['challengeCode'] = challengeCode;
    }
    if (readingTagsNFC != null) {
      map['readingTagsNFC'] = readingTagsNFC;
    }
    if (isEnableCheckChipClone != null) {
      map['isEnableCheckChipClone'] = isEnableCheckChipClone;
    }
    if (isEnableWaterMark != null) {
      map['isEnableWaterMark'] = isEnableWaterMark;
    }
    if (isEnableAddIdCheckData != null) {
      map['isEnableAddIdCheckData'] = isEnableAddIdCheckData;
    }
    if (isEnableUploadDG != null) {
      map['isEnableUploadDG'] = isEnableUploadDG;
    }
    if (textReadyNFC != null) {
      map['textReadyNFC'] = textReadyNFC;
    }
    if (textScanningNFC != null) {
      map['textScanningNFC'] = textScanningNFC;
    }
    if (textFinishNFC != null) {
      map['textFinishNFC'] = textFinishNFC;
    }
    if (textDetectedNFC != null) {
      map['textDetectedNFC'] = textDetectedNFC;
    }
    if (nameVideoHelpNFC != null) {
      map['nameVideoHelpNFC'] = nameVideoHelpNFC;
    }
    if (publicKey != null) {
      map['publicKey'] = publicKey;
    }
    if (isEnableEncrypt != null) {
      map['isEnableEncrypt'] = isEnableEncrypt;
    }
    if (modeUploadFile != null) {
      map['modeUploadFile'] = modeUploadFile!.channelValue;
    }
    if (flowNFC != null) {
      map['flowNFC'] = flowNFC!.channelValue;
    }
    if (numberTimesRetryScanNFC != null) {
      map['numberTimesRetryScanNFC'] = numberTimesRetryScanNFC;
    }
    if (isEnableCheckSimulator != null) {
      map['isEnableCheckSimulator'] = isEnableCheckSimulator;
    }
    if (isEnableCheckJailbroken != null) {
      map['isEnableCheckJailbroken'] = isEnableCheckJailbroken;
    }
    if (isAnimatedDismissed != null) {
      map['isAnimatedDismissed'] = isAnimatedDismissed;
    }
    if (urlUploadImage != null) {
      map['urlUploadImage'] = urlUploadImage;
    }
    if (urlUploadDataNFC != null) {
      map['urlUploadDataNFC'] = urlUploadDataNFC;
    }
    if (urlUploadLogSDK != null) {
      map['urlUploadLogSDK'] = urlUploadLogSDK;
    }
    if (urlPostcodeMatching != null) {
      map['urlPostcodeMatching'] = urlPostcodeMatching;
    }
    if (headersRequest != null) {
      map['headersRequest'] = headersRequest;
    }
    if (transactionId != null) {
      map['transactionId'] = transactionId;
    }
    if (transactionPartnerId != null) {
      map['transactionPartnerId'] = transactionPartnerId;
    }
    if (transactionPartnerIDUploadNFC != null) {
      map['transactionPartnerIDUploadNFC'] = transactionPartnerIDUploadNFC;
    }
    if (transactionPartnerIDRecentLocation != null) {
      map['transactionPartnerIDRecentLocation'] = transactionPartnerIDRecentLocation;
    }
    if (transactionPartnerIDOriginalLocation != null) {
      map['transactionPartnerIDOriginalLocation'] = transactionPartnerIDOriginalLocation;
    }
    if (nameSSLPinning != null) {
      map['nameSSLPinning'] = nameSSLPinning;
    }
    return map;
  }

  /// Quick validator used by UI before invoking native methods
  bool get hasValidManualInput {
    if (idNumber == null || birthday == null || expiredDate == null) {
      return false;
    }
    return idNumber!.trim().length == 12 &&
        birthday!.trim().length == 6 &&
        expiredDate!.trim().length == 6;
  }

  ICNfcConfig copyWith({
    String? accessToken,
    String? tokenId,
    String? tokenKey,
    String? accessTokenEKYC,
    String? tokenIdEKYC,
    String? tokenKeyEKYC,
    String? baseUrl,
    ICNfcLanguage? languageSdk,
    bool? isShowTutorial,
    bool? isEnableGotIt,
    bool? isDisableTutorial,
    String? idNumber,
    String? birthday,
    String? expiredDate,
    ReaderCardMode? readerCardMode,
    bool? isEnableUploadImage,
    bool? isEnablePostcodeMatching,
    String? inputClientSession,
    String? challengeCode,
    List<String>? readingTagsNFC,
    bool? isEnableCheckChipClone,
    bool? isEnableWaterMark,
    bool? isEnableAddIdCheckData,
    bool? isEnableUploadDG,
    String? textReadyNFC,
    String? textScanningNFC,
    String? textFinishNFC,
    String? textDetectedNFC,
    String? nameVideoHelpNFC,
    String? publicKey,
    bool? isEnableEncrypt,
    NfcModeUploadFile? modeUploadFile,
    NfcFlow? flowNFC,
    int? numberTimesRetryScanNFC,
    bool? isEnableCheckSimulator,
    bool? isEnableCheckJailbroken,
    bool? isAnimatedDismissed,
    String? urlUploadImage,
    String? urlUploadDataNFC,
    String? urlUploadLogSDK,
    String? urlPostcodeMatching,
    Map<String, String>? headersRequest,
    String? transactionId,
    String? transactionPartnerId,
    String? transactionPartnerIDUploadNFC,
    String? transactionPartnerIDRecentLocation,
    String? transactionPartnerIDOriginalLocation,
    String? nameSSLPinning,
  }) {
    return ICNfcConfig(
      accessToken: accessToken ?? this.accessToken,
      tokenId: tokenId ?? this.tokenId,
      tokenKey: tokenKey ?? this.tokenKey,
      accessTokenEKYC: accessTokenEKYC ?? this.accessTokenEKYC,
      tokenIdEKYC: tokenIdEKYC ?? this.tokenIdEKYC,
      tokenKeyEKYC: tokenKeyEKYC ?? this.tokenKeyEKYC,
      baseUrl: baseUrl ?? this.baseUrl,
      languageSdk: languageSdk ?? this.languageSdk,
      isShowTutorial: isShowTutorial ?? this.isShowTutorial,
      isEnableGotIt: isEnableGotIt ?? this.isEnableGotIt,
      isDisableTutorial: isDisableTutorial ?? this.isDisableTutorial,
      idNumber: idNumber ?? this.idNumber,
      birthday: birthday ?? this.birthday,
      expiredDate: expiredDate ?? this.expiredDate,
      readerCardMode: readerCardMode ?? this.readerCardMode,
      isEnableUploadImage: isEnableUploadImage ?? this.isEnableUploadImage,
      isEnablePostcodeMatching: isEnablePostcodeMatching ?? this.isEnablePostcodeMatching,
      inputClientSession: inputClientSession ?? this.inputClientSession,
      challengeCode: challengeCode ?? this.challengeCode,
      readingTagsNFC: readingTagsNFC ?? this.readingTagsNFC,
      isEnableCheckChipClone: isEnableCheckChipClone ?? this.isEnableCheckChipClone,
      isEnableWaterMark: isEnableWaterMark ?? this.isEnableWaterMark,
      isEnableAddIdCheckData: isEnableAddIdCheckData ?? this.isEnableAddIdCheckData,
      isEnableUploadDG: isEnableUploadDG ?? this.isEnableUploadDG,
      textReadyNFC: textReadyNFC ?? this.textReadyNFC,
      textScanningNFC: textScanningNFC ?? this.textScanningNFC,
      textFinishNFC: textFinishNFC ?? this.textFinishNFC,
      textDetectedNFC: textDetectedNFC ?? this.textDetectedNFC,
      nameVideoHelpNFC: nameVideoHelpNFC ?? this.nameVideoHelpNFC,
      publicKey: publicKey ?? this.publicKey,
      isEnableEncrypt: isEnableEncrypt ?? this.isEnableEncrypt,
      modeUploadFile: modeUploadFile ?? this.modeUploadFile,
      flowNFC: flowNFC ?? this.flowNFC,
      numberTimesRetryScanNFC: numberTimesRetryScanNFC ?? this.numberTimesRetryScanNFC,
      isEnableCheckSimulator: isEnableCheckSimulator ?? this.isEnableCheckSimulator,
      isEnableCheckJailbroken: isEnableCheckJailbroken ?? this.isEnableCheckJailbroken,
      isAnimatedDismissed: isAnimatedDismissed ?? this.isAnimatedDismissed,
      urlUploadImage: urlUploadImage ?? this.urlUploadImage,
      urlUploadDataNFC: urlUploadDataNFC ?? this.urlUploadDataNFC,
      urlUploadLogSDK: urlUploadLogSDK ?? this.urlUploadLogSDK,
      urlPostcodeMatching: urlPostcodeMatching ?? this.urlPostcodeMatching,
      headersRequest: headersRequest ?? this.headersRequest,
      transactionId: transactionId ?? this.transactionId,
      transactionPartnerId: transactionPartnerId ?? this.transactionPartnerId,
      transactionPartnerIDUploadNFC: transactionPartnerIDUploadNFC ?? this.transactionPartnerIDUploadNFC,
      transactionPartnerIDRecentLocation: transactionPartnerIDRecentLocation ?? this.transactionPartnerIDRecentLocation,
      transactionPartnerIDOriginalLocation: transactionPartnerIDOriginalLocation ?? this.transactionPartnerIDOriginalLocation,
      nameSSLPinning: nameSSLPinning ?? this.nameSSLPinning,
    );
  }

  @override
  String toString() => describeIdentity(this);
}
