import 'finish_combination.dart';

enum Language { japanese, english }

enum ColorTheme { light, dark, system, dartsLive }

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
    );
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
