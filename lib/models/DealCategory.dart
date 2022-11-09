import 'dart:convert';

class DealCategory {
  int n;
  DealCategory({
    this.n,
  });

  DealCategory copyWith({
    int n,
  }) {
    return DealCategory(
      n: n ?? this.n,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'n': n});

    return result;
  }

  factory DealCategory.fromMap(Map<String, dynamic> map) {
    return DealCategory(
      n: map['n']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DealCategory.fromJson(String source) =>
      DealCategory.fromMap(json.decode(source));

  @override
  String toString() => 'DealCategory(n: $n)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DealCategory && other.n == n;
  }

  @override
  int get hashCode => n.hashCode;
}
