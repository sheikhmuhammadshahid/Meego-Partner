import 'package:app/models/bookingDetailItemModel.dart';
import 'package:app/models/userModel.dart';

class BookingDetail {
  int vendor_id;
  int id;
  String service_date;
  String service_time;
  String total_price;
  int status;
  String statustext;
  String rem_price;
  String coupon_discount;
  String mobile;
  User user;
  List<BookingDetailItem> items = [];

  BookingDetail();
  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id != null ? vendor_id : null,
        'service_date': service_date != null ? service_date : null,
        'service_time': service_time != null ? service_time : null,
      };

  BookingDetail.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? int.parse('${json['vendor_id']}') : null;
      id = json['id'] != null ? int.parse('${json['id']}') : null;
      status = json['status'] != null ? int.parse('${json['status']}') : null;
      service_date = json['service_date'] != null ? json['service_date'] : null;
      statustext = json['statustext'] != null ? json['statustext'] : null;
      user = (json['user'] != null) ? User.fromJson(json['user']) : null;
      total_price = json['total_price'] != null ? json['total_price'] : null;
      rem_price = json['rem_price'] != null ? json['rem_price'] : null;
      coupon_discount = json['coupon_discount'] != null ? json['coupon_discount'] : null;
      mobile = json['mobile'] != null ? json['mobile'] : null;
    
      service_time = json['service_time'] != null ? json['service_time'] : null;
      items = (json['items'] != null) ? List<BookingDetailItem>.from(json['items'].map((e) => BookingDetailItem.fromJson(e))) : [];
    } catch (e) {
      print("Exception - BookingDetailModel.dart - BookingDetail.fromJson():" + e.toString());
    }
  }
}
