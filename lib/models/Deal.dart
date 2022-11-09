import 'dart:convert';

class Deal {
  int dealCategoryId;
  String name;
  int id;
  String dealCategoryName;
  int discount;
  int discountedAmount;
  bool isActive;
  String creationTime;
  String description;
  int vendorId;
  String startDate;
  String endDate;
  Deal({
    this.dealCategoryId,
    this.name,
    this.id,
    this.dealCategoryName,
    this.discount,
    this.discountedAmount,
    this.isActive,
    this.creationTime,
    this.description,
    this.vendorId,
    this.startDate,
    this.endDate,
  });

  Deal copyWith({
    int dealCategoryId,
    String name,
    int id,
    String dealCategoryName,
    int discount,
    int discountedAmount,
    bool isActive,
    String creationTime,
    String description,
    int vendorId,
    String startDate,
    String endDate,
  }) {
    return Deal(
      dealCategoryId: dealCategoryId ?? this.dealCategoryId,
      name: name ?? this.name,
      id: id ?? this.id,
      dealCategoryName: dealCategoryName ?? this.dealCategoryName,
      discount: discount ?? this.discount,
      discountedAmount: discountedAmount ?? this.discountedAmount,
      isActive: isActive ?? this.isActive,
      creationTime: creationTime ?? this.creationTime,
      description: description ?? this.description,
      vendorId: vendorId ?? this.vendorId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'dealCategoryId': dealCategoryId});
    result.addAll({'name': name});
    result.addAll({'id': id});
    result.addAll({'dealCategoryName': dealCategoryName});
    result.addAll({'discount': discount});
    result.addAll({'discountedAmount': discountedAmount});
    result.addAll({'isActive': isActive});
    result.addAll({'creationTime': creationTime});
    result.addAll({'description': description});
    result.addAll({'vendorId': vendorId});
    result.addAll({'startDate': startDate});
    result.addAll({'endDate': endDate});

    return result;
  }

  factory Deal.fromMap(Map<String, dynamic> map) {
    return Deal(
      dealCategoryId: map['dealCategoryId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
      dealCategoryName: map['dealCategoryName'] ?? '',
      discount: map['discount']?.toInt() ?? 0,
      discountedAmount: map['discountedAmount']?.toInt() ?? 0,
      isActive: map['isActive'] ?? false,
      creationTime: map['creationTime'] ?? '',
      description: map['description'] ?? '',
      vendorId: map['vendorId']?.toInt() ?? 0,
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Deal.fromJson(String source) => Deal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Deal(dealCategoryId: $dealCategoryId, name: $name, id: $id, dealCategoryName: $dealCategoryName, discount: $discount, discountedAmount: $discountedAmount, isActive: $isActive, creationTime: $creationTime, description: $description, vendorId: $vendorId, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Deal &&
        other.dealCategoryId == dealCategoryId &&
        other.name == name &&
        other.id == id &&
        other.dealCategoryName == dealCategoryName &&
        other.discount == discount &&
        other.discountedAmount == discountedAmount &&
        other.isActive == isActive &&
        other.creationTime == creationTime &&
        other.description == description &&
        other.vendorId == vendorId &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return dealCategoryId.hashCode ^
        name.hashCode ^
        id.hashCode ^
        dealCategoryName.hashCode ^
        discount.hashCode ^
        discountedAmount.hashCode ^
        isActive.hashCode ^
        creationTime.hashCode ^
        description.hashCode ^
        vendorId.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}
