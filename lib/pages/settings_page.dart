import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../services/app_info_service.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          '設定',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _exportData,
            icon: Icon(
              Icons.download,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          IconButton(
            onPressed: _showHelp,
            icon: Icon(
              Icons.help_outline,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
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
                  _buildSectionHeader('ユーザープロファイル'),
                  const SizedBox(height: 16),
                  _buildUserProfileCard(),
                  const SizedBox(height: 32),
                ],

                // Appearance Section
                _buildSectionHeader('外観'),
                const SizedBox(height: 16),
                _buildAppearanceSettings(),
                const SizedBox(height: 32),

                // Language Section
                _buildSectionHeader('言語'),
                const SizedBox(height: 16),
                _buildLanguageSettings(),
                const SizedBox(height: 32),

                // Notifications Section
                _buildSectionHeader('通知'),
                const SizedBox(height: 16),
                _buildNotificationSettings(),
                const SizedBox(height: 32),

                // Sound Section
                _buildSectionHeader('サウンド'),
                const SizedBox(height: 16),
                _buildSoundSettings(),
                const SizedBox(height: 32),

                // About Section
                _buildSectionHeader('アプリについて'),
                const SizedBox(height: 16),
                _buildAboutSection(),
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
            title: 'カラーテーマ',
            subtitle: _getColorThemeName(
              currentUser?.colorTheme ?? ColorTheme.system,
            ),
            icon: Icons.palette,
            onTap: _showColorThemeDialog,
          ),
          _buildDivider(),
          _buildSettingTile(
            title: 'ダークモード',
            subtitle: 'システム設定に従う',
            icon: Icons.dark_mode,
            trailing: Switch(
              value: currentUser?.colorTheme == ColorTheme.dark,
              onChanged: (value) => _updateColorTheme(
                value ? ColorTheme.dark : ColorTheme.system,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: _buildSettingTile(
        title: '言語',
        subtitle: _getLanguageName(currentUser?.language ?? Language.japanese),
        icon: Icons.language,
        onTap: _showLanguageDialog,
      ),
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
        title: '通知',
        subtitle: 'フィニッシュ達成時の通知',
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
        title: 'サウンド',
        subtitle: '効果音の再生',
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
            title: 'バージョン',
            subtitle: AppInfoService.getFullVersion(),
            icon: Icons.tag,
          ),
          _buildDivider(),
          _buildSettingTile(
            title: 'プライバシーポリシー',
            subtitle: '個人情報の取り扱いについて',
            icon: Icons.privacy_tip,
            onTap: () {
              // TODO: プライバシーポリシーページを開く
            },
          ),
          _buildDivider(),
          _buildSettingTile(
            title: '利用規約',
            subtitle: 'アプリの利用条件',
            icon: Icons.description,
            onTap: () {
              // TODO: 利用規約ページを開く
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required String title,
    required String subtitle,
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
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
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
        return 'ライト';
      case ColorTheme.dark:
        return 'ダーク';
      case ColorTheme.system:
        return 'システム設定';
      case ColorTheme.dartsLive:
        return 'DARTS LIVE';
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
          'カラーテーマを選択',
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
          '言語を選択',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: Language.values.map((language) {
            return ListTile(
              title: Text(_getLanguageName(language)),
              trailing: currentUser?.language == language
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () {
                _updateLanguage(language);
                Navigator.pop(context);
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
          'プロフィールを編集',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: '名前',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && currentUser != null) {
                _updateUserName(nameController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('保存'),
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
          'データエクスポート',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'ユーザーデータと統計情報をエクスポートしますか？',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'キャンセル',
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          FilledButton(
            onPressed: () {
              // TODO: データエクスポート機能を実装
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('データエクスポート機能は準備中です'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
            },
            child: Text(
              'エクスポート',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }

  void _showHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'ヘルプ',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'アプリの使い方',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '• アウトショット: 1-180の上がり方を確認\n'
              '• プラクティス: スコア計算と練習\n'
              '• 統計: 練習記録とゲーム記録を確認\n'
              '• 設定: アプリの設定を変更',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
