class Order {
  int order_id=1;
  String name="Shahid";
  String image=null;
  String total_price="1000";
  String payment_gateway="paypal";
  String payment_status="Pending";
  Order();

  Map<String, dynamic> toJson() => {'order_id': order_id, 'name': name != null ? name : null, 'image': image != null ? image : null};

  Order.fromJson(Map<String, dynamic> json) {
    try {
      order_id = json['order_id'] != null ? int.parse('${json['order_id']}') : null;
      name = json['name'] != null ? json['name'] : null;
      image = json['image'] != null ? json['image'] : null;
      total_price = json['total_price'] != null ? json['total_price'] : null;
      payment_gateway = json['payment_gateway'] != null ? json['payment_gateway'] : null;
      payment_status = json['payment_status'] != null ? json['payment_status'] : null;

    } catch (e) {
      print("Exception - OrderModel.dart - Order.fromJson():" + e.toString());
    }
  }
}
