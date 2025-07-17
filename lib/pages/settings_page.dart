import 'dart:io';

import 'package:flutter/material.dart';
import 'package:outshotx/l10n/app_localizations.dart';
import 'package:outshotx/models/outshot/outshot_table.dart';
import 'package:outshotx/services/language_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_constants.dart';
import '../constants/feature_flags.dart';
import '../models/user_profile.dart';
import '../services/app_info_service.dart';
import '../services/outshot_table_service.dart';
import '../services/theme_service.dart';
import '../services/user_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  UserProfile? currentUser;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
    _loadCurrentUser();
  }

  void _loadCurrentUser() {
    setState(() {
      currentUser = UserService.getCurrentUser();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // 現在の言語に応じてPrivacyPolicyのURLを取得
  String _getPrivacyPolicyUrl() {
    final currentLocale = LanguageService.instance.currentLocale;
    if (currentLocale?.languageCode == 'en') {
      return AppConstants.privacyPolicyUrlEn;
    }
    return AppConstants.privacyPolicyUrlJp;
  }

  // 現在の言語に応じてTermsOfServiceのURLを取得
  String _getTermsOfServiceUrl() {
    final currentLocale = LanguageService.instance.currentLocale;
    if (currentLocale?.languageCode == 'en') {
      return AppConstants.termsOfServiceUrlEn;
    }
    return AppConstants.termsOfServiceUrlJp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          AppLocalizations.of(context)?.settings ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (FeatureFlags.enableDataExport) ...[
            IconButton(
              onPressed: _exportData,
              icon: Icon(
                Icons.download,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ],
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Profile Section
                if (currentUser != null) ...[
                  _buildSectionHeader(
                    AppLocalizations.of(context)?.userProfile ?? '',
                  ),
                  const SizedBox(height: 16),
                  _buildUserProfileCard(),
                  const SizedBox(height: 32),
                ],

                // Appearance Section
                if (FeatureFlags.enableThemeSettings) ...[
                  _buildSectionHeader(
                    AppLocalizations.of(context)?.appearance ?? '',
                  ),
                  const SizedBox(height: 16),
                  _buildAppearanceSettings(),
                  const SizedBox(height: 32),
                ],

                // Language Section
                if (FeatureFlags.enableLanguageSettings) ...[
                  _buildSectionHeader(
                    AppLocalizations.of(context)?.language ?? '',
                  ),
                  const SizedBox(height: 16),
                  _buildLanguageSettings(),
                  const SizedBox(height: 32),
                ],

                // Notifications Section
                if (FeatureFlags.enableNotificationSettings) ...[
                  _buildSectionHeader(
                    AppLocalizations.of(context)?.notifications ?? '',
                  ),
                  const SizedBox(height: 16),
                  _buildNotificationSettings(),
                  const SizedBox(height: 32),
                ],

                // Sound Section
                if (FeatureFlags.enableSoundSettings) ...[
                  _buildSectionHeader(
                    AppLocalizations.of(context)?.sound ?? '',
                  ),
                  const SizedBox(height: 16),
                  _buildSoundSettings(),
                  const SizedBox(height: 32),
                ],

                // Data Export Section
                if (FeatureFlags.enableDataExport) ...[
                  _buildSectionHeader(
                    AppLocalizations.of(context)?.dataExport ?? '',
                  ),
                  const SizedBox(height: 16),
                  // _buildDataExportSettings() など、必要なら追加
                  const SizedBox(height: 32),
                ],

                // About Section（常時表示）
                _buildSectionHeader(
                  AppLocalizations.of(context)?.aboutApp ?? '',
                ),
                const SizedBox(height: 16),
                _buildAboutSection(),
                const SizedBox(height: 32),

                // Advanced Section（上級者向け詳細設定）
                _buildAdvancedSection(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildUserProfileCard() {
    if (currentUser == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              currentUser!.name.isNotEmpty
                  ? currentUser!.name[0].toUpperCase()
                  : 'U',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentUser!.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                if (FeatureFlags.enableUserIdDisplay)
                  Text(
                    'ID: ${currentUser!.id}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: _showEditProfileDialog,
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppearanceSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          _buildSettingTile(
            title: AppLocalizations.of(context)?.colorTheme ?? '',
            subtitle: _getColorThemeName(
              currentUser?.colorTheme ?? ColorTheme.system,
            ),
            icon: Icons.palette,
            onTap: _showColorThemeDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSettings() {
    return FutureBuilder<String>(
      future: LanguageService.instance.getCurrentLanguageCode(),
      builder: (context, snapshot) {
        final currentLanguage = snapshot.data ?? 'system';
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: _buildSettingTile(
            title: AppLocalizations.of(context)!.language,
            subtitle: LanguageService.instance.getLanguageName(currentLanguage),
            icon: Icons.language,
            onTap: _showLanguageDialog,
          ),
        );
      },
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: _buildSettingTile(
        title: AppLocalizations.of(context)?.notifications ?? '',
        subtitle: AppLocalizations.of(context)?.finishNotification ?? '',
        icon: Icons.notifications,
        trailing: Switch(
          value: currentUser?.notificationsEnabled ?? true,
          onChanged: _updateNotifications,
        ),
      ),
    );
  }

  Widget _buildSoundSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: _buildSettingTile(
        title: AppLocalizations.of(context)?.sound ?? '',
        subtitle: AppLocalizations.of(context)?.soundEffects ?? '',
        icon: Icons.volume_up,
        trailing: Switch(
          value: currentUser?.soundEnabled ?? true,
          onChanged: _updateSound,
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          _buildSettingTile(
            title: AppLocalizations.of(context)?.version ?? '',
            subtitle: AppInfoService.getFullVersion(),
            icon: Icons.tag,
          ),
          _buildDivider(),
          _buildSettingTile(
            title: AppLocalizations.of(context)?.privacyPolicy ?? '',
            icon: Icons.privacy_tip,
            onTap: () => _launchURL(_getPrivacyPolicyUrl()),
          ),
          _buildDivider(),
          _buildSettingTile(
            title: AppLocalizations.of(context)?.termsOfService ?? '',
            icon: Icons.description,
            onTap: () => _launchURL(_getTermsOfServiceUrl()),
          ),
          _buildDivider(),
          _buildSettingTile(
            title: AppLocalizations.of(context)?.contact ?? '',
            icon: Icons.mail,
            onTap: () => _launchURL(AppConstants.contactFormUrl),
          ),
          _buildDivider(),
          _buildSettingTile(
            title: AppLocalizations.of(context)?.featureRequest ?? '',
            icon: Icons.lightbulb_outline,
            onTap: () => _launchURL(AppConstants.featureRequestFormUrl),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required String title,
    String? subtitle,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            )
          : null,
      trailing:
          trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
      indent: 56,
    );
  }

  String _getColorThemeName(ColorTheme theme) {
    switch (theme) {
      case ColorTheme.light:
        return AppLocalizations.of(context)!.light;
      case ColorTheme.dark:
        return AppLocalizations.of(context)!.dark;
      case ColorTheme.system:
        return AppLocalizations.of(context)!.system;
    }
  }

  String _getLanguageName(Language language) {
    switch (language) {
      case Language.japanese:
        return '日本語';
      case Language.english:
        return 'English';
    }
  }

  void _showColorThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)?.selectColorTheme ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ColorTheme.values.map((theme) {
            return ListTile(
              title: Text(_getColorThemeName(theme)),
              trailing: currentUser?.colorTheme == theme
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () {
                _updateColorTheme(theme);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)?.selectLanguage ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: LanguageService.instance.getSupportedLanguageCodes().map((
            languageCode,
          ) {
            return FutureBuilder<String>(
              future: LanguageService.instance.getCurrentLanguageCode(),
              builder: (context, snapshot) {
                final currentLanguage = snapshot.data ?? 'system';
                return ListTile(
                  title: Text(
                    LanguageService.instance.getLanguageName(languageCode),
                  ),
                  trailing: currentLanguage == languageCode
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                  onTap: () async {
                    await LanguageService.instance.setLanguage(languageCode);
                    Navigator.pop(context);
                  },
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: currentUser?.name ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)?.editProfile ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)?.name ?? '',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)?.cancel ?? ''),
          ),
          FilledButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && currentUser != null) {
                _updateUserName(nameController.text);
                Navigator.pop(context);
              }
            },
            child: Text(AppLocalizations.of(context)?.save ?? ''),
          ),
        ],
      ),
    );
  }

  void _updateColorTheme(ColorTheme theme) async {
    if (currentUser != null) {
      final updatedUser = currentUser!.copyWith(
        colorTheme: theme,
        updatedAt: DateTime.now(),
      );
      await UserService.updateUser(updatedUser);
      setState(() {
        currentUser = updatedUser;
      });

      // テーマを即座に反映
      ThemeService.instance.setTheme(theme);
    }
  }

  void _updateLanguage(Language language) async {
    if (currentUser != null) {
      final updatedUser = currentUser!.copyWith(
        language: language,
        updatedAt: DateTime.now(),
      );
      await UserService.updateUser(updatedUser);
      setState(() {
        currentUser = updatedUser;
      });
    }
  }

  void _updateNotifications(bool enabled) async {
    if (currentUser != null) {
      final updatedUser = currentUser!.copyWith(
        notificationsEnabled: enabled,
        updatedAt: DateTime.now(),
      );
      await UserService.updateUser(updatedUser);
      setState(() {
        currentUser = updatedUser;
      });
    }
  }

  void _updateSound(bool enabled) async {
    if (currentUser != null) {
      final updatedUser = currentUser!.copyWith(
        soundEnabled: enabled,
        updatedAt: DateTime.now(),
      );
      await UserService.updateUser(updatedUser);
      setState(() {
        currentUser = updatedUser;
      });
    }
  }

  void _updateUserName(String name) async {
    if (currentUser != null) {
      final updatedUser = currentUser!.copyWith(
        name: name,
        updatedAt: DateTime.now(),
      );
      await UserService.updateUser(updatedUser);
      setState(() {
        currentUser = updatedUser;
      });
    }
  }

  void _exportData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)?.dataExport ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          AppLocalizations.of(context)?.exportDataConfirmation ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)?.cancel ?? '',
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)?.dataExportInProgress ?? '',
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
            },
            child: Text(
              AppLocalizations.of(context)?.export ?? '',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Widget _buildInitializeAppSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.refresh,
                  color: Theme.of(context).colorScheme.error,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)?.initializeApp ?? '',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(
                              context,
                            )?.initializeAppDescription ??
                            '',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showInitializeAppDialog,
                icon: Icon(
                  Icons.warning,
                  color: Theme.of(context).colorScheme.error,
                ),
                label: Text(
                  AppLocalizations.of(context)?.initialize ?? '',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).colorScheme.error),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInitializeAppDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)?.initializeAppConfirmation ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.warning,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)?.initializeAppWarning ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)?.cancel ?? '',
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await _initializeApp();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(
              AppLocalizations.of(context)?.initialize ?? '',
              style: TextStyle(color: Theme.of(context).colorScheme.onError),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _initializeApp() async {
    try {
      // アプリの全データを削除
      await UserService.clearAllData();

      // 成功メッセージを表示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)?.appInitialized ?? ''),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );

        // ホーム画面に戻る
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      }
    } catch (e) {
      // エラーメッセージを表示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.initializationError(e.toString()) ??
                  e.toString(),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  bool _isAdvancedOpen = false;

  Widget _buildAdvancedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isAdvancedOpen = !_isAdvancedOpen;
            });
          },
          child: Row(
            children: [
              Icon(
                _isAdvancedOpen ? Icons.expand_less : Icons.expand_more,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(width: 8),
              Text(
                '詳細設定（上級者向け）',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 1,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.exportOutshotTable ??
                              '',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(
                                context,
                              )?.exportTableDescription ??
                              '',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.file_upload),
                          label: Text(
                            AppLocalizations.of(context)?.exportTable ?? '',
                          ),
                          onPressed: _showExportOutshotTableDialog,
                        ),
                        const Divider(height: 32),
                        Text(
                          AppLocalizations.of(context)?.importOutshotTable ??
                              '',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(
                                context,
                              )?.importTableDescription ??
                              '',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.file_download),
                          label: Text(
                            AppLocalizations.of(context)?.importTable ?? '',
                          ),
                          onPressed: _importOutshotTable,
                        ),
                        const Divider(height: 32),
                        Text(
                          AppLocalizations.of(context)?.initializeApp ?? '',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(
                                context,
                              )?.initializeAppDescription ??
                              '',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          icon: Icon(
                            Icons.warning,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          label: Text(
                            AppLocalizations.of(context)?.initialize ?? '',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          onPressed: _showInitializeAppDialog,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          crossFadeState: _isAdvancedOpen
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
        ),
      ],
    );
  }

  void _showExportOutshotTableDialog() async {
    final tableService = OutshotTableService();
    final tables = await tableService.getAllTables();
    OutshotTable? selectedTable;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(AppLocalizations.of(context)?.selectTableToExport ?? ''),
          content: DropdownButton<OutshotTable>(
            isExpanded: true,
            value: selectedTable,
            hint: Text(AppLocalizations.of(context)?.selectTable ?? ''),
            items: tables.map((table) {
              return DropdownMenuItem<OutshotTable>(
                value: table,
                child: Text(table.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedTable = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)?.cancel ?? ''),
            ),
            FilledButton(
              onPressed: selectedTable == null
                  ? null
                  : () async {
                      try {
                        final filePath = await tableService.exportTableToFile(
                          selectedTable!,
                        );
                        Navigator.pop(context);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations.of(context)?.exportSuccess ??
                                    '',
                              ),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      } catch (e) {
                        Navigator.pop(context);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${AppLocalizations.of(context)?.importError ?? ''}: $e',
                              ),
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.error,
                            ),
                          );
                        }
                      }
                    },
              child: Text(AppLocalizations.of(context)?.exportTable ?? ''),
            ),
          ],
        ),
      ),
    );
  }

  void _importOutshotTable() async {
    final tableService = OutshotTableService();
    try {
      // インポート可能なファイル一覧を取得
      final files = await tableService.getAvailableImportFiles();

      if (files.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)?.noImportFilesFound ?? '',
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
        return;
      }

      // ファイル選択ダイアログを表示
      final selectedFile = await showDialog<File>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)?.selectImportFile ?? ''),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                final fileName = file.path.split('/').last;
                final lastModified = file.lastModifiedSync();

                return ListTile(
                  title: Text(fileName),
                  subtitle: Text(
                    '${AppLocalizations.of(context)?.lastModifiedLabel ?? ''}: ${lastModified.toString().substring(0, 19)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  leading: const Icon(Icons.file_present),
                  onTap: () => Navigator.pop(context, file),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)?.cancel ?? ''),
            ),
          ],
        ),
      );

      if (selectedFile == null) return;

      // 選択したファイルからインポート
      final importedTable = await tableService.importTableFromFile(
        selectedFile,
      );

      // 同名テーブルが存在する場合は上書き確認
      final exists = await tableService.isTableNameExists(importedTable.name);
      if (exists) {
        final overwrite = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)?.overwriteTable ?? ''),
            content: Text(
              AppLocalizations.of(context)?.overwriteTableWarning ?? '',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(AppLocalizations.of(context)?.cancel ?? ''),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(AppLocalizations.of(context)?.overwrite ?? ''),
              ),
            ],
          ),
        );
        if (overwrite != true) return;
      }

      await tableService.addTable(importedTable);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)?.importSuccess ?? ''),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${AppLocalizations.of(context)?.importError ?? ''}: $e',
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
