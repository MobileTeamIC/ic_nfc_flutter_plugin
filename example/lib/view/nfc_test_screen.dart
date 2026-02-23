
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NfcTestScreen extends StatefulWidget {
  final VoidCallback onNfcEnabled;

  const NfcTestScreen({super.key, required this.onNfcEnabled});

  @override
  State<NfcTestScreen> createState() => _NfcTestScreenState();
}

class _NfcTestScreenState extends State<NfcTestScreen> with WidgetsBindingObserver {
  bool _isNfcAvailable = false;
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkNfcStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkNfcStatus();
    }
  }

  Future<void> _checkNfcStatus() async {
    setState(() {
      _checking = true;
    });
    try {
      bool isAvailable = await NfcManager.instance.isAvailable();
      if (mounted) {
        setState(() {
          _isNfcAvailable = isAvailable;
        });
      }
    } catch (e) {
      debugPrint('Error checking NFC: $e');
      if (mounted) {
        setState(() {
          _isNfcAvailable = false;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _checking = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test NFC Flow'),
      ),
      body: Center(
        child: _checking
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isNfcAvailable ? Icons.nfc : Icons.nfc_outlined,
                      size: 80,
                      color: _isNfcAvailable ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _isNfcAvailable ? 'NFC đã được bật' : 'NFC đang tắt hoặc không có sẵn',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _isNfcAvailable
                          ? 'Thiết bị đã sẵn sàng để quét NFC.'
                          : 'Vui lòng bật NFC trong cài đặt để sử dụng tính năng này.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    if (!_isNfcAvailable)
                      ShadButton(
                        onPressed: () {
                          AppSettings.openAppSettings(type: AppSettingsType.nfc);
                        },
                        child: const Text('Mở cài đặt NFC'),
                      ),
                    if (_isNfcAvailable)
                      ShadButton(
                        onPressed: () {
                          // Trigger the callback to start the actual scan
                           widget.onNfcEnabled();
                        },
                        child: const Text('Mở chức năng NFC'),
                      ),
                    const SizedBox(height: 16),
                     ShadButton.outline(
                        onPressed: () {
                           _checkNfcStatus();
                        },
                        child: const Text('Kiểm tra lại'),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
