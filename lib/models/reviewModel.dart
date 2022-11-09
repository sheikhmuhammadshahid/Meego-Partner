import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:app/models/userModel.dart';

class ServiceModel {
  File picture;
  String Name = "";
  int UserId;

  ServiceModel();
  Map<String, dynamic> toJson() => {
        'UserId': UserId,
        'Name': Name,
        'picture': picture != null
            ? MultipartFile.fromFile(picture.path.toString())
            : null,
      };

  ServiceModel.fromJson(Map<String, dynamic> json) {
    try {
      Name = json['Name'] != null ? '${json['Name']}' : null;
      UserId = json['UserId'] != null ? int.parse('${json['UserId']}') : null;
      picture = json['picture'] != null ? json['picture'] : null;
    } catch (e) {
      print("Exception - reviewModel.dart - ServiceModel.fromJson():" +
          e.toString());
    }
  }
}
