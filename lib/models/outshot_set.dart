import 'outshot.dart';

class OutshotSet {
  final String id;
  final String name;
  final List<String> labelIds;
  final List<OutShot> combinations;
  final DateTime createdAt;

  OutshotSet({
    required this.id,
    required this.name,
    required this.labelIds,
    required this.combinations,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'labelIds': labelIds,
    'combinations': combinations.map((c) => c.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
  };

  factory OutshotSet.fromJson(Map<String, dynamic> json) => OutshotSet(
    id: json['id'],
    name: json['name'],
    labelIds: (json['labelIds'] as List).map((e) => e as String).toList(),
    combinations: (json['combinations'] as List)
        .map((e) => OutShot.fromJson(e))
        .toList(),
    createdAt: DateTime.parse(json['createdAt']),
  );
}
