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
  final bool? isShowLogo;

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
  final ModeButtonHeaderBar? modeButtonHeaderBar;

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
    this.isShowLogo,
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
    this.modeButtonHeaderBar,
  });

  /// Convert to Map for method channel. Only non-null fields included.
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    if (accessToken != null) {
      map['access_token'] = accessToken;
    }
    if (tokenId != null) {
      map['token_id'] = tokenId;
    }
    if (tokenKey != null) {
      map['token_key'] = tokenKey;
    }

    if (accessTokenEKYC != null) {
      map['access_token_ekyc'] = accessTokenEKYC;
    }
    if (tokenIdEKYC != null) {
      map['token_id_ekyc'] = tokenIdEKYC;
    }
    if (tokenKeyEKYC != null) {
      map['token_key_ekyc'] = tokenKeyEKYC;
    }

    if (baseUrl != null) {
      map['base_url'] = baseUrl;
    }

    if (idNumber != null) {
      map['id_number'] = idNumber;
    }
    if (birthday != null) {
      map['birthday'] = birthday;
    }
    if (expiredDate != null) {
      map['expired_date'] = expiredDate;
    }

    if (languageSdk != null) {
      map['language_sdk'] = languageSdk!.channelValue;
    }
    if (isShowTutorial != null) {
      map['is_show_tutorial'] = isShowTutorial;
    }
    if (isEnableGotIt != null) {
      map['is_enable_got_it'] = isEnableGotIt;
    }
    if (isDisableTutorial != null) {
      map['is_disable_tutorial'] = isDisableTutorial;
    }
    if (isShowLogo != null) {
      map['is_show_logo'] = isShowLogo;
    }
    if (readerCardMode != null) {
      map['reader_card_mode'] = readerCardMode!.channelValue;
    }
    if (isEnableUploadImage != null) {
      map['is_enable_upload_image'] = isEnableUploadImage;
    }
    if (isEnablePostcodeMatching != null) {
      map['is_enable_postcode_matching'] = isEnablePostcodeMatching;
    }
    if (inputClientSession != null) {
      map['input_client_session'] = inputClientSession;
    }
    if (challengeCode != null) {
      map['challenge_code'] = challengeCode;
    }
    if (readingTagsNFC != null) {
      map['reading_tags_nfc'] = readingTagsNFC;
    }
    if (isEnableCheckChipClone != null) {
      map['is_enable_check_chip_clone'] = isEnableCheckChipClone;
    }
    if (isEnableWaterMark != null) {
      map['is_enable_water_mark'] = isEnableWaterMark;
    }
    if (isEnableAddIdCheckData != null) {
      map['is_enable_add_id_check_data'] = isEnableAddIdCheckData;
    }
    if (isEnableUploadDG != null) {
      map['is_enable_upload_dg'] = isEnableUploadDG;
    }
    if (textReadyNFC != null) {
      map['text_ready_nfc'] = textReadyNFC;
    }
    if (textScanningNFC != null) {
      map['text_scanning_nfc'] = textScanningNFC;
    }
    if (textFinishNFC != null) {
      map['text_finish_nfc'] = textFinishNFC;
    }
    if (textDetectedNFC != null) {
      map['text_detected_nfc'] = textDetectedNFC;
    }
    if (nameVideoHelpNFC != null) {
      map['name_video_help_nfc'] = nameVideoHelpNFC;
    }
    if (publicKey != null) {
      map['public_key'] = publicKey;
    }
    if (isEnableEncrypt != null) {
      map['is_enable_encrypt'] = isEnableEncrypt;
    }
    if (modeUploadFile != null) {
      map['mode_upload_file'] = modeUploadFile!.channelValue;
    }
    if (flowNFC != null) {
      map['flow_nfc'] = flowNFC!.channelValue;
    }
    if (numberTimesRetryScanNFC != null) {
      map['number_times_retry_scan_nfc'] = numberTimesRetryScanNFC;
    }
    if (isEnableCheckSimulator != null) {
      map['is_enable_check_simulator'] = isEnableCheckSimulator;
    }
    if (isEnableCheckJailbroken != null) {
      map['is_enable_check_jailbroken'] = isEnableCheckJailbroken;
    }
    if (isAnimatedDismissed != null) {
      map['is_animated_dismissed'] = isAnimatedDismissed;
    }
    if (urlUploadImage != null) {
      map['url_upload_image'] = urlUploadImage;
    }
    if (urlUploadDataNFC != null) {
      map['url_upload_data_nfc'] = urlUploadDataNFC;
    }
    if (urlUploadLogSDK != null) {
      map['url_upload_log_sdk'] = urlUploadLogSDK;
    }
    if (urlPostcodeMatching != null) {
      map['url_postcode_matching'] = urlPostcodeMatching;
    }
    if (headersRequest != null) {
      map['headers_request'] = headersRequest;
    }
    if (transactionId != null) {
      map['transaction_id'] = transactionId;
    }
    if (transactionPartnerId != null) {
      map['transaction_partner_id'] = transactionPartnerId;
    }
    if (transactionPartnerIDUploadNFC != null) {
      map['transaction_partner_id_upload_nfc'] = transactionPartnerIDUploadNFC;
    }
    if (transactionPartnerIDRecentLocation != null) {
      map['transaction_partner_id_recent_location'] = transactionPartnerIDRecentLocation;
    }
    if (transactionPartnerIDOriginalLocation != null) {
      map['transaction_partner_id_original_location'] = transactionPartnerIDOriginalLocation;
    }
    if (nameSSLPinning != null) {
      map['name_ssl_pinning'] = nameSSLPinning;
    }
    if (modeButtonHeaderBar != null) {
      map['mode_button_header_bar'] = modeButtonHeaderBar!.name;
    }
    return map;
  }

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
    bool? isShowLogo,
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
      isShowLogo: isShowLogo ?? this.isShowLogo,
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
