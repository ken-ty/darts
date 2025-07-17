/// アプリの定数を管理するクラス
class AppConstants {
  // プライベートコンストラクタでインスタンス化を防ぐ
  AppConstants._();

  // Notion URL
  static const String privacyPolicyUrlJp =
      'https://resonant-metal-83e.notion.site/230c89f5c11380b9932ac76e974d8479';
  static const String termsOfServiceUrlJp =
      'https://resonant-metal-83e.notion.site/230c89f5c11380b593e6e4757c7fefd9';
  static const String privacyPolicyUrlEn =
      'https://resonant-metal-83e.notion.site/Privacy-Policy-231c89f5c11380a69922f7e1774a54fb';
  static const String termsOfServiceUrlEn =
      'https://resonant-metal-83e.notion.site/Terms-of-Service-231c89f5c11380ff9f99f3511df8d74f';

  // アプリ情報
  static const String appName = 'outshotX';
  static const String appDescription = 'ダーツアウトショットアプリ';

  // デフォルト値
  static const int defaultScore = 301;
  static const int maxScore = 180;

  // アニメーション時間
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);

  // パディング・マージン
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // ボーダー半径
  static const double defaultBorderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 16.0;
}
