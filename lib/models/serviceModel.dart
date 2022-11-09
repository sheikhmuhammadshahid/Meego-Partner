import 'package:app/models/serviceVariantModel.dart';
import 'package:intl/intl.dart';

class Service {
  static int toCheckCouponId = 0;
  int vendor_id;
  String service_name;
  String service_image;
  int service_id;
  String rate;
  int couponId;
  String categoryId;
  String description;
  String Time;
  bool isChecked = false;
  DateTime createdAt;
  List<ServiceVariant> varients = [];
  DateFormat formate = DateFormat("yyyy-MM-dd HH:mm:ss");
  Service();
  Map<String, dynamic> toJson() => {
        'venderId': vendor_id != null ? vendor_id : null,
        'serviceId': service_id != null ? service_id : null,
        'serviceTitle': service_name != null ? service_name : null,
        'serviceImage': service_image != null ? service_image : null,
      };

  Service.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id =
          json['venderId'] != null ? int.parse('${json['venderId']}') : null;
      service_id =
          json['serviceId'] != null ? int.parse('${json['serviceId']}') : null;
      service_name = json['serviceTitle'] != null ? json['serviceTitle'] : null;
      service_image =
          json['serviceImage'] != null ? json['serviceImage'] : null;
      varients =
          []; //(json['varients'] != null) ? List<ServiceVariant>.from(json['varients'].map((e) => ServiceVariant.fromJson(e))) : [];
      Time = json['serviceTime'] != null ? json['serviceTime'] : null;
      rate = json['serviceRate'] != null ? json['serviceRate'] : null;
      createdAt = json['creationTime'] != null
          ? DateTime.parse(json['creationTime'])
          : null;
      couponId = json['couponId'] != null
          ? int.parse(json['couponId'].toString())
          : null;
      if (couponId != null) {
        if (toCheckCouponId == couponId) {
          isChecked = true;
        }
      }
      categoryId =
          json['categoryId'] != null ? json['categoryId'].toString() : null;

      description = json['description'] != null ? json['description'] : null;
    } catch (e) {
      print("Exception - serviceModel.dart - serviceModel.fromJson():" +
          e.toString());
    }
  }
}
