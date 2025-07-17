import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'outshotX'**
  String get appTitle;

  /// Welcome message on home
  ///
  /// In en, this message translates to:
  /// **'Welcome, {userName}!'**
  String welcomeMessage(String userName);

  /// No description provided for @enjoyDartsToday.
  ///
  /// In en, this message translates to:
  /// **'Let\'s enjoy darts today!'**
  String get enjoyDartsToday;

  /// No description provided for @outshot.
  ///
  /// In en, this message translates to:
  /// **'Outshot'**
  String get outshot;

  /// No description provided for @outshotGuide.
  ///
  /// In en, this message translates to:
  /// **'Create Guide'**
  String get outshotGuide;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @practice.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get practice;

  /// No description provided for @scoreCalculation.
  ///
  /// In en, this message translates to:
  /// **'Score Calculation & Practice'**
  String get scoreCalculation;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @gameRecords.
  ///
  /// In en, this message translates to:
  /// **'Game Records & Analysis'**
  String get gameRecords;

  /// No description provided for @userProfile.
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get userProfile;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// No description provided for @dataExport.
  ///
  /// In en, this message translates to:
  /// **'Data Export'**
  String get dataExport;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @colorTheme.
  ///
  /// In en, this message translates to:
  /// **'Color Theme'**
  String get colorTheme;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @remainingScore.
  ///
  /// In en, this message translates to:
  /// **'Remaining Score'**
  String get remainingScore;

  /// No description provided for @scoreInput.
  ///
  /// In en, this message translates to:
  /// **'Score Input'**
  String get scoreInput;

  /// No description provided for @enterScore.
  ///
  /// In en, this message translates to:
  /// **'Enter your score'**
  String get enterScore;

  /// No description provided for @undoLastScore.
  ///
  /// In en, this message translates to:
  /// **'Undo Last Score'**
  String get undoLastScore;

  /// No description provided for @gameSettings.
  ///
  /// In en, this message translates to:
  /// **'Game Settings'**
  String get gameSettings;

  /// No description provided for @resetGame.
  ///
  /// In en, this message translates to:
  /// **'Reset Game'**
  String get resetGame;

  /// No description provided for @selectUser.
  ///
  /// In en, this message translates to:
  /// **'Please select a user'**
  String get selectUser;

  /// No description provided for @selectUserDescription.
  ///
  /// In en, this message translates to:
  /// **'Select a user to display statistics data'**
  String get selectUserDescription;

  /// No description provided for @underDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Under Development'**
  String get underDevelopment;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'1 Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'1 Month'**
  String get month;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @finishStatistics.
  ///
  /// In en, this message translates to:
  /// **'Finish Statistics'**
  String get finishStatistics;

  /// No description provided for @practiceHistory.
  ///
  /// In en, this message translates to:
  /// **'Practice History'**
  String get practiceHistory;

  /// No description provided for @gameHistory.
  ///
  /// In en, this message translates to:
  /// **'Game History'**
  String get gameHistory;

  /// No description provided for @charts.
  ///
  /// In en, this message translates to:
  /// **'Charts'**
  String get charts;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// Display how many days ago
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String daysAgo(int days);

  /// Display number of finishes
  ///
  /// In en, this message translates to:
  /// **'Finish Count'**
  String finishCount(int count);

  /// No description provided for @dataExportInProgress.
  ///
  /// In en, this message translates to:
  /// **'Data export feature is in preparation'**
  String get dataExportInProgress;

  /// Display user ID
  ///
  /// In en, this message translates to:
  /// **'ID: {id}'**
  String userId(String id);

  /// No description provided for @systemLanguage.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemLanguage;

  /// No description provided for @noUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No users found'**
  String get noUsersFound;

  /// No description provided for @manageUsers.
  ///
  /// In en, this message translates to:
  /// **'Manage Users'**
  String get manageUsers;

  /// No description provided for @pleaseSelectUserToUseThisFeature.
  ///
  /// In en, this message translates to:
  /// **'Please select a user first to use this feature.'**
  String get pleaseSelectUserToUseThisFeature;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @languageChanged.
  ///
  /// In en, this message translates to:
  /// **'Language settings changed'**
  String get languageChanged;

  /// No description provided for @selectColorTheme.
  ///
  /// In en, this message translates to:
  /// **'Select Color Theme'**
  String get selectColorTheme;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @exportDataConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Export user data and statistics?'**
  String get exportDataConfirmation;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @finishNotification.
  ///
  /// In en, this message translates to:
  /// **'Finish achievement notifications'**
  String get finishNotification;

  /// No description provided for @soundEffects.
  ///
  /// In en, this message translates to:
  /// **'Sound effects playback'**
  String get soundEffects;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @totalGames.
  ///
  /// In en, this message translates to:
  /// **'Total Games'**
  String get totalGames;

  /// No description provided for @practiceSessions.
  ///
  /// In en, this message translates to:
  /// **'Practice Sessions'**
  String get practiceSessions;

  /// No description provided for @dartsThrown.
  ///
  /// In en, this message translates to:
  /// **'Darts Thrown'**
  String get dartsThrown;

  /// No description provided for @recentPractice.
  ///
  /// In en, this message translates to:
  /// **'Recent Practice'**
  String get recentPractice;

  /// No description provided for @recentGames.
  ///
  /// In en, this message translates to:
  /// **'Recent Games'**
  String get recentGames;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @noPracticeRecords.
  ///
  /// In en, this message translates to:
  /// **'No practice records'**
  String get noPracticeRecords;

  /// No description provided for @noGameRecords.
  ///
  /// In en, this message translates to:
  /// **'No game records'**
  String get noGameRecords;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @darts.
  ///
  /// In en, this message translates to:
  /// **'darts'**
  String get darts;

  /// Display hours and minutes
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String hoursMinutes(int hours, int minutes);

  /// Display minutes only
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String minutesOnly(int minutes);

  /// Display month/day
  ///
  /// In en, this message translates to:
  /// **'{month}/{day}'**
  String monthDay(int month, int day);

  /// No description provided for @statisticsUnderDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Statistics feature is currently under development.\nDetailed statistics and graphs\ncoming soon!'**
  String get statisticsUnderDevelopment;

  /// No description provided for @finishCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Finish Count'**
  String get finishCountLabel;

  /// No description provided for @outshotLabel.
  ///
  /// In en, this message translates to:
  /// **'Outshot'**
  String get outshotLabel;

  /// No description provided for @range1To60.
  ///
  /// In en, this message translates to:
  /// **'1-60'**
  String get range1To60;

  /// No description provided for @range61To120.
  ///
  /// In en, this message translates to:
  /// **'61-120'**
  String get range61To120;

  /// No description provided for @range121To180.
  ///
  /// In en, this message translates to:
  /// **'121-180'**
  String get range121To180;

  /// No description provided for @overall.
  ///
  /// In en, this message translates to:
  /// **'Overall'**
  String get overall;

  /// No description provided for @recentPracticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent Practice'**
  String get recentPracticeTitle;

  /// No description provided for @recentGamesTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent Games'**
  String get recentGamesTitle;

  /// Display darts count and duration
  ///
  /// In en, this message translates to:
  /// **'{darts} darts • {duration}'**
  String dartsAndDuration(int darts, String duration);

  /// Display score and darts count
  ///
  /// In en, this message translates to:
  /// **'Score: {score} • {darts} darts'**
  String scoreAndDarts(int score, int darts);

  /// No description provided for @finishCandidates.
  ///
  /// In en, this message translates to:
  /// **'Finish Candidates'**
  String get finishCandidates;

  /// No description provided for @noFinishCandidates.
  ///
  /// In en, this message translates to:
  /// **'No Finish Candidates'**
  String get noFinishCandidates;

  /// No description provided for @noFinishCandidatesDescription.
  ///
  /// In en, this message translates to:
  /// **'Try registering a custom finish\nfor this score'**
  String get noFinishCandidatesDescription;

  /// No description provided for @gameFinished.
  ///
  /// In en, this message translates to:
  /// **'Game Finished!'**
  String get gameFinished;

  /// No description provided for @finishPossible.
  ///
  /// In en, this message translates to:
  /// **'Finish Possible'**
  String get finishPossible;

  /// No description provided for @finishRange.
  ///
  /// In en, this message translates to:
  /// **'In Finish Range'**
  String get finishRange;

  /// No description provided for @goodPosition.
  ///
  /// In en, this message translates to:
  /// **'Good Position'**
  String get goodPosition;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @invalidScore.
  ///
  /// In en, this message translates to:
  /// **'Invalid Score'**
  String get invalidScore;

  /// No description provided for @invalidScoreMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a score between 0 and 180.'**
  String get invalidScoreMessage;

  /// No description provided for @bust.
  ///
  /// In en, this message translates to:
  /// **'Bust!'**
  String get bust;

  /// No description provided for @bustMessage.
  ///
  /// In en, this message translates to:
  /// **'Score becomes 1 or goes below 0.'**
  String get bustMessage;

  /// No description provided for @bustQuickMessage.
  ///
  /// In en, this message translates to:
  /// **'This score would become 1 or go below 0.'**
  String get bustQuickMessage;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// No description provided for @gameFinishedMessage.
  ///
  /// In en, this message translates to:
  /// **'Game finished!\nStart a new game?'**
  String get gameFinishedMessage;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @newGame.
  ///
  /// In en, this message translates to:
  /// **'New Game'**
  String get newGame;

  /// No description provided for @standardGame.
  ///
  /// In en, this message translates to:
  /// **'Standard Game'**
  String get standardGame;

  /// No description provided for @shortGame.
  ///
  /// In en, this message translates to:
  /// **'Short Game'**
  String get shortGame;

  /// No description provided for @longGame.
  ///
  /// In en, this message translates to:
  /// **'Long Game'**
  String get longGame;

  /// No description provided for @finishWithThis.
  ///
  /// In en, this message translates to:
  /// **'Finish with this'**
  String get finishWithThis;

  /// No description provided for @practiceUnderDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Practice feature is currently under development.\nScore calculation and practice features\ncoming soon!'**
  String get practiceUnderDevelopment;

  /// No description provided for @outshotList.
  ///
  /// In en, this message translates to:
  /// **'Outshot List'**
  String get outshotList;

  /// No description provided for @createNew.
  ///
  /// In en, this message translates to:
  /// **'Create New'**
  String get createNew;

  /// No description provided for @newOutshotTable.
  ///
  /// In en, this message translates to:
  /// **'New Outshot Table'**
  String get newOutshotTable;

  /// No description provided for @tableName.
  ///
  /// In en, this message translates to:
  /// **'Table Name'**
  String get tableName;

  /// No description provided for @tableNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. My Outshot'**
  String get tableNameHint;

  /// No description provided for @selectLabels.
  ///
  /// In en, this message translates to:
  /// **'Select Labels:'**
  String get selectLabels;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @editTable.
  ///
  /// In en, this message translates to:
  /// **'Edit Table'**
  String get editTable;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @deleteTable.
  ///
  /// In en, this message translates to:
  /// **'Delete Table'**
  String get deleteTable;

  /// Table deletion confirmation message
  ///
  /// In en, this message translates to:
  /// **'Delete \"{tableName}\"?\nThis action cannot be undone.'**
  String deleteTableConfirm(String tableName);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @searchTableName.
  ///
  /// In en, this message translates to:
  /// **'Search by table name'**
  String get searchTableName;

  /// No description provided for @noOutshotTables.
  ///
  /// In en, this message translates to:
  /// **'No outshot tables'**
  String get noOutshotTables;

  /// No description provided for @noOutshotTablesDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a new table using the \"+\" button'**
  String get noOutshotTablesDescription;

  /// No description provided for @tableCreated.
  ///
  /// In en, this message translates to:
  /// **'Table created'**
  String get tableCreated;

  /// No description provided for @tableUpdated.
  ///
  /// In en, this message translates to:
  /// **'Table updated'**
  String get tableUpdated;

  /// No description provided for @tableDeleted.
  ///
  /// In en, this message translates to:
  /// **'Table deleted'**
  String get tableDeleted;

  /// Display creation date
  ///
  /// In en, this message translates to:
  /// **'Created: {date}'**
  String createdDate(String date);

  /// No description provided for @duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicate;

  /// No description provided for @doubleOutRoute.
  ///
  /// In en, this message translates to:
  /// **'Double Out Route'**
  String get doubleOutRoute;

  /// No description provided for @searchScoreAndDarts.
  ///
  /// In en, this message translates to:
  /// **'Search by score or darts...'**
  String get searchScoreAndDarts;

  /// No description provided for @enterUserName.
  ///
  /// In en, this message translates to:
  /// **'Enter user name'**
  String get enterUserName;

  /// No description provided for @totalCount.
  ///
  /// In en, this message translates to:
  /// **'Total Count'**
  String get totalCount;

  /// No description provided for @maxScore.
  ///
  /// In en, this message translates to:
  /// **'Max Score'**
  String get maxScore;

  /// No description provided for @minScore.
  ///
  /// In en, this message translates to:
  /// **'Min Score'**
  String get minScore;

  /// Score detail dialog title
  ///
  /// In en, this message translates to:
  /// **'{score} Point Detail'**
  String scoreDetail(int score);

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @dartsCount.
  ///
  /// In en, this message translates to:
  /// **'Darts Count'**
  String get dartsCount;

  /// No description provided for @route.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get route;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @outshotTableDuplicatedSuffix.
  ///
  /// In en, this message translates to:
  /// **' (Copy)'**
  String get outshotTableDuplicatedSuffix;

  /// No description provided for @duplicateEntry.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicateEntry;

  /// No description provided for @addEntry.
  ///
  /// In en, this message translates to:
  /// **'Add Entry'**
  String get addEntry;

  /// No description provided for @editEntry.
  ///
  /// In en, this message translates to:
  /// **'Edit Entry'**
  String get editEntry;

  /// No description provided for @combination.
  ///
  /// In en, this message translates to:
  /// **'Combination'**
  String get combination;

  /// No description provided for @combinationHint.
  ///
  /// In en, this message translates to:
  /// **'1st, 2nd, 3rd (comma separated)'**
  String get combinationHint;

  /// No description provided for @deleteEntry.
  ///
  /// In en, this message translates to:
  /// **'Delete Confirmation'**
  String get deleteEntry;

  /// No description provided for @deleteEntryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this entry?'**
  String get deleteEntryConfirm;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @featureRequest.
  ///
  /// In en, this message translates to:
  /// **'Feature Request'**
  String get featureRequest;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
