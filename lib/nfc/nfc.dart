import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'services/nfc_config.dart';
import 'services/nfc_method_channel.dart';

/// Regex kiểm tra định dạng màu hex hợp lệ: `#RRGGBB` hoặc `#AARRGGBB`
final _hexColorRegex = RegExp(r'^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$');

/// Chuyển đổi chuỗi hex sang [Color].
///
/// Hỗ trợ hai định dạng:
/// - `#RRGGBB` — không có alpha (mặc định alpha = 0xFF)
/// - `#AARRGGBB` — có alpha
///
/// Trả về `null` nếu [hex] là null.
///
/// **Ném ra [AssertionError]** trong debug mode nếu định dạng sai.
Color? _parseHexColor(String? hex) {
  if (hex == null) return null;

  assert(
    _hexColorRegex.hasMatch(hex),
    '[ICNfc] loadingColor "$hex" không đúng định dạng.\n'
    'Vui lòng truyền theo định dạng #RRGGBB (ví dụ: "#FF5722") '
    'hoặc #AARRGGBB (ví dụ: "#CCFF5722").',
  );

  if (!_hexColorRegex.hasMatch(hex)) return null;

  final clean = hex.replaceFirst('#', '');
  final value = int.parse(
    clean.length == 6 ? 'FF$clean' : clean,
    radix: 16,
  );
  return Color(value);
}

/// Public API duy nhất của NFC Plugin.
///
/// Tất cả giao tiếp với Native được uỷ quyền cho [NfcMethodChannel].
class ICNfc {
  const ICNfc._();

  static const ICNfc instance = ICNfc._();

  static const NfcMethodChannel _channel = NfcMethodChannel();

  // ── Flutter → Native ──────────────────────

  Future<Map<String, dynamic>> qrToNfc(ICNfcConfig config) =>
      _channel.startQrToNfc(config);

  Future<Map<String, dynamic>> mrzToNfc(ICNfcConfig config) =>
      _channel.startMrzToNfc(config);

  Future<Map<String, dynamic>> onlyNfcWithUi(ICNfcConfig config) =>
      _channel.startOnlyNfc(config);

  /// Thực hiện đọc chip NFC không sử dụng giao diện (UI) tích hợp sẵn của SDK.
  ///
  /// * [context]: BuildContext của màn hình hiện tại, dùng để hiển thị loading.
  /// * [config]: Cấu hình NFC, bao gồm [ICNfcConfig.loadingColor] dạng hex string
  ///   (ví dụ: `"#FF5722"` hoặc `"#CCFF5722"`). Nếu không truyền, dùng màu mặc định.
  Future<Map<String, dynamic>> onlyNfcWithoutUi(
    BuildContext context,
    ICNfcConfig config,
  ) async {
    bool isLoadingShown = false;

    final loadingColor = _parseHexColor(config.loadingColor) ?? Colors.green;

    if (Platform.isIOS) {
      _channel.setOnChipDisappear(() {
        if (!isLoadingShown) {
          isLoadingShown = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => Center(
              child: CupertinoActivityIndicator(
                color: loadingColor,
                radius: 16,
              ),
            ),
          );
        }
      });
    }

    try {
      final result = await _channel.startOnlyNfcWithoutUi(config);

      if (Platform.isIOS) {
        _channel.setOnChipDisappear(null);
        if (isLoadingShown && context.mounted) {
          Navigator.pop(context);
          isLoadingShown = false;
        }
      }

      return result;
    } catch (e) {
      if (Platform.isIOS) {
        _channel.setOnChipDisappear(null);
        if (isLoadingShown && context.mounted) {
          Navigator.pop(context);
          isLoadingShown = false;
        }
      }
      rethrow;
    }
  }

  // ── Native → Flutter ──────────────────────

  /// Lắng nghe sự kiện chip rời khỏi vùng đọc từ Native.
  ///
  /// Truyền [callback] để nhận thông báo. Truyền `null` để huỷ lắng nghe.
  void setOnChipDisappear(void Function()? callback) =>
      _channel.setOnChipDisappear(callback);
}
