import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_ic_nfc/nfc/nfc.dart';
import 'package:flutter_plugin_ic_nfc/nfc/services/enum_nfc.dart';
import 'package:flutter_plugin_ic_nfc/nfc/services/nfc_presentation.dart';
import 'package:flutter_plugin_ic_nfc_example/service/shared_preference.dart';
import 'package:flutter_plugin_ic_nfc_example/view/log_screen.dart';
import 'package:flutter_plugin_ic_nfc_example/view/setting_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../theme/context.dart';

class NfcScreen extends StatefulWidget {
  const NfcScreen({super.key});

  @override
  State<NfcScreen> createState() => _NfcScreenState();
}

class _NfcScreenState extends State<NfcScreen> {
  final _idCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _expCtrl = TextEditingController();
  String _accessToken = '';
  String _tokenId = '';
  String _tokenKey = '';
  String _accessTokenEKYC = '';
  String _tokenIdEKYC = '';
  String _tokenKeyEKYC = '';
  String _baseUrl = '';
  ICNfcLanguage _language = ICNfcLanguage.icnfc_vi;
  ModeButtonHeaderBar _modeButtonHeaderBar = ModeButtonHeaderBar.leftButton;
  bool _isShowLogo = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

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
    _accessToken = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.accessToken,
    );
    _tokenId = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.tokenId,
    );
    _tokenKey = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.tokenKey,
    );
    _accessTokenEKYC = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.accessTokenEKYC,
    );
    _tokenIdEKYC = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.tokenIdEKYC,
    );
    _tokenKeyEKYC = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.tokenKeyEKYC,
    );
    _baseUrl = SharedPreferenceService.instance.getString(
      SharedPreferenceKeys.baseUrl,
    );
    _language =
        SharedPreferenceService.instance.getBool(
              SharedPreferenceKeys.isViLanguageMode,
              defaultValue: true,
            )
            ? ICNfcLanguage.icnfc_vi
            : ICNfcLanguage.icnfc_en;
    _modeButtonHeaderBar =
        SharedPreferenceService.instance.getString(
                  SharedPreferenceKeys.modeButtonHeaderBar,
                ) ==
                ModeButtonHeaderBar.leftButton.name
            ? ModeButtonHeaderBar.leftButton
            : ModeButtonHeaderBar.rightButton;
    _isShowLogo = SharedPreferenceService.instance.getBool(
      SharedPreferenceKeys.isShowLogo,
      defaultValue: false,
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

// MARK: - Validation
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

// MARK: - NFC Flows
  Future<void> _qrToNfc() async {
    try {
      final config = NfcPresets.qrToNfc(
        accessToken: _accessToken,
        tokenId: _tokenId,
        tokenKey: _tokenKey,
        accessTokenEKYC: _accessTokenEKYC,
        tokenIdEKYC: _tokenIdEKYC,
        tokenKeyEKYC: _tokenKeyEKYC,
        baseUrl: _baseUrl,
        languageSdk: _language,
        modeButtonHeaderBar: _modeButtonHeaderBar,
        isShowLogo: _isShowLogo,
        readingTagsNFC: [
          CardReaderValues.verifyDocumentInfo.channelValue,
          CardReaderValues.mrzInfo.channelValue,
          CardReaderValues.imageAvatarInfo.channelValue,
          CardReaderValues.securityDataInfo.channelValue,
        ],
      );
      _navigate(await ICNfc.instance.qrToNfc(config));
    } on PlatformException catch (e) {
      _showError("${e.code} - ${e.message}");
    }
  }

  Future<void> _mrzToNfc() async {
    try {
      final config = NfcPresets.mrzToNfc(
        accessToken: _accessToken,
        tokenId: _tokenId,
        tokenKey: _tokenKey,
        accessTokenEKYC: _accessTokenEKYC,
        tokenIdEKYC: _tokenIdEKYC,
        tokenKeyEKYC: _tokenKeyEKYC,
        baseUrl: _baseUrl,
        languageSdk: _language,
        modeButtonHeaderBar: _modeButtonHeaderBar,
        isShowLogo: _isShowLogo,
      );
      _navigate(await ICNfc.instance.mrzToNfc(config));
    } on PlatformException catch (e) {
      _showError("${e.code} - ${e.message}");
    }
  }

  Future<void> _nfcWithUi() async {
    try {
      // show dialog to input id, dob, exp
      if (!_validateInputs()) return Future.value({});
      final config = NfcPresets.manualWithUi(
        idNumber: _idCtrl.text.trim(),
        birthday: _dobCtrl.text.trim(),
        expiredDate: _expCtrl.text.trim(),
        accessToken: _accessToken,
        tokenId: _tokenId,
        tokenKey: _tokenKey,
        accessTokenEKYC: _accessTokenEKYC,
        tokenIdEKYC: _tokenIdEKYC,
        tokenKeyEKYC: _tokenKeyEKYC,
        baseUrl: _baseUrl,
        languageSdk: _language,
        modeButtonHeaderBar: _modeButtonHeaderBar,
        isShowLogo: _isShowLogo,
      );
      _navigate(await ICNfc.instance.onlyNfcWithUi(config));
    } on PlatformException catch (e) {
      _showError("${e.code} - ${e.message}");
    }
  }

Future<void> _showInputDOBAndExpiredDateDialog() async {
  showDialog(
    context: context,
    builder: (context) {
      return _DiaLogCommonIC(
        idCtrl: _idCtrl,
        dobCtrl: _dobCtrl,
        expCtrl: _expCtrl,
        onConfirm: () => _nfcWithUi(),
        onCancel: () => Navigator.pop(context),
      );
    });
  }

  Future<void> _nfcWithoutUi() async {
    try {
      if (!_validateInputs()) return;
      final config = NfcPresets.manualWithoutUi(
        idNumber: _idCtrl.text.trim(),
        birthday: _dobCtrl.text.trim(),
        expiredDate: _expCtrl.text.trim(),
        accessToken: _accessToken,
        tokenId: _tokenId,
        tokenKey: _tokenKey,
        accessTokenEKYC: _accessTokenEKYC,
        tokenIdEKYC: _tokenIdEKYC,
        tokenKeyEKYC: _tokenKeyEKYC,
        baseUrl: _baseUrl,
        languageSdk: _language,
        modeButtonHeaderBar: _modeButtonHeaderBar,
        isShowLogo: _isShowLogo,
      );
      _navigate(await ICNfc.instance.onlyNfcWithoutUi(config));
    } on PlatformException catch (e) {
      _showError("${e.code} - ${e.message}");
    }
  }

// MARK: - Error UI
  void _showError(String message) {
    ShadToaster.of(context).show(
      ShadToast.destructive(
        title: Text(message),
        titleStyle: context.theme.textTheme.p.copyWith(color: Colors.white),
        backgroundColor: context.theme.colorScheme.destructive,
      ),
    );
  }

// MARK: - UI
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ),
                ).then((_) => loadData());
              },
              tooltip: 'Cài đặt',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text("NFC SDK", style: context.textTheme.h1,),
              const SizedBox(height: 16),
              _ActionCard(
                icon: Icons.qr_code,
                title: "Quét mã QR Code -> Đọc chip NFC",
                description1: "Thực hiện quét mã QR code trên CCCD/Hộ chiếu",
                description2: "Đọc thông tin từ chip NFC",
                onTap: () async => _qrToNfc(),
              ),
              _ActionCard(
                icon: Icons.document_scanner,
                title: "MRZ NFC Flow",
                description1: "Đọc thông tin MRZ trên CCCD/Hộ chiếu",
                description2: "Đọc thông tin từ chip NFC",
                onTap: () async => _mrzToNfc(),
              ),
              _ActionCard(
                icon: Icons.nfc,
                title: "Nhập thông tin -> Đọc chip NFC",
                description1: "Nhập thông tin số CMND/CCCD, ngày sinh, ngày hết hạn",
                description2: "Đọc thông tin từ chip NFC",
                onTap: () async => _showInputDOBAndExpiredDateDialog(),
              ),
              _ActionCard(
                icon: Icons.nfc_rounded,
                title: "Nhập thông tin -> Đọc chip NFC tại ứng dụng",
                description1: "Nhập thông tin số CMND/CCCD, ngày sinh, ngày hết hạn",
                description2: "Đọc thông tin từ chip NFC",
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
  final String description1;
  final String description2;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description1,
    required this.description2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEFT ICON
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),

              const SizedBox(width: 16),

              // TEXT CONTENT (EXPANDED)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // DESCRIPTION 1
                    _iconTextRow(
                      context,
                      theme,
                      description1,
                    ),

                    const SizedBox(height: 6),

                    // DESCRIPTION 2
                    _iconTextRow(
                      context,
                      theme,
                      description2,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

             
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconTextRow(BuildContext context, ThemeData theme, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 18,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 6),

        Expanded(
          child: Text(
            text,
            style: context.textTheme.small.copyWith(
              color: context.colorScheme.mutedForeground,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}


class _DiaLogCommonIC extends StatelessWidget {
   final TextEditingController idCtrl;
  final TextEditingController dobCtrl;
  final TextEditingController expCtrl;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  const _DiaLogCommonIC({required this.idCtrl, required this.dobCtrl, required this.expCtrl, required this.onConfirm, required this.onCancel});
 
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 420, // 👈 tăng/giảm để rộng hơn
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nhập thông tin',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),

                // Nội dung input
                _InputField(label: "Số CMND/CCCD", controller: idCtrl),
                const SizedBox(height: 12),
                _InputField(label: "Ngày sinh - YYMMDD", controller: dobCtrl),
                const SizedBox(height: 12),
                _InputField(label: "Ngày hết hạn - YYMMDD", controller: expCtrl),

                const SizedBox(height: 24),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                      ),
                      onPressed: onCancel,
                      child: const Text("Hủy"),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        backgroundColor:
                            Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: onConfirm,
                      child: const Text("Xác nhận"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
   
  }
}