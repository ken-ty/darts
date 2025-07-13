import 'finish_combination.dart';

class UserProfile {
  final String id;
  final String name;
  final Map<int, FinishCombination> finishBoard;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.name,
    required this.finishBoard,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'finishBoard': finishBoard.map((key, value) => MapEntry(key.toString(), value.toJson())),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      finishBoard: (json['finishBoard'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          int.parse(key),
          FinishCombination.fromJson(value),
        ),
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  UserProfile copyWith({
    String? id,
    String? name,
    Map<int, FinishCombination>? finishBoard,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      finishBoard: finishBoard ?? this.finishBoard,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, name: $name, finishBoard: ${finishBoard.length} combinations, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserProfile &&
        other.id == id &&
        other.name == name &&
        _mapEquals(other.finishBoard, finishBoard) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        finishBoard.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  bool _mapEquals(Map<int, FinishCombination> a, Map<int, FinishCombination> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || a[key] != b[key]) return false;
    }
    return true;
  }
}