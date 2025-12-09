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


enum CardReaderValues { verifyDocumentInfo, mrzInfo, imageAvatarInfo, securityDataInfo }
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