/// アプリの定数を管理するクラス
class AppConstants {
  // プライベートコンストラクタでインスタンス化を防ぐ
  AppConstants._();

  // Notion URL
  static const String privacyPolicyUrl =
      'https://www.notion.so/230c89f5c11380b9932ac76e974d8479';
  static const String termsOfServiceUrl =
      'https://www.notion.so/230c89f5c11380b593e6e4757c7fefd9';

  // アプリ情報
  static const String appName = 'outshotX';
  static const String appDescription = 'ダーツアウトショットアプリ';

  // デフォルト値
  static const int defaultScore = 501;
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
