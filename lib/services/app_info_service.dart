import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService {
  static PackageInfo? _packageInfo;

  /// アプリのバージョン情報を初期化
  static Future<void> initialize() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  /// アプリのバージョンを取得
  static String getVersion() {
    return _packageInfo?.version ?? '0.0.0';
  }

  /// アプリのビルド番号を取得
  static String getBuildNumber() {
    return _packageInfo?.buildNumber ?? '0';
  }

  /// アプリのパッケージ名を取得
  static String getPackageName() {
    return _packageInfo?.packageName ?? '';
  }

  /// アプリの名前を取得
  static String getAppName() {
    return _packageInfo?.appName ?? '';
  }

  /// 完全なバージョン文字列を取得 (例: "1.0.0+1")
  static String getFullVersion() {
    final version = getVersion();
    final buildNumber = getBuildNumber();
    return buildNumber != '0' ? '$version+$buildNumber' : version;
  }

  /// バージョン情報が初期化されているかチェック
  static bool get isInitialized => _packageInfo != null;
}
