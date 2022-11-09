import 'package:app/models/userModel.dart';

class ChangePassword
{
  int UserId;
  String Old;
  String New;
  Map<String, dynamic> toJson() => {
    'UserId': UserId != null ? UserId : null,
    'New': New != null ? New : null,
    'Old': Old != null ? Old : null,
  };
  ChangePassword();
  ChangePassword.fromJson(Map<String, dynamic> json) {
    try {
      UserId =
      json['UserId'] != null ? int.parse(json['UserId']) : null;
      Old = json['Old'] != null ? json['Old'] : null;
      New = json['New'] != null ? json['New'] : null;

    } catch (e) {
      print(
          "Exception - ChangePasswordModel.dart - ChangePassword.fromJson():" +
              e.toString());
    }
  }
}