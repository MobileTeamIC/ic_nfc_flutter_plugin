import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_ic_nfc/nfc/services/nfc_key_result.dart';

class LogScreen extends StatefulWidget {
  final Map<String, dynamic> json;

  const LogScreen({super.key, required this.json});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả NFC'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy_all),
            onPressed: () => _copyAllToClipboard(context),
            tooltip: 'Sao chép tất cả',
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
            tooltip: 'Đóng',
          ),
        ],
      ),
      body:
          widget.json.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 64,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Không có dữ liệu',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              )
              : ListView(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                children: [
                  // Text("json: ${widget.json}"),
                  _buildSafeImage(
                    widget.json[ICNfcKeyResult.pathImageAvatar] as String?,
                  ),

                  _buildLogItem(
                    context,
                    icon: Icons.image,
                    title: 'Data NFC',
                    content:
                        widget.json[ICNfcKeyResult.dataNFCResult].toString(),
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.credit_card,
                    title: 'Client session',
                    content: widget.json[ICNfcKeyResult.clientSessionResult],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.credit_card,
                    title: 'Avatar NFC',
                    content: widget.json[ICNfcKeyResult.pathImageAvatar],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.compare_arrows,
                    title: 'Hash avatar',
                    content: widget.json[ICNfcKeyResult.hashImageAvatar],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.face,
                    title: 'Postcode original location',
                    content:
                        widget
                            .json[ICNfcKeyResult.postcodeOriginalLocationResult]
                            .toString(),
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.face_retouching_natural,
                    title: 'Postcode recent location',
                    content:
                        widget.json[ICNfcKeyResult.postcodeRecentLocationResult]
                            .toString(),
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.qr_code,
                    title: 'Log NFC',
                    content: widget.json[ICNfcKeyResult.dataNFCResultJSON],
                  ),
                  const SizedBox(height: 12),

                  _buildLogItem(
                    context,
                    icon: Icons.document_scanner,
                    title: 'Data groups',
                    content:
                        widget.json[ICNfcKeyResult.dataGroupsResult].toString(),
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.document_scanner,
                    title: 'Hash avatar for log',
                    content: widget.json[ICNfcKeyResult.hashAvatarForLog],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.document_scanner,
                    title: 'Hash DGs for log',
                    content: widget.json[ICNfcKeyResult.hashDGsForLog],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.document_scanner,
                    title: 'NFC for log',
                    content: widget.json[ICNfcKeyResult.nfcForLog],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.document_scanner,
                    title: 'Matching origin for log',
                    content: widget.json[ICNfcKeyResult.matchingOriginForLog],
                  ),
                  const SizedBox(height: 12),
                  _buildLogItem(
                    context,
                    icon: Icons.document_scanner,
                    title: 'Matching residence for log',
                    content:
                        widget.json[ICNfcKeyResult.matchingResidenceForLog],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
    );
  }

  Widget _buildSafeImage(String? path) {
    if (path == null || path.isEmpty) {
      return const SizedBox.shrink();
    }

    File file;
    try {
      if (path.startsWith('file://')) {
        file = File(Uri.parse(path).toFilePath());
      } else {
        file = File(path);
      }
    } catch (e) {
      return Text('Error parsing path: $e');
    }

    // Kiểm tra file có tồn tại không trước khi đọc
    if (!file.existsSync()) {
      return const SizedBox.shrink();
    }

    // Đọc file thành bytes.
    // Lưu ý: readAsBytesSync nhanh gọn cho ảnh nhỏ (CMND/Avatar),
    // nhưng nếu ảnh quá lớn (vài MB) có thể gây khựng UI nhẹ.
    Uint8List imageBytes;
    try {
      imageBytes = file.readAsBytesSync();
    } catch (e) {
      return const SizedBox.shrink();
    }

    return Image.memory(
      imageBytes,
      // Quan trọng: gaplessPlayback giúp ảnh không bị nháy trắng khi reload
      gaplessPlayback: true,
      // Thêm key để đảm bảo Widget được vẽ lại nếu bytes thay đổi (thường Image.memory tự xử lý nhưng thêm cho chắc)
      key: ValueKey(DateTime.now().millisecondsSinceEpoch),
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox.shrink();
      },
    );
  }

  Future<void> _copyToClipboard(BuildContext context, String? content) async {
    if (content != null && content.trim().isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: content));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('Đã sao chép'),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    }
  }

  Widget _buildLogItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? content,
  }) {
    if (content == null || content.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    Map<String, dynamic>? parsedJson;
    String displayText;
    bool isJson = false;

    try {
      parsedJson = jsonDecode(content);
      isJson = true;
      // Format JSON with indentation
      const encoder = JsonEncoder.withIndent('  ');
      displayText = encoder.convert(parsedJson);
    } catch (e) {
      displayText = content;
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (isJson && parsedJson?['logID'] != null)
                  TextButton.icon(
                    onPressed:
                        () => _copyToClipboard(
                          context,
                          parsedJson!['logID']?.toString(),
                        ),
                    icon: const Icon(Icons.copy, size: 16, color: Colors.white),
                    label: const Text(
                      'LogID',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                TextButton.icon(
                  onPressed: () => _copyToClipboard(context, content),
                  icon: const Icon(Icons.copy, size: 16, color: Colors.white),
                  label: const Text(
                    'Sao chép',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: SelectableText(
              displayText,
              style: TextStyle(
                fontFamily: isJson ? 'monospace' : null,
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _copyAllToClipboard(BuildContext context) async {
    final buffer = StringBuffer();
    buffer.writeln('json: ${widget.json}');
    buffer.writeln('--------------------------------');
    final keys = [
      ICNfcKeyResult.dataGroupsResult,
      ICNfcKeyResult.dataNFCResult,
      ICNfcKeyResult.clientSessionResult,
      ICNfcKeyResult.pathImageAvatar,
      ICNfcKeyResult.hashImageAvatar,
      ICNfcKeyResult.postcodeOriginalLocationResult,
      ICNfcKeyResult.postcodeRecentLocationResult,
      ICNfcKeyResult.hashAvatarForLog,
      ICNfcKeyResult.hashDGsForLog,
      ICNfcKeyResult.nfcForLog,
      ICNfcKeyResult.matchingOriginForLog,
      ICNfcKeyResult.matchingResidenceForLog,
    ];

    for (final key in keys) {
      final content = widget.json[key];
      if (content != null && content.toString().trim().isNotEmpty) {
        buffer.writeln('$key:');
        buffer.writeln(content);
        buffer.writeln('\n---\n');
      }
    }

    if (buffer.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: buffer.toString()));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Đã sao chép tất cả'),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    }
  }
}
