import 'finish_combination.dart';

class OutshotSet {
  final String id;
  final String name;
  final List<FinishCombination> combinations;
  final DateTime createdAt;

  OutshotSet({
    required this.id,
    required this.name,
    required this.combinations,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'combinations': combinations.map((c) => c.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
  };

  factory OutshotSet.fromJson(Map<String, dynamic> json) => OutshotSet(
    id: json['id'],
    name: json['name'],
    combinations: (json['combinations'] as List)
        .map((e) => FinishCombination.fromJson(e))
        .toList(),
    createdAt: DateTime.parse(json['createdAt']),
  );
}
