class Coupon {
  int VendorId;
  //int coupon_vendor_id;
  int id;
  String Name;
  String Code;
  String Description;
  String StartDate;
  String EndDate;
  String discount;
  String amount;
  String type;
  int usageLimit;
  //int added_by;

  Coupon();
  Map<String, dynamic> toJson() => {
        'VendorId': VendorId,
        'id':id,
        'Name': Name != null ? Name : null,
        'Code': Code != null ? Code : null,
        'Description': Description != null ? Description : null,
        'StartDate': StartDate != null ? StartDate.toString().split(' ')[0] : null,
        'EndDate': EndDate != null ? EndDate.toString().split(' ')[0] : null,
        'discount': discount != null ? discount : null,
        'amount': amount != null ? amount : null,
        'discountType': type != null ? type : null,
        'UsageLimit': usageLimit != null ? usageLimit : null,
      };

  Coupon.fromJson(Map<String, dynamic> json) {
    try {
      VendorId = json['vendorId'] != null ? int.parse('${json['vendorId']}') : null;
      id = json['id'] != null ? int.parse('${json['id']}') : null;
      Name = json['name'] != null ? json['name'] : null;
      Code = json['code'] != null ? json['code'] : null;
      Description = json['description'] != null ? json['description'] : null;
      discount = json['discount'] != null ? json['discount'].toString() : null;
      amount = json['amount'] != null ? json['amount'].toString() : null;
      type = json['discountType'] != null ? json['discountType'] : null;
      usageLimit = json['usageLimit'] != null ? int.parse('${json['usageLimit']}') : null;

      //coupon_vendor_id = json['coupon_vendor_id'] != null ? int.parse('${json['coupon_vendor_id']}') : null;
      StartDate = json['startDate'] != null ? json['startDate'].toString() : null;
      EndDate = json['endDate'] != null ? json['endDate'].toString() : null;
      //added_by = json['added_by'] != null ? int.parse('${json['added_by']}') : null;
    } catch (e) {
      print("Exception - couponModel.dart - couponModel.fromJson():" + e.toString());
    }
  }
}
