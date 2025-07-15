/// 機能フラグを管理するクラス
///
/// 開発中や不具合がある機能を無効化するためのフラグ
class FeatureFlags {
  // プライベートコンストラクタでインスタンス化を防ぐ
  FeatureFlags._();

  // 設定項目の機能フラグ
  static const bool enableSoundSettings = false; // サウンド設定を無効化
  static const bool enableNotificationSettings = false; // 通知設定を有効化
  static const bool enableLanguageSettings = true; // 言語設定を有効化
  static const bool enableThemeSettings = true; // テーマ設定を有効化
  static const bool enableDataExport = false; // データエクスポートを無効化

  // 機能の機能フラグ
  static const bool enableStatistics = false; // 統計機能を無効化（開発中）
  static const bool enablePractice = false; // プラクティス機能を無効化（開発中）
  static const bool enablePracticeHistory = true; // 練習履歴を有効化
  static const bool enableGameHistory = true; // ゲーム履歴を有効化
  static const bool enableCharts = true; // チャート機能を有効化
  static const bool enableOutShotDetailSummary = false;

  // 開発用フラグ
  static const bool enableDebugMode = false; // デバッグモードを無効化
  static const bool enableAnalytics = false; // アナリティクスを無効化
  // ユーザーID表示制御
  static const bool enableUserIdDisplay = false; // ユーザーID表示を有効化
  // ユーザー管理機能の表示制御
  static const bool enableUserManagement = false; // ユーザー管理機能を有効化
}
