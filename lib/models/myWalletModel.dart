import 'package:app/models/shareSendPendingModel.dart';

class MyWallet {
  double toPay=0;
  double total_price=0;
  double toGet=0;

  MyWallet();

  MyWallet.fromJson(Map<String, dynamic> json) {
    try {
      total_price = json['totalEarning'] != null ? double.parse(json['totalEarning'].toString()) : 0.0;
      toGet = json['vendorRemaining'] != null ? double.parse(json['vendorRemaining'].toString()) : 0.0;
      toPay = json['companyRemaing'] != null ? double.parse(json['companyRemaing'].toString()) : 0.0;
      } catch (e) {
      print("Exception - MyWalletModel.dart - MyWallet.fromJson():" + e.toString());
    }
  }
}
