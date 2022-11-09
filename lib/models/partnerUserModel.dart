import 'dart:io';

import 'package:app/models/ReviewsModel.dart';
import 'package:app/models/vendorTimingModel.dart';
import 'package:flutter/material.dart';

class LoginModel {
  String password;
  String username;
  String role;
  String token;
  LoginModel();
  Map<String, dynamic> toJson() =>
      {'username': username, 'role': role, 'password': password};

  LoginModel.fromJson(Map<String, dynamic> json) {
    try {
      password = json['password'] != null ? '${json['password']}' : null;
      username = json['username'] != null ? '${json['username']}' : null;
      role = json['role'] != null ? '${json['role']}' : null;
    } catch (e) {
      print("Exception - partnerUserModel.dart - LoginModel.fromJson():" +
          e.toString());
    }
  }
}

class CurrentUser {
  int id;
  String city;
  int venderId = 0;
  String vendor_phone;
  String user_address;
  String salon_name = "Beauty Parlor";
  double rating;
  String username;
  String vendor_name = "Shahid Hassan";
  String owner_name = "Shahid";
  String vendor_email;
  String vendor_password;
  String vendor_address;
  File vendor_image;
  String shop_image;
  TimeOfDay open_hour;
  TimeOfDay close_hour;
  List<VendorTiming> weekly_time = [];
  int cityadmin_id;

  int type;
  String vendor_logo;

  String name;
  String firstname = " ";
  String lastname = " ";
  String image;
  String email;
  int otp;
  String facebook_id;
  DateTime email_verified_at;
  String password;
  String device_id;
  int wallet_credits;
  int rewards;
  bool phone_verified;
  String referral_code;
  String remember_token;
  DateTime created_at;
  DateTime updated_at;
  String token;
  String description;

  String user_name;
  String user_email;
  String user_password;
  var user_image;
  String fb_id;
  int roleId;
  String company;
  String online_status;
  List<Review> review = [];
  CurrentUser();

  Map<String, dynamic> toJson() => {
        'venderId': venderId,
        'city': city,
        'id': id,
        'company': company,
        'roleId': roleId,
        'shopAddress': vendor_address,
        'userAddress': user_address,
        "shopName": vendor_name,
        'description': description,
        'online_status': online_status,
        'userType': type != null ? type : null,
        'mobile': vendor_phone != null && vendor_phone.isNotEmpty
            ? vendor_phone
            : null,
        'username':
            vendor_name != null && vendor_name.isNotEmpty ? vendor_name : null,
        'rating': rating,
        'firstName':
            firstname != null && firstname.isNotEmpty ? firstname : null,
        'lastName': lastname != null && lastname.isNotEmpty ? lastname : null,
        'token': token != null && token.isNotEmpty ? token : null,
        'shopPicture': shop_image,
        'profilePicture': user_image != null ? user_image : null,
        'email': vendor_email != null && vendor_email.isNotEmpty
            ? vendor_email
            : null,
        'password': user_password != null && user_password.isNotEmpty
            ? user_password
            : null,
        'creationTime':
            created_at != null ? created_at.toIso8601String() : null,
      };

  CurrentUser.fromJson(Map<String, dynamic> json) {
    try {
      city = json['city'] != null ? json['city'] : null;
      id = json['id'] != null ? int.parse('${json['id']}') : null;
      venderId =
          json['venderId'] != null ? int.parse('${json['venderId']}') : null;
      // company=json['company'] != null ? json['company'] : null;
      vendor_phone = json['mobile'] != null ? json['mobile'] : null;
      //token = json['token'] != null ? json['token'] : null;
      online_status =
          json['online_status'] != null ? json['online_status'] : null;
      username = json['email'] != null ? json['email'] : null;
      vendor_name = json['shopName'] != null ? json['shopName'] : null;
      //roleId=json['roleId'] != null ? json['roleId'] : null;
      lastname = json['lastName'] != null ? json['lastName'] : null;
      rating = double.parse(json['rating'].toString());
      firstname = json['firstName'] != null ? json['firstName'] : null;
      user_image =
          json['profilePicture'] != null ? json['profilePicture'] : null;
      shop_image = json['shopPicture'] != null ? json['shopPicture'] : null;
      vendor_email = json['email'] != null ? json['email'] : null;
      // password = json['password'] != null ? json['password'] : null;
      user_address = json['userAddress'] != null ? json['userAddress'] : null;
      vendor_address = json['shopAddress'] != null ? json['shopAddress'] : null;
      //email=json['email'] != null ? json['email'] : null;
      //type = json['usertype'] != null ? int.parse('${json['usertype']}') : null;
      description =
          json['description'] != null ? '${json['description']}' : null;
    } catch (e) {
      print("Exception - partnerUserModel.dart - CurrentUser.fromJson():" +
          e.toString());
    }
  }
}
