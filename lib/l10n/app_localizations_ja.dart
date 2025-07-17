// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'outshotX';

  @override
  String welcomeMessage(String userName) {
    return 'ようこそ、$userNameさん！';
  }

  @override
  String get enjoyDartsToday => '今日もダーツを楽しみましょう';

  @override
  String get outshot => 'アウトショット';

  @override
  String get outshotGuide => 'ガイドを作成';

  @override
  String get settings => '設定';

  @override
  String get appSettings => 'アプリ設定';

  @override
  String get practice => 'プラクティス';

  @override
  String get scoreCalculation => 'スコア計算と練習';

  @override
  String get statistics => '統計';

  @override
  String get gameRecords => 'ゲーム記録と分析';

  @override
  String get userProfile => 'ユーザープロファイル';

  @override
  String get appearance => '外観';

  @override
  String get language => '言語';

  @override
  String get notifications => '通知';

  @override
  String get sound => 'サウンド';

  @override
  String get dataExport => 'データエクスポート';

  @override
  String get aboutApp => 'アプリについて';

  @override
  String get colorTheme => 'カラーテーマ';

  @override
  String get cancel => 'キャンセル';

  @override
  String get save => '保存';

  @override
  String get edit => '編集';

  @override
  String get back => '戻る';

  @override
  String get remainingScore => '残りスコア';

  @override
  String get scoreInput => 'スコア入力';

  @override
  String get enterScore => '投げたスコアを入力';

  @override
  String get undoLastScore => '前のスコアに戻す';

  @override
  String get gameSettings => 'ゲーム設定';

  @override
  String get resetGame => 'ゲームリセット';

  @override
  String get selectUser => 'ユーザーを選択してください';

  @override
  String get selectUserDescription => '統計データを表示するにはユーザーを選択してください';

  @override
  String get underDevelopment => '開発中です';

  @override
  String get week => '1週間';

  @override
  String get month => '1ヶ月';

  @override
  String get all => '全体';

  @override
  String get overview => '概要';

  @override
  String get finishStatistics => 'フィニッシュ統計';

  @override
  String get practiceHistory => '練習記録';

  @override
  String get gameHistory => 'ゲーム記録';

  @override
  String get charts => 'チャート';

  @override
  String get today => '今日';

  @override
  String get yesterday => '昨日';

  @override
  String daysAgo(int days) {
    return '$days日前';
  }

  @override
  String finishCount(int count) {
    return 'フィニッシュ数';
  }

  @override
  String get dataExportInProgress => 'データエクスポート機能は準備中です';

  @override
  String userId(String id) {
    return 'ID: $id';
  }

  @override
  String get systemLanguage => 'システム設定';

  @override
  String get noUsersFound => 'ユーザーが存在しません';

  @override
  String get manageUsers => 'ユーザーを管理';

  @override
  String get pleaseSelectUserToUseThisFeature => 'この機能を使用するには、まずユーザーを選択してください。';

  @override
  String get selectLanguage => '言語を選択';

  @override
  String get languageChanged => '言語設定を変更しました';

  @override
  String get selectColorTheme => 'カラーテーマを選択';

  @override
  String get editProfile => 'プロフィールを編集';

  @override
  String get name => '名前';

  @override
  String get export => 'エクスポート';

  @override
  String get exportDataConfirmation => 'ユーザーデータと統計情報をエクスポートしますか？';

  @override
  String get light => 'ライト';

  @override
  String get dark => 'ダーク';

  @override
  String get system => 'システム設定';

  @override
  String get finishNotification => 'フィニッシュ達成時の通知';

  @override
  String get soundEffects => '効果音の再生';

  @override
  String get version => 'バージョン';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get termsOfService => '利用規約';

  @override
  String get totalGames => '総ゲーム数';

  @override
  String get practiceSessions => '練習セッション';

  @override
  String get dartsThrown => '投げたダーツ';

  @override
  String get recentPractice => '最近の練習';

  @override
  String get recentGames => '最近のゲーム';

  @override
  String get viewAll => 'すべて見る';

  @override
  String get noPracticeRecords => '練習記録がありません';

  @override
  String get noGameRecords => 'ゲーム記録がありません';

  @override
  String get score => 'スコア';

  @override
  String get darts => 'ダーツ';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours時間$minutes分';
  }

  @override
  String minutesOnly(int minutes) {
    return '$minutes分';
  }

  @override
  String monthDay(int month, int day) {
    return '$month/$day';
  }

  @override
  String get statisticsUnderDevelopment => '統計機能は現在開発中です。\n詳細な統計情報やグラフを\nお楽しみにお待ちください！';

  @override
  String get finishCountLabel => 'フィニッシュ数';

  @override
  String get outshotLabel => 'アウトショット';

  @override
  String get range1To60 => '1-60';

  @override
  String get range61To120 => '61-120';

  @override
  String get range121To180 => '121-180';

  @override
  String get overall => '全体';

  @override
  String get recentPracticeTitle => '最近の練習';

  @override
  String get recentGamesTitle => '最近のゲーム';

  @override
  String dartsAndDuration(int darts, String duration) {
    return '$darts ダーツ • $duration';
  }

  @override
  String scoreAndDarts(int score, int darts) {
    return 'スコア: $score • $darts ダーツ';
  }

  @override
  String get finishCandidates => 'フィニッシュ候補';

  @override
  String get noFinishCandidates => 'フィニッシュ候補なし';

  @override
  String get noFinishCandidatesDescription => 'このスコアのフィニッシュを\nカスタム登録してみましょう';

  @override
  String get gameFinished => 'ゲーム終了！';

  @override
  String get finishPossible => 'フィニッシュ可能';

  @override
  String get finishRange => 'フィニッシュ圏内';

  @override
  String get goodPosition => '良いポジション';

  @override
  String get inProgress => '継続中';

  @override
  String get invalidScore => '無効なスコア';

  @override
  String get invalidScoreMessage => '0から180の間で入力してください。';

  @override
  String get bust => 'バスト！';

  @override
  String get bustMessage => 'スコアが1になるか、0を下回りました。';

  @override
  String get bustQuickMessage => 'このスコアでは1になるか、0を下回ります。';

  @override
  String get ok => 'OK';

  @override
  String get congratulations => 'おめでとうございます！';

  @override
  String get gameFinishedMessage => 'ゲーム終了です！\n新しいゲームを始めますか？';

  @override
  String get end => '終了';

  @override
  String get newGame => '新しいゲーム';

  @override
  String get standardGame => '標準的なゲーム';

  @override
  String get shortGame => 'ショートゲーム';

  @override
  String get longGame => 'ロングゲーム';

  @override
  String get finishWithThis => 'このフィニッシュで上がる';

  @override
  String get practiceUnderDevelopment => 'プラクティス機能は現在開発中です。\nスコア計算と練習機能を\nお楽しみにお待ちください！';

  @override
  String get outshotList => 'アウトショット一覧';

  @override
  String get createNew => '新規作成';

  @override
  String get newOutshotTable => '新しいアウトショットテーブル';

  @override
  String get tableName => 'テーブル名';

  @override
  String get tableNameHint => '例: マイアウトショット';

  @override
  String get selectLabels => 'ラベルを選択:';

  @override
  String get create => '作成';

  @override
  String get editTable => 'テーブルを編集';

  @override
  String get update => '更新';

  @override
  String get deleteTable => 'テーブルを削除';

  @override
  String deleteTableConfirm(String tableName) {
    return '「$tableName」を削除しますか？\nこの操作は取り消せません。';
  }

  @override
  String get delete => '削除';

  @override
  String get searchTableName => 'テーブル名で検索';

  @override
  String get noOutshotTables => 'アウトショットテーブルがありません';

  @override
  String get noOutshotTablesDescription => '「+」ボタンから新しいテーブルを作成してください';

  @override
  String get tableCreated => 'テーブルを作成しました';

  @override
  String get tableUpdated => 'テーブルを更新しました';

  @override
  String get tableDeleted => 'テーブルを削除しました';

  @override
  String createdDate(String date) {
    return '作成日: $date';
  }

  @override
  String get duplicate => '複製';

  @override
  String get doubleOutRoute => 'ダブルアウトルート';

  @override
  String get searchScoreAndDarts => 'スコアやダーツを検索...';

  @override
  String get enterUserName => 'ユーザー名を入力';

  @override
  String get totalCount => '総数';

  @override
  String get maxScore => '最大スコア';

  @override
  String get minScore => '最小スコア';

  @override
  String scoreDetail(int score) {
    return '$score点の詳細';
  }

  @override
  String get description => '説明';

  @override
  String get dartsCount => 'ダーツ数';

  @override
  String get route => 'ルート';

  @override
  String get close => '閉じる';

  @override
  String get outshotTableDuplicatedSuffix => ' (コピー)';
}
