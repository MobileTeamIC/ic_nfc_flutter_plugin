import 'services/enum_nfc.dart';
import 'services/nfc_config.dart';
import 'services/nfc_method_channel.dart';
import 'services/nfc_presentation.dart';
import 'services/nfc_event_channel.dart';

class ICNfc {
  const ICNfc();

  static const ICNfc _instance = ICNfc();
  static ICNfc get instance => _instance;

  static const NfcMethodChannel _methodChannel = NfcMethodChannel();
  static const NfcEventChannel _eventChannel = NfcEventChannel();

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

  /// Stream of NFC reader state events
  ///
  /// Listen to this stream to receive real-time updates about the NFC reading process:
  /// - `started`: NFC reader has started listening
  /// - `didDetect`: NFC card detected
  /// - `reading`: Currently reading the card
  /// - `didError`: An error occurred during reading
  /// - `completed`: Reading completed successfully
  ///
  /// Example usage:
  /// ```dart
  /// final subscription = ICNfc.instance.nfcReaderStateStream.listen(
  ///   (event) {
  ///     print('NFC State: ${event.state}');
  ///     print('Progress: ${event.progress}%');
  ///     if (event.error.isNotEmpty) {
  ///       print('Error: ${event.error}');
  ///     }
  ///   },
  /// );
  ///
  /// // Remember to cancel when done
  /// await subscription.cancel();
  /// ```
  Stream<NfcReaderEvent> get nfcReaderStateStream {
    return _eventChannel.readerStateStream;
  }
}
