import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_ic_nfc/nfc/nfc.dart';
import 'package:flutter_plugin_ic_nfc/nfc/services/enum_nfc.dart';
import 'package:flutter_plugin_ic_nfc/nfc/services/nfc_presentation.dart';
import 'package:flutter_plugin_ic_nfc_example/service/shared_preference.dart';
import 'package:flutter_plugin_ic_nfc_example/view/log_screen.dart';

class NfcScreen extends StatefulWidget {
  const NfcScreen({super.key});

  @override
  State<NfcScreen> createState() => _NfcScreenState();
}

class _NfcScreenState extends State<NfcScreen> {
  final _idCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _expCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  /// ----------------------------
  /// CONFIG
  /// ----------------------------
  ICNfcLanguage get _language =>
      SharedPreferenceService.instance.getBool(
            SharedPreferenceKeys.isViLanguageMode,
            defaultValue: true,
          )
          ? ICNfcLanguage.icnfc_vi
          : ICNfcLanguage.icnfc_en;

  /// ----------------------------
  /// COMMON CALL NFC
  /// ----------------------------

  void loadData() {
    _idCtrl.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.idNumber,
    );
    _dobCtrl.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.birthday,
    );
    _expCtrl.text = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.expiredDate,
    );
  }

  /// ----------------------------
  /// NAV TO LOG
  /// ----------------------------
  void _navigate(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => LogScreen(json: json)),
      );
    }
  }

  /// ----------------------------
  /// VALIDATION
  /// ----------------------------
  bool _validateInputs() {
    final id = _idCtrl.text.trim();
    final dob = _dobCtrl.text.trim();
    final exp = _expCtrl.text.trim();

    if ([id, dob, exp].any((e) => e.isEmpty)) {
      _showError('Thiếu thông tin, vui lòng nhập đủ.');
      return false;
    }
    if (id.length != 12 || dob.length != 6 || exp.length != 6) {
      _showError('Định dạng sai: số thẻ 12 số, ngày sinh/hết hạn YYMMDD');
      return false;
    }
    return true;
  }

  /// ----------------------------
  /// API WRAPPERS
  /// ----------------------------
  Future<void> _qrToNfc() async {
    try {
      SharedPreferenceService.instance.setString(
        SharedPreferenceKeys.idNumber,
        _idCtrl.text.trim(),
      );
      SharedPreferenceService.instance.setString(
        SharedPreferenceKeys.birthday,
        _dobCtrl.text.trim(),
      );
      SharedPreferenceService.instance.setString(
        SharedPreferenceKeys.expiredDate,
        _expCtrl.text.trim(),
      );

      final config = NfcPresets.qrToNfc(
        accessToken: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.accessToken,
          ),
          tokenId: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenId,
          ),
          tokenKey: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenKey,
          ),
          accessTokenEKYC: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.accessTokenEKYC,
          ),
          tokenIdEKYC: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenIdEKYC,
          ),
          tokenKeyEKYC: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenKeyEKYC,
          ),
          baseUrl: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.baseUrl,
          ),
          languageSdk: _language,
          modeButtonHeaderBar: ModeButtonHeaderBar.rightButton,
          isShowLogo: false,
        );
     _navigate(await ICNfc.instance.qrToNfc(config));
    } on PlatformException catch (e) {
      _showError("${e.code} - ${e.message}");
    }
  }

  Future<void> _mrzToNfc() async {
    try {
      SharedPreferenceService.instance.setString(
        SharedPreferenceKeys.idNumber,
        _idCtrl.text.trim(),
      );
      SharedPreferenceService.instance.setString(
        SharedPreferenceKeys.birthday,
        _dobCtrl.text.trim(),
      );
      SharedPreferenceService.instance.setString(
        SharedPreferenceKeys.expiredDate,
        _expCtrl.text.trim(),
      );

      final config = NfcPresets.mrzToNfc(
        accessToken: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.accessToken,
          ),
          tokenId: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenId,
          ),
          tokenKey: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenKey,
          ),
          accessTokenEKYC: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.accessTokenEKYC,
          ),
          tokenIdEKYC: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenIdEKYC,
          ),
          tokenKeyEKYC: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenKeyEKYC,
          ),
          baseUrl: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.baseUrl,
          ),
          languageSdk: _language,
          modeButtonHeaderBar: ModeButtonHeaderBar.rightButton,
          isShowLogo: false,
      );

     _navigate(await ICNfc.instance.mrzToNfc(config));
    } on PlatformException catch (e) {
      _showError("${e.code} - ${e.message}");
    }
  }

  Future<void> _nfcWithUi() async {
    try {
      SharedPreferenceService.instance.setString(
        SharedPreferenceKeys.idNumber,
        _idCtrl.text.trim(),
      );
      SharedPreferenceService.instance.setString(
        SharedPreferenceKeys.birthday,
        _dobCtrl.text.trim(),
      );
      SharedPreferenceService.instance.setString(
        SharedPreferenceKeys.expiredDate,
        _expCtrl.text.trim(),
      );
      if (!_validateInputs()) return Future.value({});

       final config = NfcPresets.manualWithUi(
        idNumber: _idCtrl.text.trim(),
        birthday: _dobCtrl.text.trim(),
        expiredDate: _expCtrl.text.trim(),
        accessToken: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.accessToken,
          ),
          tokenId: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenId,
          ),
          tokenKey: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenKey,
          ),
          accessTokenEKYC: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.accessTokenEKYC,
          ),
          tokenIdEKYC: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenIdEKYC,
          ),
          tokenKeyEKYC: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenKeyEKYC,
          ),
          baseUrl: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.baseUrl,
          ),
          languageSdk: _language,
          modeButtonHeaderBar: ModeButtonHeaderBar.rightButton,
          isShowLogo: false,
      );
     _navigate(await ICNfc.instance.onlyNfcWithUi(config));
    } on PlatformException catch (e) {
      _showError("${e.code} - ${e.message}");
    }
  }

  Future<void> _nfcWithoutUi() async {
    try {
      SharedPreferenceService.instance.setString(
        SharedPreferenceKeys.idNumber,
        _idCtrl.text.trim(),
      );
      SharedPreferenceService.instance.setString(
        SharedPreferenceKeys.birthday,
        _dobCtrl.text.trim(),
      );
      SharedPreferenceService.instance.setString(
        SharedPreferenceKeys.expiredDate,
        _expCtrl.text.trim(),
      );
      if (!_validateInputs()) return;
        final config = NfcPresets.manualWithoutUi(
        idNumber: _idCtrl.text.trim(),
        birthday: _dobCtrl.text.trim(),
        expiredDate: _expCtrl.text.trim(),
        accessToken: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.accessToken,
          ),
          tokenId: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenId,
          ),
          tokenKey: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenKey,
          ),
          accessTokenEKYC: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.accessTokenEKYC,
          ),
          tokenIdEKYC: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenIdEKYC,
          ),
          tokenKeyEKYC: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.tokenKeyEKYC,
          ),
          baseUrl: SharedPreferenceService.instance.getString(
            SharedPreferenceKeys.baseUrl,
          ),
          languageSdk: _language,
          modeButtonHeaderBar: ModeButtonHeaderBar.rightButton,
          isShowLogo: false,
      );
     _navigate(await ICNfc.instance.onlyNfcWithoutUi(config));
    } on PlatformException catch (e) {
      _showError("${e.code} - ${e.message}");
    }
  }

  /// ----------------------------
  /// ERROR UI
  /// ----------------------------
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// ----------------------------
  /// UI
  /// ----------------------------
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('NFC')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _InputField(label: "Số CMND/CCCD", controller: _idCtrl),
              const SizedBox(height: 16),
              _InputField(label: "Ngày sinh - YYMMDD", controller: _dobCtrl),
              const SizedBox(height: 16),
              _InputField(label: "Ngày hết hạn - YYMMDD", controller: _expCtrl),
              const SizedBox(height: 16),

              _ActionCard(
                icon: Icons.qr_code,
                title: "QR Code NFC Flow",
                description: "Đọc thông tin từ QR Code rồi vào NFC",
                onTap: () async => _qrToNfc(),
              ),
              _ActionCard(
                icon: Icons.document_scanner,
                title: "MRZ NFC Flow",
                description: "Đọc thông tin MRZ rồi vào NFC",
                onTap: () async => _mrzToNfc(),
              ),
              _ActionCard(
                icon: Icons.nfc,
                title: "NFC With UI",
                description: "Đọc thông tin từ NFC với UI SDK",
                onTap: () async => _nfcWithUi(),
              ),
              _ActionCard(
                icon: Icons.nfc_rounded,
                title: "NFC Without UI",
                description: "Đọc NFC trực tiếp trong app",
                onTap: () async => _nfcWithoutUi(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ============================
/// REUSABLE WIDGETS
/// ============================
class _InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _InputField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(label, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(labelText: label),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: theme.colorScheme.surface),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(description, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
