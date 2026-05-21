import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_ic_nfc/nfc/services/enum_nfc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../service/shared_preference.dart';
import '../theme/context.dart';

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
  final TextEditingController _accessTokenEKYCController =
      TextEditingController();
  final TextEditingController _numberTimesRetryScanNFCController =
      TextEditingController();
  bool _isLoading = false;

  ICNfcLanguage _languageMode = ICNfcLanguage.icnfc_vi;
  ModeButtonHeaderBar _modeButtonHeaderBar = ModeButtonHeaderBar.leftButton;
  bool _isShowLogo = false;

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
    _accessTokenEKYCController.text = SharedPreferenceService.instance
        .getString(SharedPreferenceKeys.accessTokenEKYC);
    _languageMode =
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
    _numberTimesRetryScanNFCController.text =
        (SharedPreferenceService.instance.getInt(
                  SharedPreferenceKeys.numberTimesRetryScanNFC,
                ) ??
                3)
            .toString();
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
    _numberTimesRetryScanNFCController.dispose();
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
          _languageMode == ICNfcLanguage.icnfc_vi,
        ),
        SharedPreferenceService.instance.setString(
          SharedPreferenceKeys.modeButtonHeaderBar,
          _modeButtonHeaderBar.name,
        ),
        SharedPreferenceService.instance.setBool(
          SharedPreferenceKeys.isShowLogo,
          _isShowLogo,
        ),
        SharedPreferenceService.instance.setInt(
          SharedPreferenceKeys.numberTimesRetryScanNFC,
          int.tryParse(_numberTimesRetryScanNFCController.text.trim()) ?? 3,
        ),
      ]);

      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast(
            title: Text('Đã lưu cài đặt thành công'),
            titleStyle: context.textTheme.p.copyWith(color: Colors.white),
            backgroundColor: context.colorScheme.primary,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast(
            title: Text('Lỗi khi lưu: $e'),
            titleStyle: context.textTheme.p.copyWith(color: Colors.white),
            backgroundColor: context.colorScheme.destructive,
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
        appBar: AppBar(title: Text('Cài đặt', style: context.textTheme.h3)),
        body: SafeArea(
          child: Column(
            spacing: 16,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Hiển thị Logo',
                              style: context.textTheme.large,
                            ),
                            Spacer(),
                            ShadSwitch(
                              value: _isShowLogo,
                              onChanged: (v) => setState(() => _isShowLogo = v),
                            ),
                          ],
                        ),
                        _titleAndWidget(
                          'Mode Button Header Bar',
                          ShadSelect<String>(
                            selectedOptionBuilder:
                                (context, value) => Text(value),
                            placeholder: const Text(' Mode Button Header Bar'),

                            options: [
                              ShadOption(
                                value: ModeButtonHeaderBar.leftButton.name,
                                child: Text(
                                  ModeButtonHeaderBar.leftButton.name,
                                ),
                              ),
                              ShadOption(
                                value: ModeButtonHeaderBar.rightButton.name,
                                child: Text(
                                  ModeButtonHeaderBar.rightButton.name,
                                ),
                              ),
                            ],
                            onChanged:
                                (value) => setState(
                                  () =>
                                      _modeButtonHeaderBar = ModeButtonHeaderBar
                                          .values
                                          .firstWhere((e) => e.name == value),
                                ),
                          ),
                        ),

                        // Lanugage mode
                        _titleAndWidget(
                          'Ngôn ngữ',
                          ShadSelect<String>(
                            selectedOptionBuilder:
                                (context, value) => Text(
                                  value == ICNfcLanguage.icnfc_vi.name
                                      ? 'Tiếng Việt'
                                      : 'Tiếng Anh',
                                ),
                            placeholder: const Text(' Chọn Ngôn ngữ'),
                            onChanged:
                                (value) => setState(
                                  () =>
                                      _languageMode = ICNfcLanguage.values
                                          .firstWhere((e) => e.name == value),
                                ),
                            initialValue: _languageMode.name,
                            options: [
                              ShadOption(
                                value: ICNfcLanguage.icnfc_vi.name,
                                child: Text('Tiếng Việt'),
                              ),
                              ShadOption(
                                value: ICNfcLanguage.icnfc_en.name,
                                child: Text('Tiếng Anh'),
                              ),
                            ],
                          ),
                        ),

                        // Base URL
                        _titleAndTextFormField(
                          id: 'base_url',
                          title: 'Base URL',
                          placeholder: 'Nhập Base URL',
                          controller: _baseUrlController,
                        ),

                        // access token
                        _titleAndTextFormField(
                          id: 'access_token',
                          title: 'Access Token',
                          placeholder: 'Nhập Access Token',
                          controller: _accessTokenController,
                          isTextArea: true,
                        ),

                        // Token ID
                        _titleAndTextFormField(
                          id: 'token_id',
                          title: 'Token ID',
                          placeholder: 'Nhập Token ID',
                          controller: _tokenIdController,
                        ),

                        // Token Key
                        _titleAndTextFormField(
                          id: 'token_key',
                          title: 'Token Key',
                          placeholder: 'Nhập Token Key',
                          controller: _tokenKeyController,
                        ),

                        // access token ekyc
                        _titleAndTextFormField(
                          id: 'access_token_ekyc',
                          title: 'Access Token EKYC',
                          placeholder: 'Nhập Access Token EKYC',
                          controller: _accessTokenEKYCController,
                        ),

                        // tokenIdEKYC
                        _titleAndTextFormField(
                          id: 'token_id_ekyc',
                          title: 'Token ID EKYC',
                          placeholder: 'Nhập Token ID EKYC',
                          controller: _tokenIdEKYCController,
                        ),

                        // tokenKeyEKYC
                        _titleAndTextFormField(
                          id: 'token_key_ekyc',
                          title: 'Token Key EKYC',
                          placeholder: 'Nhập Token Key EKYC',
                          controller: _tokenKeyEKYCController,
                        ),

                        // numberTimesRetryScanNFC
                        _titleAndNumberFormField(
                          id: 'number_times_retry_scan_nfc',
                          title: 'Số lần thử lại quét NFC',
                          placeholder: 'Nhập số lần thử lại (mặc định: 3)',
                          controller: _numberTimesRetryScanNFCController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // save button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ShadButton(
                  onPressed: _isLoading ? null : _saveSettings,
                  backgroundColor: context.colorScheme.primary,
                  width: double.infinity,
                  height: 48,
                  child: Text(
                    _isLoading ? 'Đang lưu...' : 'Lưu cài đặt',
                    style: context.textTheme.large,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _titleAndTextFormField({
    required String id,
    required String title,
    required String placeholder,
    required TextEditingController controller,
    bool isTextArea = false,
  }) {
    if (isTextArea) {
      return ShadTextareaFormField(
        id: id,
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Row(
              spacing: 8,
              children: [
                ShadIconButton(
                  backgroundColor: context.colorScheme.cardForeground,
                  width: 32,
                  height: 32,
                  onPressed: () => _handlePaste(context, controller),
                  icon: const Icon(LucideIcons.clipboardPaste),
                ),
                ShadIconButton(
                  backgroundColor: context.colorScheme.cardForeground,
                  width: 32,
                  height: 32,
                  onPressed: () => _handleCopy(controller.text),
                  icon: const Icon(LucideIcons.copy),
                ),
              ],
            ),
          ],
        ),
        resizable: true,
        maxHeight: 400,
        minHeight: 100,
        placeholder: Text(placeholder),
        controller: controller,
      );
    } else {
      return ShadInputFormField(
        id: id,
        label: Text(title),
        placeholder: Text(placeholder),
        controller: controller,
        trailing: Row(
          spacing: 8,
          children: [
            ShadIconButton(
              backgroundColor: context.colorScheme.cardForeground,
              width: 32,
              height: 32,
              onPressed: () => _handlePaste(context, controller),
              icon: const Icon(LucideIcons.clipboardPaste),
            ),
            ShadIconButton(
              backgroundColor: context.colorScheme.cardForeground,
              width: 32,
              height: 32,
              onPressed: () => _handleCopy(controller.text),
              icon: const Icon(LucideIcons.copy),
            ),
          ],
        ),
      );
    }
  }

  _titleAndWidget(String title, Widget widget) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        widget,
      ],
    );
  }

  _titleAndNumberFormField({
    required String id,
    required String title,
    required String placeholder,
    required TextEditingController controller,
  }) {
    return ShadInputFormField(
      id: id,
      label: Text(title),
      placeholder: Text(placeholder),
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  //handle
  _handleCopy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ShadToaster.of(context).show(
      ShadToast(
        title: Text('Đã copy vào clipboard'),
        titleStyle: context.textTheme.p.copyWith(color: Colors.white),
        backgroundColor: context.colorScheme.primary,
      ),
    );
  }

  _handlePaste(BuildContext context, TextEditingController controller) async {
    final clipboard = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboard != null) {
      controller.text = clipboard.text ?? '';
      if (context.mounted) {
        ShadToaster.of(context).show(
          ShadToast(
            title: Text('Đã paste vào clipboard'),
            titleStyle: context.textTheme.p.copyWith(color: Colors.white),
            backgroundColor: context.colorScheme.primary,
          ),
        );
      }
    }
  }
}
