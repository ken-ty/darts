class OutShot {
  final int score;
  final int dartsNeeded;
  final List<String> combination;
  final String description;
  final bool isFinishRoute;

  const OutShot({
    required this.score,
    required this.dartsNeeded,
    required this.combination,
    required this.description,
    this.isFinishRoute = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'dartsNeeded': dartsNeeded,
      'combination': combination,
      'description': description,
      'isFinishRoute': isFinishRoute,
    };
  }

  factory OutShot.fromJson(Map<String, dynamic> json) {
    return OutShot(
      score: json['score'],
      dartsNeeded: json['dartsNeeded'],
      combination: List<String>.from(json['combination']),
      description: json['description'],
      isFinishRoute: json['isFinishRoute'] ?? true,
    );
  }

  OutShot copyWith({
    int? score,
    int? dartsNeeded,
    List<String>? combination,
    String? description,
    bool? isFinishRoute,
  }) {
    return OutShot(
      score: score ?? this.score,
      dartsNeeded: dartsNeeded ?? this.dartsNeeded,
      combination: combination ?? this.combination,
      description: description ?? this.description,
      isFinishRoute: isFinishRoute ?? this.isFinishRoute,
    );
  }

  @override
  String toString() {
    return 'OutShot(score: $score, dartsNeeded: $dartsNeeded, combination: $combination, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OutShot &&
        other.score == score &&
        other.dartsNeeded == dartsNeeded &&
        _listEquals(other.combination, combination) &&
        other.description == description &&
        other.isFinishRoute == isFinishRoute;
  }

  @override
  int get hashCode {
    return score.hashCode ^
        dartsNeeded.hashCode ^
        combination.hashCode ^
        description.hashCode ^
        isFinishRoute.hashCode;
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
