import 'finish_combination.dart';

enum Language { japanese, english }

enum ColorTheme { light, dark, system, dartsLive }

class GameRecord {
  final String id;
  final String gameType; // '501', '301', 'cricket' など
  final int score;
  final int dartsThrown;
  final DateTime playedAt;
  final Map<String, dynamic> details;

  GameRecord({
    required this.id,
    required this.gameType,
    required this.score,
    required this.dartsThrown,
    required this.playedAt,
    this.details = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gameType': gameType,
      'score': score,
      'dartsThrown': dartsThrown,
      'playedAt': playedAt.toIso8601String(),
      'details': details,
    };
  }

  factory GameRecord.fromJson(Map<String, dynamic> json) {
    return GameRecord(
      id: json['id'],
      gameType: json['gameType'],
      score: json['score'],
      dartsThrown: json['dartsThrown'],
      playedAt: DateTime.parse(json['playedAt']),
      details: json['details'] ?? {},
    );
  }

  GameRecord copyWith({
    String? id,
    String? gameType,
    int? score,
    int? dartsThrown,
    DateTime? playedAt,
    Map<String, dynamic>? details,
  }) {
    return GameRecord(
      id: id ?? this.id,
      gameType: gameType ?? this.gameType,
      score: score ?? this.score,
      dartsThrown: dartsThrown ?? this.dartsThrown,
      playedAt: playedAt ?? this.playedAt,
      details: details ?? this.details,
    );
  }
}

class PracticeSession {
  final String id;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String focus; // 'finish', 'scoring', 'accuracy' など
  final int dartsThrown;
  final Map<String, int> targets; // ターゲット別のスコア
  final Map<String, dynamic> notes;

  PracticeSession({
    required this.id,
    required this.startedAt,
    this.endedAt,
    required this.focus,
    required this.dartsThrown,
    this.targets = const {},
    this.notes = const {},
  });

  Duration get duration {
    final end = endedAt ?? DateTime.now();
    return end.difference(startedAt);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startedAt': startedAt.toIso8601String(),
      'endedAt': endedAt?.toIso8601String(),
      'focus': focus,
      'dartsThrown': dartsThrown,
      'targets': targets,
      'notes': notes,
    };
  }

  factory PracticeSession.fromJson(Map<String, dynamic> json) {
    return PracticeSession(
      id: json['id'],
      startedAt: DateTime.parse(json['startedAt']),
      endedAt: json['endedAt'] != null ? DateTime.parse(json['endedAt']) : null,
      focus: json['focus'],
      dartsThrown: json['dartsThrown'],
      targets: Map<String, int>.from(json['targets'] ?? {}),
      notes: json['notes'] ?? {},
    );
  }

  PracticeSession copyWith({
    String? id,
    DateTime? startedAt,
    DateTime? endedAt,
    String? focus,
    int? dartsThrown,
    Map<String, int>? targets,
    Map<String, dynamic>? notes,
  }) {
    return PracticeSession(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      focus: focus ?? this.focus,
      dartsThrown: dartsThrown ?? this.dartsThrown,
      targets: targets ?? this.targets,
      notes: notes ?? this.notes,
    );
  }
}

class UserProfile {
  final String id;
  final String name;
  final Map<int, FinishCombination> finishBoard;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Language language;
  final ColorTheme colorTheme;
  final bool notificationsEnabled;
  final bool soundEnabled;
  final String? avatarUrl;
  final Map<String, dynamic> preferences;
  final List<GameRecord> gameRecords;
  final List<PracticeSession> practiceSessions;

  UserProfile({
    required this.id,
    required this.name,
    required this.finishBoard,
    required this.createdAt,
    required this.updatedAt,
    this.language = Language.japanese,
    this.colorTheme = ColorTheme.system,
    this.notificationsEnabled = true,
    this.soundEnabled = true,
    this.avatarUrl,
    this.preferences = const {},
    this.gameRecords = const [],
    this.practiceSessions = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'finishBoard': finishBoard.map(
        (key, value) => MapEntry(key.toString(), value.toJson()),
      ),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'language': language.name,
      'colorTheme': colorTheme.name,
      'notificationsEnabled': notificationsEnabled,
      'soundEnabled': soundEnabled,
      'avatarUrl': avatarUrl,
      'preferences': preferences,
      'gameRecords': gameRecords.map((record) => record.toJson()).toList(),
      'practiceSessions': practiceSessions
          .map((session) => session.toJson())
          .toList(),
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      finishBoard: (json['finishBoard'] as Map<String, dynamic>).map(
        (key, value) =>
            MapEntry(int.parse(key), FinishCombination.fromJson(value)),
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      language: Language.values.firstWhere(
        (e) => e.name == (json['language'] ?? 'japanese'),
        orElse: () => Language.japanese,
      ),
      colorTheme: ColorTheme.values.firstWhere(
        (e) => e.name == (json['colorTheme'] ?? 'system'),
        orElse: () => ColorTheme.system,
      ),
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      soundEnabled: json['soundEnabled'] ?? true,
      avatarUrl: json['avatarUrl'],
      preferences: json['preferences'] ?? {},
      gameRecords: (json['gameRecords'] as List<dynamic>? ?? [])
          .map((record) => GameRecord.fromJson(record))
          .toList(),
      practiceSessions: (json['practiceSessions'] as List<dynamic>? ?? [])
          .map((session) => PracticeSession.fromJson(session))
          .toList(),
    );
  }

  UserProfile copyWith({
    String? id,
    String? name,
    Map<int, FinishCombination>? finishBoard,
    DateTime? createdAt,
    DateTime? updatedAt,
    Language? language,
    ColorTheme? colorTheme,
    bool? notificationsEnabled,
    bool? soundEnabled,
    String? avatarUrl,
    Map<String, dynamic>? preferences,
    List<GameRecord>? gameRecords,
    List<PracticeSession>? practiceSessions,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      finishBoard: finishBoard ?? this.finishBoard,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      language: language ?? this.language,
      colorTheme: colorTheme ?? this.colorTheme,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      preferences: preferences ?? this.preferences,
      gameRecords: gameRecords ?? this.gameRecords,
      practiceSessions: practiceSessions ?? this.practiceSessions,
    );
  }

  // 統計メソッド
  int get totalGamesPlayed => gameRecords.length;

  int get totalPracticeSessions => practiceSessions.length;

  int get totalDartsThrown {
    final gameDarts = gameRecords.fold<int>(
      0,
      (sum, record) => sum + record.dartsThrown,
    );
    final practiceDarts = practiceSessions.fold<int>(
      0,
      (sum, session) => sum + session.dartsThrown,
    );
    return gameDarts + practiceDarts;
  }

  double get averageScore {
    if (gameRecords.isEmpty) return 0;
    final totalScore = gameRecords.fold<int>(
      0,
      (sum, record) => sum + record.score,
    );
    return totalScore / gameRecords.length;
  }

  int get finishCombinationsCount => finishBoard.length;

  List<GameRecord> get recentGames {
    final sorted = List<GameRecord>.from(gameRecords);
    sorted.sort((a, b) => b.playedAt.compareTo(a.playedAt));
    return sorted.take(10).toList();
  }

  List<PracticeSession> get recentPracticeSessions {
    final sorted = List<PracticeSession>.from(practiceSessions);
    sorted.sort((a, b) => b.startedAt.compareTo(a.startedAt));
    return sorted.take(10).toList();
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, name: $name, finishBoard: ${finishBoard.length} combinations, createdAt: $createdAt, updatedAt: $updatedAt, language: $language, colorTheme: $colorTheme)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserProfile &&
        other.id == id &&
        other.name == name &&
        _mapEquals(other.finishBoard, finishBoard) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.language == language &&
        other.colorTheme == colorTheme &&
        other.notificationsEnabled == notificationsEnabled &&
        other.soundEnabled == soundEnabled &&
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        finishBoard.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        language.hashCode ^
        colorTheme.hashCode ^
        notificationsEnabled.hashCode ^
        soundEnabled.hashCode ^
        avatarUrl.hashCode;
  }

  bool _mapEquals(
    Map<int, FinishCombination> a,
    Map<int, FinishCombination> b,
  ) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || a[key] != b[key]) return false;
    }
    return true;
  }
}
