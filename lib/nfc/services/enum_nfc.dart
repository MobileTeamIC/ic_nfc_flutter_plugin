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

enum ICNfcError {
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

  static ICNfcError fromString(String error) {
    switch (error) {
      case 'ResponseError':
      case 'READ_DATA_FAILURE':
        return ICNfcError.responseError;
      case 'Timeout':
      case 'TIME_OUT_START_READ_NFC':
      case 'TIME_OUT_NETWORK':
        return ICNfcError.timeout;
      case 'NFCNotSupported':
      case 'NOT_SUPPORT':
        return ICNfcError.nfcNotSupported;
      case 'TagNotValid':
      case 'TAG_INVALID':
        return ICNfcError.tagNotValid;
      case 'ConnectionError':
      case 'NOT_CONNECTED_CHIP':
      case 'FAILED_CONNECT_CHIP':
        return ICNfcError.connectionError;
      case 'UserCanceled':
      case 'USER_CANCELED':
        return ICNfcError.userCanceled;
      case 'InvalidMRZKey':
      case 'DOCUMENT_NUMBER_INVALID':
      case 'DATE_OF_BIRTH_INVALID':
      case 'DATE_OF_EXPIRY_INVALID':
      case 'AUTHENTICATE_FAILURE':
        return ICNfcError.invalidMRZKey;
      case 'MoreThanOneTagFound':
        return ICNfcError.moreThanOneTagFound;
      case 'NoResponse':
        return ICNfcError.noResponse;
      case 'NFCError':
      case 'NFC_OPTION_NULL':
      case 'DISABLE':
        return ICNfcError.nfcError;
      default:
        // Attempt to match purely by string name if it matches an enum name exactly
        try {
          return ICNfcError.values.firstWhere((e) => e.name == error);
        } catch (_) {
          return ICNfcError.unknown;
        }
    }
  }

  String get description {
    switch (this) {
      case ICNfcError.responseError:
        return 'An error occurred while reading the card';
      case ICNfcError.timeout:
        return 'Card reading session has timed out';
      case ICNfcError.nfcNotSupported:
        return 'Device does not support NFC or NFC is unavailable';
      case ICNfcError.tagNotValid:
        return 'Invalid card tag';
      case ICNfcError.connectionError:
        return 'Connection error';
      case ICNfcError.userCanceled:
        return 'User canceled the operation';
      case ICNfcError.invalidMRZKey:
        return 'Invalid MRZ key or authentication failed';
      case ICNfcError.moreThanOneTagFound:
        return 'More than one card found';
      case ICNfcError.noResponse:
        return 'No response from card';
      case ICNfcError.nfcError:
      case ICNfcError.unknown:
        return 'Unknown error or general NFC error';
    }
  }
}
