import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:app/models/DealServicesModel.dart';

import 'Deal.dart';

class Offers {
  List<DealServicesModel> services = [];
  List<Deal> dealCategories = [];
  Offers({
    this.services,
    this.dealCategories,
  });

  Offers copyWith({
    List<DealServicesModel> services,
    List<Deal> dealCategories,
  }) {
    return Offers(
      services: services ?? this.services,
      dealCategories: dealCategories ?? this.dealCategories,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'services': services.map((x) => x.toMap()).toList()});
    result.addAll(
        {'dealCategories': dealCategories.map((x) => x.toMap()).toList()});

    return result;
  }

  factory Offers.fromMap(Map<String, dynamic> map) {
    return Offers(
      services: List<DealServicesModel>.from(
          map['services']?.map((x) => DealServicesModel.fromMap(x))),
      dealCategories:
          List<Deal>.from(map['dealCategories']?.map((x) => Deal.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Offers.fromJson(String source) => Offers.fromMap(json.decode(source));

  @override
  String toString() =>
      'Offers(services: $services, dealCategories: $dealCategories)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Offers &&
        listEquals(other.services, services) &&
        listEquals(other.dealCategories, dealCategories);
  }

  @override
  int get hashCode => services.hashCode ^ dealCategories.hashCode;
}
