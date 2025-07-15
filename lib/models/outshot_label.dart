class OutshotLabel {
  final String id;
  final String name;
  final String color; // hex color code
  final bool isPredefined; // 事前定義済みかどうか
  final DateTime createdAt;

  const OutshotLabel({
    required this.id,
    required this.name,
    required this.color,
    this.isPredefined = false,
    required this.createdAt,
  });

  OutshotLabel copyWith({
    String? id,
    String? name,
    String? color,
    bool? isPredefined,
    DateTime? createdAt,
  }) {
    return OutshotLabel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      isPredefined: isPredefined ?? this.isPredefined,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'isPredefined': isPredefined,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory OutshotLabel.fromJson(Map<String, dynamic> json) {
    return OutshotLabel(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String,
      isPredefined: json['isPredefined'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OutshotLabel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'OutshotLabel(id: $id, name: $name, color: $color, isPredefined: $isPredefined)';
  }
}
