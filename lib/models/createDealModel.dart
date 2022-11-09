import 'dart:convert';
import 'dart:core';

class CreateDealModel {
  int vendorId;
  int dealId;
  String name;
  int dealCategoryId;
  String description;
  String startDate;
  String endDate;
  double discount;
  CreateDealModel({
    this.vendorId,
    this.dealId,
    this.name,
    this.dealCategoryId,
    this.description,
    this.startDate,
    this.endDate,
    this.discount,
  });

  CreateDealModel copyWith({
    int vendorId,
    int dealId,
    String name,
    int dealCategoryId,
    String description,
    String startDate,
    String endDate,
    double discount,
  }) {
    return CreateDealModel(
      vendorId: vendorId ?? this.vendorId,
      dealId: dealId ?? this.dealId,
      name: name ?? this.name,
      dealCategoryId: dealCategoryId ?? this.dealCategoryId,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'vendorId': vendorId});
    result.addAll({'dealId': dealId});
    result.addAll({'name': name});
    result.addAll({'dealCategoryId': dealCategoryId});
    result.addAll({'description': description});
    result.addAll({'startDate': startDate});
    result.addAll({'endDate': endDate});
    result.addAll({'discount': discount});

    return result;
  }

  factory CreateDealModel.fromMap(Map<String, dynamic> map) {
    return CreateDealModel(
      vendorId: map['vendorId']?.toInt() ?? 0,
      dealId: map['dealId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      dealCategoryId: map['dealCategoryId']?.toInt() ?? 0,
      description: map['description'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      discount: map['discount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateDealModel.fromJson(String source) =>
      CreateDealModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateDealModel(vendorId: $vendorId, dealId: $dealId, name: $name, dealCategoryId: $dealCategoryId, description: $description, startDate: $startDate, endDate: $endDate, discount: $discount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateDealModel &&
        other.vendorId == vendorId &&
        other.dealId == dealId &&
        other.name == name &&
        other.dealCategoryId == dealCategoryId &&
        other.description == description &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.discount == discount;
  }

  @override
  int get hashCode {
    return vendorId.hashCode ^
        dealId.hashCode ^
        name.hashCode ^
        dealCategoryId.hashCode ^
        description.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        discount.hashCode;
  }
}
