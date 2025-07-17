// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'outshotX';

  @override
  String welcomeMessage(String userName) {
    return 'Welcome, $userName!';
  }

  @override
  String get enjoyDartsToday => 'Let\'s enjoy darts today!';

  @override
  String get outshot => 'Outshot';

  @override
  String get outshotGuide => 'Create Guide';

  @override
  String get settings => 'Settings';

  @override
  String get appSettings => 'App Settings';

  @override
  String get practice => 'Practice';

  @override
  String get scoreCalculation => 'Score Calculation & Practice';

  @override
  String get statistics => 'Statistics';

  @override
  String get gameRecords => 'Game Records & Analysis';

  @override
  String get userProfile => 'User Profile';

  @override
  String get appearance => 'Appearance';

  @override
  String get language => 'Language';

  @override
  String get notifications => 'Notifications';

  @override
  String get sound => 'Sound';

  @override
  String get dataExport => 'Data Export';

  @override
  String get aboutApp => 'About App';

  @override
  String get colorTheme => 'Color Theme';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get back => 'Back';

  @override
  String get remainingScore => 'Remaining Score';

  @override
  String get scoreInput => 'Score Input';

  @override
  String get enterScore => 'Enter your score';

  @override
  String get undoLastScore => 'Undo Last Score';

  @override
  String get gameSettings => 'Game Settings';

  @override
  String get resetGame => 'Reset Game';

  @override
  String get selectUser => 'Please select a user';

  @override
  String get selectUserDescription => 'Select a user to display statistics data';

  @override
  String get underDevelopment => 'Under Development';

  @override
  String get week => '1 Week';

  @override
  String get month => '1 Month';

  @override
  String get all => 'All';

  @override
  String get overview => 'Overview';

  @override
  String get finishStatistics => 'Finish Statistics';

  @override
  String get practiceHistory => 'Practice History';

  @override
  String get gameHistory => 'Game History';

  @override
  String get charts => 'Charts';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String daysAgo(int days) {
    return '$days days ago';
  }

  @override
  String finishCount(int count) {
    return 'Finish Count';
  }

  @override
  String get dataExportInProgress => 'Data export feature is in preparation';

  @override
  String userId(String id) {
    return 'ID: $id';
  }

  @override
  String get systemLanguage => 'System';

  @override
  String get noUsersFound => 'No users found';

  @override
  String get manageUsers => 'Manage Users';

  @override
  String get pleaseSelectUserToUseThisFeature => 'Please select a user first to use this feature.';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get languageChanged => 'Language settings changed';

  @override
  String get selectColorTheme => 'Select Color Theme';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get name => 'Name';

  @override
  String get export => 'Export';

  @override
  String get exportDataConfirmation => 'Export user data and statistics?';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get finishNotification => 'Finish achievement notifications';

  @override
  String get soundEffects => 'Sound effects playback';

  @override
  String get version => 'Version';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get totalGames => 'Total Games';

  @override
  String get practiceSessions => 'Practice Sessions';

  @override
  String get dartsThrown => 'Darts Thrown';

  @override
  String get recentPractice => 'Recent Practice';

  @override
  String get recentGames => 'Recent Games';

  @override
  String get viewAll => 'View All';

  @override
  String get noPracticeRecords => 'No practice records';

  @override
  String get noGameRecords => 'No game records';

  @override
  String get score => 'Score';

  @override
  String get darts => 'darts';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String minutesOnly(int minutes) {
    return '${minutes}m';
  }

  @override
  String monthDay(int month, int day) {
    return '$month/$day';
  }

  @override
  String get statisticsUnderDevelopment => 'Statistics feature is currently under development.\nDetailed statistics and graphs\ncoming soon!';

  @override
  String get finishCountLabel => 'Finish Count';

  @override
  String get outshotLabel => 'Outshot';

  @override
  String get range1To60 => '1-60';

  @override
  String get range61To120 => '61-120';

  @override
  String get range121To180 => '121-180';

  @override
  String get overall => 'Overall';

  @override
  String get recentPracticeTitle => 'Recent Practice';

  @override
  String get recentGamesTitle => 'Recent Games';

  @override
  String dartsAndDuration(int darts, String duration) {
    return '$darts darts • $duration';
  }

  @override
  String scoreAndDarts(int score, int darts) {
    return 'Score: $score • $darts darts';
  }

  @override
  String get defaultUserName => 'Default User';

  @override
  String get initializeApp => 'Initialize App';

  @override
  String get initializeAppDescription => 'Delete all data and reset the app to its initial state';

  @override
  String get initializeAppConfirmation => 'Initialize the app?';

  @override
  String get initializeAppWarning => 'This action will delete all data including registered users, outshot tables, settings, etc. This action cannot be undone.';

  @override
  String get initialize => 'Initialize';

  @override
  String get exportOutshotTable => 'Export Outshot Table';

  @override
  String get importOutshotTable => 'Import Outshot Table';

  @override
  String get exportTableDescription => 'Export outshot table as JSON file';

  @override
  String get importTableDescription => 'Import outshot table from JSON file';

  @override
  String get exportTable => 'Export Table';

  @override
  String get importTable => 'Import Table';

  @override
  String get selectTableToExport => 'Select table to export';

  @override
  String get exportSuccess => 'Export completed';

  @override
  String get importSuccess => 'Import completed';

  @override
  String get importError => 'Error occurred during import';

  @override
  String get invalidFileFormat => 'Invalid file format';

  @override
  String get tableAlreadyExists => 'Table with same name already exists';

  @override
  String get overwriteTable => 'Overwrite table?';

  @override
  String get overwriteTableWarning => 'Existing table will be overwritten. This action cannot be undone.';

  @override
  String get overwrite => 'Overwrite';

  @override
  String get finishCandidates => 'Finish Candidates';

  @override
  String get noFinishCandidates => 'No Finish Candidates';

  @override
  String get noFinishCandidatesDescription => 'Try registering a custom finish\nfor this score';

  @override
  String get gameFinished => 'Game Finished!';

  @override
  String get finishPossible => 'Finish Possible';

  @override
  String get finishRange => 'In Finish Range';

  @override
  String get goodPosition => 'Good Position';

  @override
  String get inProgress => 'In Progress';

  @override
  String get invalidScore => 'Invalid Score';

  @override
  String get invalidScoreMessage => 'Please enter a score between 0 and 180.';

  @override
  String get bust => 'Bust!';

  @override
  String get bustMessage => 'Score becomes 1 or goes below 0.';

  @override
  String get bustQuickMessage => 'This score would become 1 or go below 0.';

  @override
  String get ok => 'OK';

  @override
  String get congratulations => 'Congratulations!';

  @override
  String get gameFinishedMessage => 'Game finished!\nStart a new game?';

  @override
  String get end => 'End';

  @override
  String get newGame => 'New Game';

  @override
  String get standardGame => 'Standard Game';

  @override
  String get shortGame => 'Short Game';

  @override
  String get longGame => 'Long Game';

  @override
  String get finishWithThis => 'Finish with this';

  @override
  String get practiceUnderDevelopment => 'Practice feature is currently under development.\nScore calculation and practice features\ncoming soon!';

  @override
  String get outshotList => 'Outshot List';

  @override
  String get createNew => 'Create New';

  @override
  String get newOutshotTable => 'New Outshot Table';

  @override
  String get tableName => 'Table Name';

  @override
  String get tableNameHint => 'e.g. My Outshot';

  @override
  String get selectLabels => 'Select Labels:';

  @override
  String get create => 'Create';

  @override
  String get editTable => 'Edit Table';

  @override
  String get update => 'Update';

  @override
  String get deleteTable => 'Delete Table';

  @override
  String deleteTableConfirm(String tableName) {
    return 'Delete \"$tableName\"?\nThis action cannot be undone.';
  }

  @override
  String get delete => 'Delete';

  @override
  String get searchTableName => 'Search by table name';

  @override
  String get noOutshotTables => 'No outshot tables';

  @override
  String get noOutshotTablesDescription => 'Create a new table using the \"+\" button';

  @override
  String get tableCreated => 'Table created';

  @override
  String get tableUpdated => 'Table updated';

  @override
  String get tableDeleted => 'Table deleted';

  @override
  String createdDate(String date) {
    return 'Created: $date';
  }

  @override
  String get duplicate => 'Duplicate';

  @override
  String get doubleOutRoute => 'Double Out Route';

  @override
  String get searchScoreAndDarts => 'Search by score or darts...';

  @override
  String get enterUserName => 'Enter user name';

  @override
  String get totalCount => 'Total Count';

  @override
  String get maxScore => 'Max Score';

  @override
  String get minScore => 'Min Score';

  @override
  String scoreDetail(int score) {
    return '$score Point Detail';
  }

  @override
  String get description => 'Description';

  @override
  String get dartsCount => 'Darts Count';

  @override
  String get route => 'Route';

  @override
  String get close => 'Close';

  @override
  String get outshotTableDuplicatedSuffix => ' (Copy)';

  @override
  String get duplicateEntry => 'Duplicate';

  @override
  String get addEntry => 'Add Entry';

  @override
  String get editEntry => 'Edit Entry';

  @override
  String get combination => 'Combination';

  @override
  String get combinationHint => '1st, 2nd, 3rd (comma separated)';

  @override
  String get deleteEntry => 'Delete Confirmation';

  @override
  String get deleteEntryConfirm => 'Delete this entry?';

  @override
  String get contact => 'Contact';

  @override
  String get featureRequest => 'Feature Request';

  @override
  String get selectImportFile => 'Select file to import';

  @override
  String get noImportFilesFound => 'No importable files found';

  @override
  String lastModified(String date) {
    return 'Last modified: $date';
  }

  @override
  String importFileInfo(String fileName) {
    return 'File name: $fileName';
  }

  @override
  String importFileCount(int count) {
    return 'Entry count: $count';
  }

  @override
  String get saveImportedTable => 'Save this table?';

  @override
  String get lastModifiedLabel => 'Last Modified';

  @override
  String get appInitialized => 'App has been initialized';

  @override
  String get selectTable => 'Select table';

  @override
  String initializationError(String error) {
    return 'Error occurred during initialization: $error';
  }
}
