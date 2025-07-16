import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:outshotx/l10n/app_localizations.dart';

class UnderDevelopmentOverlay extends StatelessWidget {
  final Widget backgroundContent;
  final String title;
  final String description;
  final Color primaryColor;
  final Color secondaryColor;
  final double progressPercentage;
  final String progressText;
  final VoidCallback? onBackPressed;

  const UnderDevelopmentOverlay({
    super.key,
    required this.backgroundContent,
    required this.title,
    required this.description,
    required this.primaryColor,
    required this.secondaryColor,
    required this.progressPercentage,
    required this.progressText,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 背景コンテンツ（ぼかし効果付き）
        Opacity(
          opacity: 0.6,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: backgroundContent,
          ),
        ),
        // 開発中メッセージ
        Center(
          child: Container(
            margin: const EdgeInsets.all(32),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: primaryColor.withValues(alpha: 0.2),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // アニメーション付きアイコン
                TweenAnimationBuilder<double>(
                  duration: const Duration(seconds: 2),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: value * 2 * 3.14159,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              primaryColor.withValues(alpha: 0.1),
                              secondaryColor.withValues(alpha: 0.1),
                            ],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.construction,
                          size: 48,
                          color: primaryColor,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                // タイトル
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // 説明文
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // プログレスバー
                Container(
                  width: 200,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(seconds: 3),
                    tween: Tween(begin: 0.0, end: progressPercentage),
                    builder: (context, value, child) {
                      return FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: value,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [primaryColor, secondaryColor],
                            ),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // 進捗テキスト
                Text(
                  progressText,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 32),
                // 戻るボタン
                FilledButton.icon(
                  onPressed: onBackPressed ?? () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back),
                  label: Text(AppLocalizations.of(context)?.back ?? ''),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
