import 'dart:convert';

import 'package:flutter/services.dart';

import 'nfc_config.dart';

// ─────────────────────────────────────────────
// Constants
// ─────────────────────────────────────────────

/// Tên MethodChannel dùng chung giữa Flutter và Native.
abstract class _NfcChannel {
  static const String name = 'flutter.sdk.ic.nfc/integrate';

  // Flutter → Native methods
  static const String qrCode = 'NFC_QR_CODE';
  static const String mrzCode = 'NFC_MRZ_CODE';
  static const String onlyUi = 'NFC_ONLY_UI';
  static const String onlyWithoutUi = 'NFC_ONLY_WITHOUT_UI';

  // Native → Flutter events
  static const String eventChipDisappear = 'onChipDisappear';
}

// ─────────────────────────────────────────────
// NfcMethodChannel
// ─────────────────────────────────────────────

/// Dịch vụ giao tiếp hai chiều giữa Flutter và Native qua MethodChannel.
class NfcMethodChannel {
  static const MethodChannel _channel = MethodChannel(_NfcChannel.name);

  const NfcMethodChannel();

  // ── Flutter → Native ──────────────────────

  /// Quét QR Code → Đọc chip NFC.
  Future<Map<String, dynamic>> startQrToNfc(ICNfcConfig config) {
    return _invokeMethod(_NfcChannel.qrCode, config);
  }

  /// Quét MRZ → Đọc chip NFC.
  Future<Map<String, dynamic>> startMrzToNfc(ICNfcConfig config) {
    return _invokeMethod(_NfcChannel.mrzCode, config);
  }

  /// Nhập thủ công → Đọc chip NFC (có UI của SDK).
  Future<Map<String, dynamic>> startOnlyNfc(ICNfcConfig config) {
    return _invokeMethod(_NfcChannel.onlyUi, config);
  }

  /// Nhập thủ công → Đọc chip NFC (không có UI của SDK).
  Future<Map<String, dynamic>> startOnlyNfcWithoutUi(ICNfcConfig config) {
    return _invokeMethod(_NfcChannel.onlyWithoutUi, config);
  }

  // ── Native → Flutter ──────────────────────

  /// Lắng nghe sự kiện chip rời khỏi vùng đọc từ Native.
  ///
  /// Truyền [callback] để nhận thông báo. Truyền `null` để huỷ lắng nghe.
  void setOnChipDisappear(void Function()? callback) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == _NfcChannel.eventChipDisappear) {
        callback?.call();
      }
    });
  }

  // ── Private helper ────────────────────────

  Future<Map<String, dynamic>> _invokeMethod(
    String method,
    ICNfcConfig config,
  ) async {
    try {
      final dynamic result = await _channel.invokeMethod(method, config.toMap());
      if (result == null) return {};

      final decoded = jsonDecode(result as String);
      if (decoded is Map<String, dynamic>) return decoded;
      return {};
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw PlatformException(
        code: 'UNKNOWN_ERROR',
        message: 'Unknown error occurred: $e',
      );
    }
  }
}
