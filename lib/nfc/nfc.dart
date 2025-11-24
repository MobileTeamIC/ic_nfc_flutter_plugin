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

}
