import 'dart:convert';

import 'package:flutter/services.dart';

import 'nfc_config.dart';

/// Main NFC method channel service.
class NfcMethodChannel {
  static const MethodChannel _channel = MethodChannel(
    'flutter.sdk.ic.nfc/integrate',
  );

  const NfcMethodChannel();

  /// QR Code → NFC flow (`navigateToNfcQrCode`)
  Future<Map<String, dynamic>> startQrToNfc(ICNfcConfig config) async {
    return _invokeMethod('NFC_QR_CODE', config);
  }

  /// MRZ → NFC flow (`actionStart_MRZ_NFC`)
  Future<Map<String, dynamic>> startMrzToNfc(ICNfcConfig config) async {
    return _invokeMethod('NFC_MRZ_CODE', config);
  }

  /// Manual NFC with SDK UI (`actionStart_Only_NFC`)
  Future<Map<String, dynamic>> startOnlyNfc(ICNfcConfig config) async {
    return _invokeMethod('NFC_ONLY_UI', config);
  }

  /// Manual NFC without SDK UI (`actionStart_Only_NFC_WithoutUI`)
  Future<Map<String, dynamic>> startOnlyNfcWithoutUi(ICNfcConfig config) async {
    return _invokeMethod('NFC_ONLY_WITHOUT_UI', config);
  }

  Future<Map<String, dynamic>> _invokeMethod(
    String methodName,
    ICNfcConfig config,
  ) async {
    try {
      final dynamic result = await _channel.invokeMethod(
        methodName,
        config.toMap(),
      );

      if (result == null) return {};

      final decoded = jsonDecode(result as String);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return {};
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        message: 'Failed to invoke $methodName: ${e.message}',
        details: e.details,
      );
    } catch (e) {
      throw PlatformException(
        code: 'UNKNOWN_ERROR',
        message: 'Unknown error occurred: $e',
      );
    }
  }
}
