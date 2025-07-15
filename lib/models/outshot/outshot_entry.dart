/// [Outshot] に含まれる1つのエントリー
class OutshotEntry {
  final int score;
  final List<String> combination;
  final String description;

  const OutshotEntry({
    required this.score,
    required this.combination,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'combination': combination,
      'description': description,
    };
  }

  factory OutshotEntry.fromJson(Map<String, dynamic> json) {
    return OutshotEntry(
      score: json['score'],
      combination: List<String>.from(json['combination']),
      description: json['description'],
    );
  }

  OutshotEntry copyWith({
    int? score,
    List<String>? combination,
    String? description,
  }) {
    return OutshotEntry(
      score: score ?? this.score,
      combination: combination ?? this.combination,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'Outshot(score: $score, combination: $combination, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OutshotEntry &&
        other.score == score &&
        _listEquals(other.combination, combination) &&
        other.description == description;
  }

  @override
  int get hashCode {
    return score.hashCode ^ combination.hashCode ^ description.hashCode;
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
