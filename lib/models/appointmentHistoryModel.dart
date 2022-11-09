import 'dart:convert';

import 'package:app/models/businessLayer/global.dart';
import 'package:app/models/userModel.dart';

class AppointmentHistory {
  int serviceId;
  int id;
  String paymentMethod;
  String serviceImage;
  String serviceTitle;
  String customerName;
  String customerImage;
  String phoneP;
  String phoneS;
  String emailP;
  String emailS;
  String discountedPrice;
  String serviceDate;
  String serviceTime;
  String totalPrice;
  int status;
  String statustext;
  String time;
  AppointmentHistory({
    this.serviceId,
    this.id,
    this.paymentMethod,
    this.serviceImage,
    this.serviceTitle,
    this.customerName,
    this.customerImage,
    this.phoneP,
    this.phoneS,
    this.emailP,
    this.emailS,
    this.discountedPrice,
    this.serviceDate,
    this.serviceTime,
    this.totalPrice,
    this.status,
    this.statustext,
    this.time,
  });
  User user = User();

  AppointmentHistory copyWith({
    int serviceId,
    int id,
    String paymentMethod,
    String serviceImage,
    String serviceTitle,
    String customerName,
    String customerImage,
    String phoneP,
    String phoneS,
    String emailP,
    String emailS,
    String discountedPrice,
    String serviceDate,
    String serviceTime,
    String totalPrice,
    int status,
    String statustext,
    String time,
  }) {
    return AppointmentHistory(
      serviceId: serviceId ?? this.serviceId,
      id: id ?? this.id,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      serviceImage: serviceImage ?? this.serviceImage,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      customerName: customerName ?? this.customerName,
      customerImage: customerImage ?? this.customerImage,
      phoneP: phoneP ?? this.phoneP,
      phoneS: phoneS ?? this.phoneS,
      emailP: emailP ?? this.emailP,
      emailS: emailS ?? this.emailS,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      serviceDate: serviceDate ?? this.serviceDate,
      serviceTime: serviceTime ?? this.serviceTime,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      statustext: statustext ?? this.statustext,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'serviceId': serviceId});
    result.addAll({'id': id});
    result.addAll({'paymentMethod': paymentMethod});
    result.addAll({'serviceImage': serviceImage});
    result.addAll({'serviceTitle': serviceTitle});
    result.addAll({'customerName': customerName});
    result.addAll({'customerImage': customerImage});
    result.addAll({'phoneP': phoneP});
    result.addAll({'phoneS': phoneS});
    result.addAll({'emailP': emailP});
    result.addAll({'emailS': emailS});
    result.addAll({'discountedPrice': discountedPrice});
    result.addAll({'serviceDate': serviceDate});
    result.addAll({'serviceTime': serviceTime});
    result.addAll({'totalPrice': totalPrice});
    result.addAll({'status': status});
    result.addAll({'statustext': statustext});
    result.addAll({'time': time});

    return result;
  }

  factory AppointmentHistory.fromMap(Map<String, dynamic> map) {
    return AppointmentHistory(
      serviceId: map['serviceId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      paymentMethod: map['paymentMethod'] ?? '',
      serviceImage: map['serviceImage'] ?? '',
      serviceTitle: map['serviceTitle'] ?? '',
      customerName: map['customerName'] ?? '',
      customerImage: map['customerImage'] ?? '',
      phoneP: map['phoneP'] ?? '',
      phoneS: map['phoneS'] ?? '',
      emailP: map['emailP'] ?? '',
      emailS: map['emailS'] ?? '',
      discountedPrice: map['discountedPrice'] ?? '',
      serviceDate: map['serviceDate'] ?? '',
      serviceTime: map['serviceTime'] ?? '',
      totalPrice: map['totalPrice'] ?? '',
      status: map['status']?.toInt() ?? 0,
      statustext: map['statustext'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentHistory.fromJson(String source) =>
      AppointmentHistory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppointmentHistory(serviceId: $serviceId, id: $id, paymentMethod: $paymentMethod, serviceImage: $serviceImage, serviceTitle: $serviceTitle, customerName: $customerName, customerImage: $customerImage, phoneP: $phoneP, phoneS: $phoneS, emailP: $emailP, emailS: $emailS, discountedPrice: $discountedPrice, serviceDate: $serviceDate, serviceTime: $serviceTime, totalPrice: $totalPrice, status: $status, statustext: $statustext, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppointmentHistory &&
        other.serviceId == serviceId &&
        other.id == id &&
        other.paymentMethod == paymentMethod &&
        other.serviceImage == serviceImage &&
        other.serviceTitle == serviceTitle &&
        other.customerName == customerName &&
        other.customerImage == customerImage &&
        other.phoneP == phoneP &&
        other.phoneS == phoneS &&
        other.emailP == emailP &&
        other.emailS == emailS &&
        other.discountedPrice == discountedPrice &&
        other.serviceDate == serviceDate &&
        other.serviceTime == serviceTime &&
        other.totalPrice == totalPrice &&
        other.status == status &&
        other.statustext == statustext &&
        other.time == time;
  }

  @override
  int get hashCode {
    return serviceId.hashCode ^
        id.hashCode ^
        paymentMethod.hashCode ^
        serviceImage.hashCode ^
        serviceTitle.hashCode ^
        customerName.hashCode ^
        customerImage.hashCode ^
        phoneP.hashCode ^
        phoneS.hashCode ^
        emailP.hashCode ^
        emailS.hashCode ^
        discountedPrice.hashCode ^
        serviceDate.hashCode ^
        serviceTime.hashCode ^
        totalPrice.hashCode ^
        status.hashCode ^
        statustext.hashCode ^
        time.hashCode;
  }
}
