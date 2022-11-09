import 'dart:convert';

class DealServicesModel {
  int id;
  String dealName;

  int categoryId;
  int dealCategoryId;
  int serviceId;
  String serviceTitle;
  String dealCategoryName;
  String description;

  String serviceImage;

  String serviceTime;
  String serviceRate;

  String vendorLocation;
  int venderRating;
  int discountedAmount;
  int discountedRate;
  DealServicesModel({
    this.id,
    this.dealName,
    this.categoryId,
    this.dealCategoryId,
    this.serviceId,
    this.serviceTitle,
    this.dealCategoryName,
    this.description,
    this.serviceImage,
    this.serviceTime,
    this.serviceRate,
    this.vendorLocation,
    this.venderRating,
    this.discountedAmount,
    this.discountedRate,
  });

  DealServicesModel copyWith({
    int id,
    String dealName,
    int categoryId,
    int dealCategoryId,
    int serviceId,
    String serviceTitle,
    String dealCategoryName,
    String description,
    String serviceImage,
    String serviceTime,
    String serviceRate,
    String vendorLocation,
    int venderRating,
    int discountedAmount,
    int discountedRate,
  }) {
    return DealServicesModel(
      id: id ?? this.id,
      dealName: dealName ?? this.dealName,
      categoryId: categoryId ?? this.categoryId,
      dealCategoryId: dealCategoryId ?? this.dealCategoryId,
      serviceId: serviceId ?? this.serviceId,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      dealCategoryName: dealCategoryName ?? this.dealCategoryName,
      description: description ?? this.description,
      serviceImage: serviceImage ?? this.serviceImage,
      serviceTime: serviceTime ?? this.serviceTime,
      serviceRate: serviceRate ?? this.serviceRate,
      vendorLocation: vendorLocation ?? this.vendorLocation,
      venderRating: venderRating ?? this.venderRating,
      discountedAmount: discountedAmount ?? this.discountedAmount,
      discountedRate: discountedRate ?? this.discountedRate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'dealName': dealName});
    result.addAll({'categoryId': categoryId});
    result.addAll({'dealCategoryId': dealCategoryId});
    result.addAll({'serviceId': serviceId});
    result.addAll({'serviceTitle': serviceTitle});
    result.addAll({'dealCategoryName': dealCategoryName});
    result.addAll({'description': description});
    result.addAll({'serviceImage': serviceImage});
    result.addAll({'serviceTime': serviceTime});
    result.addAll({'serviceRate': serviceRate});
    result.addAll({'vendorLocation': vendorLocation});
    result.addAll({'venderRating': venderRating});
    result.addAll({'discountedAmount': discountedAmount});
    result.addAll({'discountedRate': discountedRate});

    return result;
  }

  factory DealServicesModel.fromMap(Map<String, dynamic> map) {
    return DealServicesModel(
      id: map['id']?.toInt() ?? 0,
      dealName: map['dealName'] ?? '',
      categoryId: map['categoryId']?.toInt() ?? 0,
      dealCategoryId: map['dealCategoryId']?.toInt() ?? 0,
      serviceId: map['serviceId']?.toInt() ?? 0,
      serviceTitle: map['serviceTitle'] ?? '',
      dealCategoryName: map['dealCategoryName'] ?? '',
      description: map['description'] ?? '',
      serviceImage: map['serviceImage'] ?? '',
      serviceTime: map['serviceTime'] ?? '',
      serviceRate: map['serviceRate'] ?? '',
      vendorLocation: map['vendorLocation'] ?? '',
      venderRating: map['venderRating']?.toInt() ?? 0,
      discountedAmount: map['discountedAmount']?.toInt() ?? 0,
      discountedRate: map['discountedRate']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DealServicesModel.fromJson(String source) =>
      DealServicesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DealServicesModel(id: $id, dealName: $dealName, categoryId: $categoryId, dealCategoryId: $dealCategoryId, serviceId: $serviceId, serviceTitle: $serviceTitle, dealCategoryName: $dealCategoryName, description: $description, serviceImage: $serviceImage, serviceTime: $serviceTime, serviceRate: $serviceRate, vendorLocation: $vendorLocation, venderRating: $venderRating, discountedAmount: $discountedAmount, discountedRate: $discountedRate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DealServicesModel &&
        other.id == id &&
        other.dealName == dealName &&
        other.categoryId == categoryId &&
        other.dealCategoryId == dealCategoryId &&
        other.serviceId == serviceId &&
        other.serviceTitle == serviceTitle &&
        other.dealCategoryName == dealCategoryName &&
        other.description == description &&
        other.serviceImage == serviceImage &&
        other.serviceTime == serviceTime &&
        other.serviceRate == serviceRate &&
        other.vendorLocation == vendorLocation &&
        other.venderRating == venderRating &&
        other.discountedAmount == discountedAmount &&
        other.discountedRate == discountedRate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dealName.hashCode ^
        categoryId.hashCode ^
        dealCategoryId.hashCode ^
        serviceId.hashCode ^
        serviceTitle.hashCode ^
        dealCategoryName.hashCode ^
        description.hashCode ^
        serviceImage.hashCode ^
        serviceTime.hashCode ^
        serviceRate.hashCode ^
        vendorLocation.hashCode ^
        venderRating.hashCode ^
        discountedAmount.hashCode ^
        discountedRate.hashCode;
  }
}
