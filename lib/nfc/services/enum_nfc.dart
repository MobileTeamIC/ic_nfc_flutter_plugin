/// Flutter-side enums mirroring NFC SDK options.
enum NfcFlowType { qrToNfc, mrzToNfc, onlyNfcWithUi, onlyNfcWithoutUi }

enum ICNfcLanguage { icnfc_vi, icnfc_en }

enum ModeButtonHeaderBar { leftButton, rightButton }

extension ICNfcLanguageValue on ICNfcLanguage {
  String get channelValue {
    switch (this) {
      case ICNfcLanguage.icnfc_vi:
        return 'icnfc_vi';
      case ICNfcLanguage.icnfc_en:
        return 'icnfc_en';
    }
  }
}

enum ReaderCardMode { qrCode, mrzCode, nfcReader, nfcOutside }

extension ReaderCardModeValue on ReaderCardMode {
  String get channelValue {
    switch (this) {
      case ReaderCardMode.qrCode:
        return 'QRCode';
      case ReaderCardMode.mrzCode:
        return 'MRZCode';
      case ReaderCardMode.nfcReader:
        return 'NFCReader';
      case ReaderCardMode.nfcOutside:
        return 'NFCOutside';
    }
  }
}

enum NfcModeUploadFile { icnfcDefault, icnfcCreateLink }

extension NfcModeUploadFileValue on NfcModeUploadFile {
  String get channelValue {
    switch (this) {
      case NfcModeUploadFile.icnfcDefault:
        return 'ICNFCDefault';
      case NfcModeUploadFile.icnfcCreateLink:
        return 'ICNFCCreateLink';
    }
  }
}

enum NfcFlow { icnfcNtb, icnfcEtb, icnfcVerify }

extension NfcFlowValue on NfcFlow {
  String get channelValue {
    switch (this) {
      case NfcFlow.icnfcNtb:
        return 'ICNFCNTB';
      case NfcFlow.icnfcEtb:
        return 'ICNFCETB';
      case NfcFlow.icnfcVerify:
        return 'ICNFCVERIFY';
    }
  }
}

enum CardReaderValues {
  verifyDocumentInfo,
  mrzInfo,
  imageAvatarInfo,
  securityDataInfo,
}

extension CardReaderValuesValue on CardReaderValues {
  int get channelValue {
    switch (this) {
      case CardReaderValues.verifyDocumentInfo:
        return 100019;
      case CardReaderValues.mrzInfo:
        return 100020;
      case CardReaderValues.imageAvatarInfo:
        return 100021;
      case CardReaderValues.securityDataInfo:
        return 100022;
    }
  }
}

enum ICNFCReaderState {
  started(0), // Bắt đầu lắng nghe
  didDetect(1), // Phát hiện thẻ
  reading(2), // Đang đọc
  didError(3), // Lỗi
  completed(4); // Hoàn thành

  final int value;
  const ICNFCReaderState(this.value);

  /// Convert từ int sang enum
  static ICNFCReaderState fromInt(int value) {
    return ICNFCReaderState.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ICNFCReaderState.started,
    );
  }
}

enum ICNFCErrorType {
  cancelled,
  hasError,
  invalidArgumentsPlugin,
  jsonErrorPlugin;

  String get value {
    switch (this) {
      case ICNFCErrorType.cancelled:
        return 'IC_NFC_CANCELLED';
      case ICNFCErrorType.hasError:
        return 'IC_NFC_HAS_ERROR';
      case ICNFCErrorType.invalidArgumentsPlugin:
        return 'IC_NFC_INVALID_ARGUMENTS';
      case ICNFCErrorType.jsonErrorPlugin:
        return 'IC_NFC_JSON_ERROR';
    }
  }
}

enum ICNFCError {
  /// Đã xảy ra sự cố khi đọc thẻ
  responseError,

  /// Hết thời gian phiên đọc thẻ còn hiệu lực
  timeout,

  /// Thiết bị không hỗ trợ NFC, hoặc không có NFC
  nfcNotSupported,

  /// Thẻ không hợp lệ
  tagNotValid,

  /// Lỗi kết nối
  connectionError,

  /// Khi người dùng bấm nút Huỷ ở màn hình đọc thông tin căn cước
  userCanceled,

  /// Khóa MRZ không hợp lệ cho thẻ này
  invalidMRZKey,

  /// Nhiều hơn 01 thẻ được tìm thấy
  moreThanOneTagFound,

  /// Không có phản hồi thông tin từ thẻ
  noResponse,

  /// Các lỗi chung khi thực hiện đọc thông tin thẻ căn cước
  nfcError,

  /// Default unknown error
  unknown;

  static ICNFCError fromString(String error) {
    switch (error) {
      case 'ResponseError':
      case 'READ_DATA_FAILURE':
        return ICNFCError.responseError;
      case 'Timeout':
      case 'TIME_OUT_START_READ_NFC':
      case 'TIME_OUT_NETWORK':
        return ICNFCError.timeout;
      case 'NFCNotSupported':
      case 'NOT_SUPPORT':
        return ICNFCError.nfcNotSupported;
      case 'TagNotValid':
      case 'TAG_INVALID':
        return ICNFCError.tagNotValid;
      case 'ConnectionError':
      case 'NOT_CONNECTED_CHIP':
      case 'FAILED_CONNECT_CHIP':
        return ICNFCError.connectionError;
      case 'UserCanceled':
      case 'USER_CANCELED':
        return ICNFCError.userCanceled;
      case 'InvalidMRZKey':
      case 'DOCUMENT_NUMBER_INVALID':
      case 'DATE_OF_BIRTH_INVALID':
      case 'DATE_OF_EXPIRY_INVALID':
      case 'AUTHENTICATE_FAILURE':
        return ICNFCError.invalidMRZKey;
      case 'MoreThanOneTagFound':
        return ICNFCError.moreThanOneTagFound;
      case 'NoResponse':
        return ICNFCError.noResponse;
      case 'NFCError':
      case 'NFC_OPTION_NULL':
      case 'DISABLE':
        return ICNFCError.nfcError;
      default:
        // Attempt to match purely by string name if it matches an enum name exactly
        try {
          return ICNFCError.values.firstWhere((e) => e.name == error);
        } catch (_) {
          return ICNFCError.unknown;
        }
    }
  }

  String get description {
    switch (this) {
      case ICNFCError.responseError:
        return 'An error occurred while reading the card';
      case ICNFCError.timeout:
        return 'Card reading session has timed out';
      case ICNFCError.nfcNotSupported:
        return 'Device does not support NFC or NFC is unavailable';
      case ICNFCError.tagNotValid:
        return 'Invalid card tag';
      case ICNFCError.connectionError:
        return 'Connection error';
      case ICNFCError.userCanceled:
        return 'User canceled the operation';
      case ICNFCError.invalidMRZKey:
        return 'Invalid MRZ key or authentication failed';
      case ICNFCError.moreThanOneTagFound:
        return 'More than one card found';
      case ICNFCError.noResponse:
        return 'No response from card';
      case ICNFCError.nfcError:
      case ICNFCError.unknown:
        return 'Unknown error or general NFC error';
    }
  }
}