import 'package:flutter/material.dart';

class VendorTiming {
  int vendor_id;
  int status;
  String days;
  String open_hour;
  String close_hour;
  int time_slot_id;

  VendorTiming();
 // Map<String, dynamic> toJson() => {'vendor_id': vendor_id != null ? vendor_id : null, 'status': status != null ? status : null, 'days': days != null ? days : null, 'time_slot_id': time_slot_id != null ? time_slot_id : null};
/*

  VendorTiming.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? int.parse('${json['vendor_id']}') : null;
      status = json['status'] != null ? int.parse('${json['status']}') : null;
      time_slot_id = json['time_slot_id'] != null ? int.parse('${json['time_slot_id']}') : null;
      days = json['days'] != null ? json['days'] : null;
      if (json['open_hour'] != null) {
        List<String> _tTimeList = json['open_hour'].toString().split(":");
        int hr = int.parse(_tTimeList[0]);
        int min = int.parse(_tTimeList[1]);
        open_hour = TimeOfDay(hour: hr, minute: min);
      } else {
        open_hour = null;
      }
      if (json['close_hour'] != null) {
        List<String> _tTimeList = json['close_hour'].toString().split(":");
        int hr = int.parse(_tTimeList[0]);
        int min = int.parse(_tTimeList[1]);
        close_hour = TimeOfDay(hour: hr, minute: min);
      } else {
        close_hour = null;
      }
    } catch (e) {
      print("Exception - vendorTimingModel.dart - VendorTiming.fromJson():" + e.toString());
    }
  }*/
}

