import 'dart:convert';

import 'package:app/models/chartDataModel.dart';

class HomePage {
  int vendor_id;
  int allOrders=0;
  int pendingOrders=0;
  int completedOrders=0;
  List<ChartData> weeklyEarning=[];
  int unread_notification_count=0;
  int read_notification_count=0;
  double completedGloals=0;

  HomePage();
  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id != null ? vendor_id : null,
      };

  HomePage.fromJson(Map<String, dynamic> j) {
    try {
      //vendor_id = j['vendor_id'] != null ? int.parse('${j['vendor_id']}') : null;
      allOrders = j['total'] != null ? int.parse('${j['total']}') : 0;
      pendingOrders = j['pending'] != null ? int.parse('${j['pending']}') : 0;
      completedOrders = j['completed'] != null ? int.parse('${j['completed']}') : 0;
      //weeklyEarning.add(ChartData.fromJson(j['weeklyEarnings']));
      //var cmap=json.decode(j['weeklyEarnings']);
      for(var c in j['weeklyEarnings'])
      {
        ChartData v=ChartData.fromJson(c);
        weeklyEarning.add(v);

      }
      unread_notification_count = j['unread_notification_count'] != null ? int.parse('${j['unread_notification_count']}') : 0;
      read_notification_count = j['read_notification_count'] != null ? int.parse('${j['read_notification_count']}') : 0;
      completedGloals = allOrders != 0 ? (completedOrders * 100) / (completedOrders+pendingOrders) : 0;
    } catch (e) {
      print("Exception - HomePageModel.dart - HomePageModel.fromJson():" + e.toString());
    }
  }
}
