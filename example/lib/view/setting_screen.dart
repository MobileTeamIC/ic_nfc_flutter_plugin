import 'package:flutter/material.dart';
import 'package:flutter_plugin_ic_nfc/nfc/services/enum_nfc.dart';

import '../service/shared_preference.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accessTokenController = TextEditingController();
  final TextEditingController _tokenIdController = TextEditingController();
  final TextEditingController _tokenKeyController = TextEditingController();
  final TextEditingController _baseUrlController = TextEditingController();
  final TextEditingController _tokenIdEKYCController = TextEditingController();
  final TextEditingController _tokenKeyEKYCController = TextEditingController();
  final TextEditingController _accessTokenEKYCController = TextEditingController();
  bool _isLoading = false;

  NfcLanguage _languageMode = NfcLanguage.icnfc_vi;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    _accessTokenController.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.accessToken,
    );
    _tokenIdController.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.tokenId,
    );
    _tokenKeyController.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.tokenKey,
    );
    _baseUrlController.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.baseUrl,
    );
    _tokenIdEKYCController.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.tokenIdEKYC,
    );
    _tokenKeyEKYCController.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.tokenKeyEKYC,
    );
    _accessTokenEKYCController.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.accessTokenEKYC,
    );
    _languageMode = SharedPreferenceService.instance.getBool(
      SharedPreferenceKeys.isViLanguageMode,
      defaultValue: true,
    ) ? NfcLanguage.icnfc_vi : NfcLanguage.icnfc_en;
  }

  @override
  void dispose() {
    _accessTokenController.dispose();
    _tokenIdController.dispose();
    _tokenKeyController.dispose();
    _baseUrlController.dispose();
    _tokenIdEKYCController.dispose();
    _tokenKeyEKYCController.dispose();
    _accessTokenEKYCController.dispose();
    super.dispose();
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Future.wait([
        SharedPreferenceService.instance.setString(
          SharedPreferenceKeys.accessToken,
          _accessTokenController.text.trim(),
        ),
        SharedPreferenceService.instance.setString(
          SharedPreferenceKeys.tokenId,
          _tokenIdController.text.trim(),
        ),
        SharedPreferenceService.instance.setString(
          SharedPreferenceKeys.tokenKey,
          _tokenKeyController.text.trim(),
        ),
        SharedPreferenceService.instance.setString(
          SharedPreferenceKeys.baseUrl,
          _baseUrlController.text.trim(),
        ),

        SharedPreferenceService.instance.setString(
          SharedPreferenceKeys.tokenIdEKYC,
          _tokenIdEKYCController.text.trim(),
        ),
        SharedPreferenceService.instance.setString(
          SharedPreferenceKeys.tokenKeyEKYC,
          _tokenKeyEKYCController.text.trim(),
        ),
        SharedPreferenceService.instance.setString(
          SharedPreferenceKeys.accessTokenEKYC,
          _accessTokenEKYCController.text.trim(),
        ),
        SharedPreferenceService.instance.setBool(
          SharedPreferenceKeys.isViLanguageMode,
          _languageMode == NfcLanguage.icnfc_vi,
        ),
      ]);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Đã lưu cài đặt thành công'),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text('Lỗi khi lưu: $e')),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Cài đặt')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Lanugage mode
                  DropdownButtonFormField<String>(
                    value: _languageMode.channelValue,
                    items: [
                      DropdownMenuItem(
                        value: NfcLanguage.icnfc_vi.channelValue,
                        child: Text('Tiếng Việt'),
                      ),
                      DropdownMenuItem(
                        value: NfcLanguage.icnfc_en.channelValue,
                        child: Text('Tiếng Anh'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(
                        () =>
                            _languageMode = NfcLanguage.values.firstWhere(
                              (e) => e.channelValue == value,
                            ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: _accessTokenController,
                    decoration: const InputDecoration(
                      labelText: 'Access Token',
                      hintText: 'Nhập Access Token',
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _tokenIdController,
                    decoration: const InputDecoration(
                      labelText: 'Token ID',
                      hintText: 'Nhập Token ID',
                      prefixIcon: Icon(Icons.badge),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _tokenKeyController,
                    decoration: const InputDecoration(
                      labelText: 'Token Key',
                      hintText: 'Nhập Token Key',
                      prefixIcon: Icon(Icons.key),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _accessTokenEKYCController,
                    decoration: const InputDecoration(
                      labelText: 'Access Token EKYC',
                      hintText: 'Nhập Access Token EKYC',
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _baseUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Base URL',
                      hintText: 'https://api.example.com',
                      prefixIcon: Icon(Icons.link),
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 16),
                  // tokenIdEKYC
                  TextField(
                    controller: _tokenIdEKYCController,
                    decoration: const InputDecoration(
                      labelText: 'Token ID EKYC',
                      hintText: 'Nhập Token ID EKYC',
                      prefixIcon: Icon(Icons.badge),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  // tokenKeyEKYC
                  TextField(
                    controller: _tokenKeyEKYCController,
                    decoration: const InputDecoration(
                      labelText: 'Token Key EKYC',
                      hintText: 'Nhập Token Key EKYC',
                      prefixIcon: Icon(Icons.key),
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 32),
                  // save button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveSettings,
                    child: Text(_isLoading ? 'Đang lưu...' : 'Lưu cài đặt'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
