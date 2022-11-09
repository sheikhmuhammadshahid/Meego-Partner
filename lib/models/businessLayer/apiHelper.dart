import 'dart:convert';
import 'dart:io';
import 'package:app/models/Offers.dart';
import 'package:app/models/createDealModel.dart';
import 'package:app/screens/SupportScreen.dart';
import 'package:app/screens/appointmentHistoryScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app/models/ChangePasswordModel.dart';
import 'package:app/models/appointmentHistoryModel.dart';
import 'package:app/models/bookingConfirmModel.dart';
import 'package:app/models/bookingDetailModel.dart';
import 'package:app/models/businessLayer/apiResult.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/couponModel.dart';
import 'package:app/models/currencyModel.dart';
import 'package:app/models/expertModel.dart';
import 'package:app/models/faqModel.dart';
import 'package:app/models/galleryModel.dart';
import 'package:app/models/homePageModel.dart';
import 'package:app/models/myWalletModel.dart';
import 'package:app/models/notificationModel.dart';
import 'package:app/models/orderModel.dart';
import 'package:app/models/partnerUserModel.dart';
import 'package:app/models/privacyAndPolicyModel.dart';
import 'package:app/models/productModel.dart';
import 'package:app/models/productOrderModel.dart';
import 'package:app/models/ReviewsModel.dart';
import 'package:app/models/serviceModel.dart';
import 'package:app/models/serviceVariantModel.dart';
import 'package:app/models/userModel.dart';
import 'package:app/models/userRequestModel.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../screens/addServicesScreen.dart';
import '../Deal.dart';
import '../vendorTimingModel.dart';

class APIHelper {
  Future<dynamic> addCoupon(Coupon coupon) async {
    try {
      coupon.id = 0;
      final response = await http.post(
        Uri.parse("${global.baseUrl}VendorCoupon"),
        headers: await global.getApiHeaders(false),
        body: json.encode(coupon),
      );

      dynamic recordList;
      if (response.statusCode == 200 && json.decode(response.body) != null) {
        recordList = Coupon.fromJson(json.decode(response.body));
      } else {
        recordList = null;
      }
      return recordList;
    } catch (e) {
      print("Exception - addCoupon(): " + e.toString());
    }
  }

  Future<dynamic> addExpert(
      int id, String staffName, String staffDescription, File Image) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'vendor_id': id,
        'staff_name': staffName,
        'staff_description': staffDescription,
        'staff_image': Image != null
            ? await MultipartFile.fromFile(Image.path.toString())
            : null,
      });
      response = await dio.post('${global.baseUrl}add_expert',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = Expert.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - addExpert(): " + e.toString());
    }
  }

  Future<dynamic> addGallery(int id, File Image) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'vendor_id': id,
        'image[]': Image != null
            ? await MultipartFile.fromFile(Image.path.toString())
            : null,
      });

      response = await dio.post('${global.baseUrl}add_gallery',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = null;
      } else {
        recordList = null;
      }
      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - addGallery(): " + e.toString());
    }
  }

  Future<dynamic> addProduct(int id, String productName, String price,
      String quantity, String description, File productImage) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'vendor_id': id,
        'product_name': productName,
        'price': price,
        'quantity': quantity,
        'description': description,
        'product_image': productImage != null
            ? await MultipartFile.fromFile(productImage.path.toString())
            : null,
      });

      response = await dio.post('${global.baseUrl}product_add',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = Product.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - addProduct(): " + e.toString());
    }
  }

  Future<dynamic> addService(int id, String serviceName, String category,
      String rate, String time, File Image, String description) async {
    try {
      /*  var postUri = Uri.parse("${global.baseUrl}Service");

      http.MultipartRequest request = new http.MultipartRequest("POST", postUri);

      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'Picture', _Image.path);

      request.files.add(multipartFile);
      request.fields['UserId ']=id.toString();

      request.fields['CategoryId']=1.toString();
      request.fields['Name']=serviceName;
      request.fields['Description']=global.user.venderId.toString();
      request.fields['ServiceTime']=time;
      request.fields['ServiceRate']=rate;




      http.StreamedResponse response = await request.send();*/
      dynamic recordList;
      Response response;
      if (category != "Select Category") {
        category = AddServiceScreen.categoryIds
            .where((element) => element.split(':')[1] == category)
            .first;
        var dio = Dio();
        var formData = FormData.fromMap({
          'Picture': Image != null
              ? MultipartFile.fromFileSync(Image.path,
                  filename: Image.path.split('/').last)
              : null,
          'UserId': id,
          // 'VenderId': global.user.venderId,
          'CategoryId': category.split(':')[0],
          'Name': serviceName,
          'Description': description,
          'ServiceTime': time,
          'ServiceRate': rate
        });

        response = await dio.post('${global.baseUrl}Service',
            data: formData,
            options: Options(
              headers: await global.getApiHeaders(false),
            ));

        if (response.statusCode == 200 /* && response.data["status"] == "1"*/) {
          //recordList = Service.fromJson(response.);
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - addService(): " + e.toString());
    }
  }

  Future<dynamic> addServiceVariant(ServiceVariant serviceVariant) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}add_servicevariant"),
        headers: await global.getApiHeaders(false),
        body: json.encode(serviceVariant),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["data"] != null) {
        recordList =
            ServiceVariant.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - addServiceVariant(): " + e.toString());
    }
  }

  Future<dynamic> bookingConfirm(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}booking_confirm"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"order_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList =
              BookingConfirm.fromJson(json.decode(response.body)["data"]);
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - bookingConfirm(): " + e.toString());
    }
  }

  Future<dynamic> cancelOrder(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}product_orders_cancel"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"store_order_id": id}),
      );
      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        if (json.decode(response.body)["data"] != null) {
          recordList =
              ProductOrder.fromJson(json.decode(response.body)["data"]);
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - cancelOrder(): " + e.toString());
    }
  }

  Future<dynamic> cancelRequest(int id, todo) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}Appointment/UpdateStatus"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"id": id, "status": todo}),
      );

      if (response.statusCode == 200 && json.decode(response.body) != null) {
        return true;
      } else {}
      return false;
    } catch (e) {
      print("Exception - cancelRequest(): " + e.toString());
    }
  }

  Future<dynamic> changePassword(int vendorId, String currentPassword,
      String password, String confirmPassword) async {
    try {
      ChangePassword c = ChangePassword();
      c.UserId = global.user.id;
      c.New = password;
      c.Old = currentPassword;
      var v = c.toJson();
      final response = await http.post(
        Uri.parse("${global.baseUrl}Account/ResetPassword"),
        headers: await global.getApiHeaders(false),
        body: jsonEncode(v),
      );

      dynamic recordList;
      if (response.statusCode == 200 && json.decode(response.body) != null) {
        recordList = jsonDecode(response.body).toString();
      } else {
        recordList = null;
      }
      return recordList;
    } catch (e) {
      print("Exception - changePassword(): " + e.toString());
    }
  }

  Future<dynamic> changePasswordFromOtp(
      String vendorEmail, String password) async {
    try {
      Dio dio = Dio();
      var body = {'UserId': vendorEmail, "Password": password};
      final response = await dio.post(
        "${global.baseUrl}Account/ResetForgetedPassword",
        data: body,
      );

      dynamic recordList;
      if (response.statusCode == 200 && response.data != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Exception - changePasswordFromOtp(): " + e.toString());
    }
    return false;
  }

  Future<dynamic> completeOrder(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}product_orders_complete"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"store_order_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        if (json.decode(response.body)["data"] != null) {
          recordList =
              ProductOrder.fromJson(json.decode(response.body)["data"]);
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - completeOrders(): " + e.toString());
    }
  }

  Future<dynamic> completeRequest(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}booking_complete"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"order_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - completeRequest(): " + e.toString());
    }
  }

  Future<dynamic> confirmWallet(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}paid_to_admin"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.body;
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - confirmWallet(): " + e.toString());
    }
  }

  Future<dynamic> deleteNotification(int id) async {
    try {
      String path = "${global.baseUrl}Notification/DeleteNotification/$id";
      final response = await http.get(
        Uri.parse(path),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = true;
      } else {
        recordList = false;
      }
      return recordList;
    } catch (e) {
      print("Exception - deleteCoupon(): " + e.toString());
    }
  }

  Future<dynamic> deleteCoupon(int id) async {
    try {
      String path = "${global.baseUrl}VendorCoupon/DeleteCoupon/$id";
      final response = await http.get(
        Uri.parse(path),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.body;
        recordList = true;
      } else {
        recordList = false;
      }
      return recordList;
    } catch (e) {
      print("Exception - deleteCoupon(): " + e.toString());
    }
  }

  Future<dynamic> deleteDeal(int id, todo) async {
    try {
      String path;
      if (todo == 'deal') {
        path = "${global.baseUrl}Deals/deleteDeal/$id";
      } else {
        path = "${global.baseUrl}Deals/deleteDealService/$id";
      }
      final response = await http.get(
        Uri.parse(path),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.body;
        return response.body.replaceAll('"', '');
      } else {}
      return recordList;
    } catch (e) {
      print("Exception - deleteCoupon(): " + e.toString());
      return null;
    }
  }

  Future<dynamic> deleteExpert(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}delete_expert"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"staff_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = response.body;
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - deleteExpert(): " + e.toString());
    }
  }

  Future<dynamic> addServicesToApplyCoupon(lst, couponId) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}VendorCoupon/Apply"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"id": couponId, 'ids': lst}),
      );

      dynamic recordList;
      if (response.statusCode == 200 && response.body == 'true') {
        recordList = true;
      } else {
        recordList = false;
      }
      return recordList;
    } catch (e) {
      print("Exception - deleteExpert(): " + e.toString());
    }
  }

  Future<dynamic> deleteGallery(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}delete_gallery"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"gallery_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.body;
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - deleteGallery(): " + e.toString());
    }
  }

  Future<dynamic> deleteProduct(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}product_delete"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"product_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = response.body;
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - deleteProduct(): " + e.toString());
    }
  }

  Future<dynamic> deleteService(int id) async {
    try {
      String path = "http://themeego.io/api/Service/DeleteService/$id";
      final response = await http.get(
        Uri.parse(path),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.body;
        return true;
      } else {
        recordList = null;
      }
      return false;
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - deleteService(): " + e.toString());
      return false;
    }
  }

  Future<dynamic> deleteRequest(int id) async {
    try {
      String s = "${global.baseUrl}Appointment/DeleteAppointment/$id";
      print(s);
      final response = await http.get(
        Uri.parse("${global.baseUrl}Appointment/DeleteAppointment/$id"),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = response.body;
        return true;
      } else {
        recordList = null;
      }
      return false;
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - deleteService(): " + e.toString());
      return false;
    }
  }

  Future<dynamic> deleteServiceVariant(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}delete_servicevariant"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"varient_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = response.body;
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - deleteServiceVariant(): " + e.toString());
    }
  }

  Future<dynamic> AddDeal(CreateDealModel deal, todo) async {
    try {
      // var j = jsonEncode(deal);
      var response;

      if (todo == 'add') {
        var v = {
          'vendorId': deal.vendorId.toString(),
          'dealCategoryId': deal.dealCategoryId.toString(),
          'description': deal.description,
          'name': deal.name,
          'discount': deal.discount.toString(),
          'endDate': deal.endDate,
          'startDate': deal.startDate,
        };
        response = await http.post(
          Uri.parse(global.baseUrl + 'Deals/Create'),
          headers: await global.getApiHeaders(false),
          body: json.encode(v),
        );
      } else {
        var v = {
          'vendorId': deal.vendorId.toString(),
          'dealCategoryId': deal.dealCategoryId.toString(),
          'description': deal.description,
          'name': deal.name,
          'dealId': deal.dealId,
          'id': deal.dealId.toString(),
          'discount': deal.discount.toString(),
          'endDate': deal.endDate,
          'startDate': deal.startDate,
        };
        response = await http.post(Uri.parse(global.baseUrl + 'Deals/Edit'),
            headers: await global.getApiHeaders(false), body: json.encode(v));
      }
      dynamic recordList;
      if (response.statusCode == 200 && response.body != null) {
        return response.body.toString().replaceAll('"', '');
      } else {
        recordList = null;
      }

      return recordList;
    } catch (e) {
      print("Exception - editCoupon(): " + e.toString());
    }
  }

  Future<dynamic> ApplyDeal(serviceid, dealId, dealcatId) async {
    try {
      // var j = jsonEncode(deal);
      var response;
      var v = {
        'vendorId': global.user.venderId.toString(),
        'serviceId': serviceid.toString(),
        'dealId': dealId,
        'dealCategoryId': dealcatId,
      };
      response = await http.post(
          Uri.parse(global.baseUrl + 'Deals/CreateDealService'),
          headers: await global.getApiHeaders(false),
          body: json.encode(v));

      dynamic recordList;
      if (response.statusCode == 200 && response.body != null) {
        return response.body.toString().replaceAll('"', '');
      } else {
        recordList = null;
      }

      return recordList;
    } catch (e) {
      print("Exception - editCoupon(): " + e.toString());
    }
  }

  Future<dynamic> editExpert(int vendorId, String staffName,
      String staffDescription, File Image, int staffId) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'vendor_id': vendorId,
        'staff_name': staffName,
        'staff_description': staffDescription,
        'staff_id': staffId,
        'staff_image': Image != null
            ? await MultipartFile.fromFile(Image.path.toString())
            : null,
      });

      response = await dio.post('${global.baseUrl}edit_expert',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = Expert.fromJson(response.data['data']);
      } else {
        recordList = null;
      }

      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - editExpert(): " + e.toString());
    }
  }

  Future<dynamic> editProduct(
      int productId,
      String productName,
      String price,
      String quantity,
      String description,
      int vendorId,
      File productImage) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'vendor_id': vendorId,
        'product_name': productName,
        'description': description,
        'price': price,
        'quantity': quantity,
        'product_id': productId,
        'product_image': productImage != null
            ? await MultipartFile.fromFile(productImage.path.toString())
            : null,
      });

      response = await dio.post('${global.baseUrl}product_edit',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = Product.fromJson(response.data['data']);
      } else {
        recordList = null;
      }

      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - editProduct(): " + e.toString());
    }
  }

  Future<dynamic> editService(
      int id,
      int serviceId,
      String serviceName,
      String category,
      String rate,
      String time,
      File Image,
      String description) async {
    try {
      Response response;
      category = AddServiceScreen.categoryIds
          .where((element) => element.split(':')[1] == category)
          .first;
      var dio = Dio();

      var formData = FormData.fromMap({
        'Picture': Image != null
            ? MultipartFile.fromFileSync(Image.path,
                filename: Image.path.split('/').last)
            : null,
        'UserId': id,
        'CategoryId': category.split(':')[0],
        'Name': serviceName,
        'Description': description,
        'ServiceTime': time,
        'ServiceRate': rate,
        'ServiceId': serviceId
      });
      String path = '${global.baseUrl}Service/UpdateService';

      print(formData);
      response = await dio.post(path,
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200 /* && response.data["status"] == "1"*/) {
        if (response.data != null)
          recordList = true;
        else
          recordList = false;
      } else {
        recordList = false;
      }
      return recordList;
    } catch (e) {
      print("Exception - editService(): " + e.toString());
    }
  }

  Future<dynamic> editServiceVariant(ServiceVariant serviceVariant) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}edit_servicevariant"),
        headers: await global.getApiHeaders(false),
        body: json.encode(serviceVariant),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body) != null &&
          json.decode(response.body)["data"] != null) {
        recordList =
            ServiceVariant.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - editServiceVariant(): " + e.toString());
    }
  }

  Future<dynamic> forGotPassword(String email) async {
    try {
      var body = {'email': email};

      final response =
          await Dio().post(global.baseUrl + "Account/VerifyEmail", data: body);
      if (response.statusCode == 200) {
        if (response.data != "" && response.data != null) {
          return response.data['userId'].toString() +
              ":" +
              response.data['otpCode'].toString();
        }
      }
      return '';
    } catch (e) {
      print("Exception - fotGetPassword(): " + e.toString());
    }
    return '';
  }

  dynamic getAPIResult<T>(final response, T recordList) {
    try {
      dynamic result;
      result = APIResult.fromJson(json.decode(response.body), recordList);
      return result;
    } catch (e) {
      print("Exception - getAPIResult():" + e.toString());
    }
  }

  dynamic getAPIResultDio<T>(final response, T recordList) {
    try {
      dynamic result;
      result = APIResult.fromJson(response.data, recordList);
      return result;
    } catch (e) {
      print("Exception - getAPIResultDio():" + e.toString());
    }
  }

  User u = User();
  static List<AppointmentHistory> appointments = [];
  Future<dynamic> getAppointmentHistory(int id, String caller) async {
    try {
      Dio dio = Dio();
      final response = await dio.get("${global.baseUrl}Appointment/$id");
      int cd = 0;
      dynamic recordList;
      if (response.statusCode == 200) {
        if (response.data != null) {
          var cMap = response.data;
          List<AppointmentHistory> h = [];
          for (var c in cMap) {
            AppointmentHistory a = AppointmentHistory();
            a.serviceId =
                c['serviceId'] != null ? int.parse('${c['serviceId']}') : null;
            a.serviceDate = c['dayTime'] != null ? c['dayTime'] : null;
            a.user.id = c['userId'] != null ? c['userId'] : null;
            a.id = c['id'] != null ? int.parse('${c['id']}') : null;
            a.serviceTitle =
                c['serviceTitle'] != null ? '${c['serviceTitle']}' : null;
            a.serviceImage =
                c['serviceImage'] != null ? '${c['serviceImage']}' : null;
            a.customerName =
                c['customerName'] != null ? '${c['customerName']}' : null;
            a.customerImage =
                c['customerImage'] != null ? '${c['customerImage']}' : null;
            a.phoneP =
                c['phonePrimary'] != null ? '${c['phonePrimary']}' : null;
            a.phoneS =
                c['phoneSecondary'] != null ? '${c['phoneSecondary']}' : null;
            a.emailP =
                c['emailPrimary'] != null ? '${c['emailPrimary']}' : null;
            a.time = c['time'] != null ? '${c['time']}' : null;
            a.emailS =
                c['emailSecondary'] != null ? '${c['emailSecondary']}' : null;
            a.paymentMethod =
                c['paymentMethod'] != null ? '${c['paymentMethod']}' : null;
            a.statustext = c["status"];
            if (c["status"].toString() == 'Pending') cd++;
            a.totalPrice = c["price"];
            a.discountedPrice =
                c['discoutedPrice'] != null ? '${c['discoutedPrice']}' : null;

            /*if(caller=='Requests' && (c['status']=='Pending' ||c['status']=='Accepted')   )
                        h.add(a);
                    else if(caller!='Requests' &&c['status']!='Pending' &&c['status']!='Accepted' )
                      h.add(a);*/
            h.add(a);
          }
          recordList = h;
          AppointmentHistoryScreen.totalPending = cd.toString();
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return recordList;
    } catch (e) {
      print("Exception - getAppointmentHistory(): " + e.toString());
    }
  }

  Future<dynamic> getBookingDetail(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}booking_details"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"order_id": id, "lang": global.languageCode}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList =
              BookingDetail.fromJson(json.decode(response.body)["data"]);
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getBookingDetail(): " + e.toString());
    }
  }

  Future<dynamic> getCoupon(int id) async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}VendorCoupon/$id"),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          recordList = List<Coupon>.from(
              json.decode(response.body).map((x) => Coupon.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return recordList;
    } catch (e) {
      print("Exception - getCoupon(): " + e.toString());
    }
  }

  Future<dynamic> getDeals(int id, toget) async {
    try {
      String url;
      if (toget == 'services')
        url = "${global.baseUrl}Deals/GetDeals/$id";
      else {
        url = "${global.baseUrl}Deals/AllDeals/$id";
      }
      final response = await http.get(
        Uri.parse(url),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          if (toget == 'services')
            return Offers.fromJson(response.body);
          else {
            List<Deal> d = [];
            var v = jsonDecode(response.body);
            for (var vs in v) {
              d.add(Deal.fromJson(jsonEncode(vs)));
            }
            return d;
          }
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return recordList;
    } catch (e) {
      print("Exception - getCoupon(): " + e.toString());
    }
  }

  Future<dynamic> getDealsCategory() async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}Deals/GetCategories"),
      );
      List<Deal> d = [];
      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          var v = jsonDecode(response.body);
          for (var vs in v) {
            d.add(Deal.fromJson(jsonEncode(vs)));
          }
          return d;
        }
      } else {
        return d;
      }
    } catch (e) {
      print("Exception - getCoupon(): " + e.toString());
      return [];
    }
  }

  Future<dynamic> getCurrency() async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}currency"),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        recordList = Currency.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getCurrency(): " + e.toString());
    }
  }

  Future<dynamic> getExpertReview(int staffId) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}expert_reviews"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"staff_id": staffId}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<Review>.from(json
              .decode(response.body)["data"]
              .map((x) => Review.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getExpertReview(): " + e.toString());
    }
  }

  Future<dynamic> getExperts(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}list_expert"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<Expert>.from(json
              .decode(response.body)["data"]
              .map((x) => Expert.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getExperts(): " + e.toString());
    }
  }

  Future<dynamic> getSupportData() async {
    try {
      Dio dio = Dio();
      final response = await dio.get("${global.baseUrl}Faq/Support");

      dynamic recordList;
      if (response.statusCode == 200) {
        if (response.data != null) {
          var cmap = response.data;
          List<CreditCardData> list = [];
          list.add(CreditCardData(0));
          list.add(CreditCardData(1));
          list.add(CreditCardData(2));
          for (var v in cmap) {
            list[0].id.add(int.parse((v['id']).toString()));
            list[1].id.add(int.parse((v['id']).toString()));
            list[2].id.add(int.parse((v['id']).toString()));
            list[0].data.add(v['phoneNumber']);
            list[1].data.add(v['whatsapp']);
            list[2].data.add(v['email']);
          }
          return list;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("Exception - getFaqs(): " + e.toString());
    }
  }

  Future<dynamic> getFaqs() async {
    try {
      final response = await http.get(Uri.parse("${global.baseUrl}Faq"));

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          recordList = List<Faqs>.from(
              json.decode(response.body).map((x) => Faqs.fromJson(x)));
        } else {
          return false;
        }
      } else {
        return false;
      }
      return recordList;
    } catch (e) {
      print("Exception - getFaqs(): " + e.toString());
    }
  }

  Future<dynamic> getGallery(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}list_gallery"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<Gallery>.from(json
              .decode(response.body)["data"]
              .map((x) => Gallery.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      var v = getAPIResult(response, recordList);

      return v;
    } catch (e) {
      print("Exception - getGallery(): " + e.toString());
    }
  }

  Future<dynamic> getHomePage(int id) async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}vendors/GetHomeData/$id"),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          recordList = HomePage.fromJson(json.decode(response.body));
          final respons = await http.get(Uri.parse(
              "${global.baseUrl}Notification/GetUnSeenCount/${global.user.id}"));
          if (respons.statusCode == 200) {
            if (respons.body != "") {
              recordList.unread_notification_count =
                  int.parse(respons.body.toString());
            }
          }
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getHomePage(): " + e.toString());
    }
  }

  Future<dynamic> getMyWallet(int id) async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}Vendors/GetEarnings/$id"),
        headers: await global.getApiHeaders(false),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          recordList = MyWallet.fromJson(json.decode(response.body));
        }
      } else {
        recordList = null;
      }
      return recordList;
    } catch (e) {
      print("Exception - getMyWallet(): " + e.toString());
    }
  }

  Future<dynamic> updateRead(int id) async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}Notification/Seen/$id"),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          // recordList = List<Notifications>.from(json.decode(response.body).map((x) => Notifications.fromJson(x)));
          return true;
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return recordList;
    } catch (e) {
      print("Exception - getNotification(): " + e.toString());
    }
  }

  Future<dynamic> getNotification(int id) async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}Notification/$id"),
      );

      List<Notifications> recordList = [];
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          recordList = List<Notifications>.from(json
              .decode(response.body)
              .map((x) => Notifications.fromJson(json.encode(x))));
          // recordList.sort((a, b) {
          //   return b.date
          //       .toString()
          //       .toLowerCase()
          //       .compareTo(a.date.toString().toLowerCase());
          // })
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return recordList;
    } catch (e) {
      print("Exception - getNotification(): " + e.toString());
    }
  }

  Future<dynamic> getPartnerReview(int vendorId) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}partner_reviews"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": vendorId}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if ('${json.decode(response.body)["status"]}' == '1') {
          if (json.decode(response.body)["data"] != null) {
            recordList = List<Review>.from(json
                .decode(response.body)["data"]
                .map((x) => Review.fromJson(x)));
          } else {
            recordList = null;
          }
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getExpertReview(): " + e.toString());
    }
  }

  Future<dynamic> getPrivacyAndPolicy() async {
    try {
      print('s');
      final response = await http.get(
          Uri.parse("${global.baseUrl}PrivacyPolicy/GetVendorPrivacyPolicy"));
      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          recordList = PrivacyAndPolicy.fromJson(json.decode(response.body));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getPrivacyAndPolicy(): " + e.toString());
    }
  }

  Future<dynamic> getProducts(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}product_list"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<Product>.from(json
              .decode(response.body)["data"]
              .map((x) => Product.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getProducts(): " + e.toString());
    }
  }

  Future getCategories() async {
    try {
      String path = global.baseUrl + "category";
      final response = await http.get(Uri.parse(path));

      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          var myMap = json.decode(response.body);
          AddServiceScreen.items = [];
          AddServiceScreen.categoryIds = [];
          // AddServiceScreen.selectedCategory="Select Category";
          AddServiceScreen.items.add(DropdownMenuItem(
              child: Text('Select Category'), value: 'Select Category'));
          for (var c in myMap) {
            AddServiceScreen.items.add(DropdownMenuItem(
                child: Text(c['categoryName']), value: c['categoryName']));
            AddServiceScreen.categoryIds
                .add(c['categoryId'].toString() + ':' + c['categoryName']);
          }
          //AddServiceScreen.selectedCategory=AddServiceScreen.items[0].value;
        }
      }
    } catch (e) {
      print("Exception - getCategories(): " + e.toString());
    }
  }

  Future<dynamic> getService(int id) async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}Service/GetVendorServices/$id"),
        /*headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),*/
      );
      int check = 0;
      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          recordList = List<Service>.from(
              json.decode(response.body).map((x) => Service.fromJson(x)));
        }
      } else {
        recordList = null;
        check = 1;
      }

      return recordList;
    } catch (e) {
      print("Exception - getServices(): " + e.toString());
    }
  }

  Future<dynamic> saveTime(dayNo, day, startTime, endTime) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}TimeTables/AddTime"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          "DayNo": dayNo,
          'Day': day,
          'StartTime': startTime,
          'EndTime': endTime,
          'VendorId': global.user.venderId
        }),
      );

      bool recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          recordList = true;
        }
      } else {
        recordList = false;
      }

      return recordList;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> deleteTimeSlot(serviceId) async {
    try {
      final response = await http
          .get(Uri.parse("${global.baseUrl}TimeTables/DeleteTime/$serviceId"));

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          recordList = true;
        }
      } else {
        recordList = false;
      }

      return recordList;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> editTime(dayNo, day, startTime, endTime, id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}TimeTables/UpdateTime"),
        headers: await global.getApiHeaders(false),
        body: json.encode({
          'id': id,
          "DayNo": dayNo,
          'Day': day,
          'StartTime': startTime,
          'EndTime': endTime,
          'VendorId': global.user.venderId
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body) != null) {
          recordList = true;
        }
      } else {
        recordList = false;
      }

      return recordList;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> getUserProfile(int id) async {
    try {
      final response = await http.get(
        Uri.parse("${global.baseUrl}Timetables/GetVendorTimeTable/$id"),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        global.user.weekly_time = [];
        var cmap = json.decode(response.body);
        for (var c in cmap) {
          VendorTiming v = VendorTiming();
          v.days = c['day'];
          v.open_hour = c['startTime'];
          v.close_hour = c['endTime'];
          v.vendor_id = global.user.venderId;
          v.time_slot_id = c['id'];
          global.user.weekly_time.add(v);
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getUserProfile(): " + e.toString());
    }
  }

  Future<dynamic> getUserRequest(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}pending_orders"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );
      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<UserRequest>.from(json
              .decode(response.body)["data"]
              .map((x) => UserRequest.fromJson(x)));
        } else {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getUserRequest(): " + e.toString());
    }
  }

  static int vid;
  Future<dynamic> loginWithEmail(LoginModel user) async {
    String path = "${global.baseUrl}Account/Authenticate";

    try {
      final response = await http.post(
        Uri.parse(path),
        headers: await global.getApiHeaders(false),
        body: json.encode(user),
      );

      dynamic recordList;
      var check = 5;
      if (response.statusCode == 200 && json.decode(response.body) != null) {
        var v = json.decode(response.body);
        print(v);
        if (v['statusCode'].toString() != "400") {
          if (v['statusCode'].toString() == "200") {
            recordList =
                CurrentUser.fromJson(json.decode(response.body)["user"]);
            vid = recordList.venderId;
            await updateToke(recordList.id);
            recordList.token = json.decode(response.body)["token"];

            print(response.body);
            check = 0;
          } else
            check = 3;
        } else
          check = 2;
      } else {
        recordList = null;
        check = 1;
      }
      var v = getAPIResult(response, recordList);
      if (check != 5) v.status = check.toString();
      return v;
    } catch (e) {
      print("Exception - loginWithEmail(): " + e.toString());
    }
  }

  Future<dynamic> updateToke(int id) async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      var token = await messaging.getToken();
      final response = await http.post(
        Uri.parse("${global.baseUrl}Account/UpdateToken"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"UserId": id, 'Token': token}),
      );
      if (response.statusCode == 200) {
        return true;
      } else
        return false;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> paidToAdmin(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}paid_to_admin"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == "1") {
        if (json.decode(response.body)["user"] != null) {
          recordList = null;
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - paidToAdmin(): " + e.toString());
    }
  }

  Future<dynamic> productOrders(int id) async {
    try {
      List<ProductOrder> l = [];
      for (int i = 0; i < 3; i++) {
        ProductOrder p = ProductOrder();
        p.user = u;
        p.statustext = "Status Text";
        p.status = 1;
        p.description = "description";
        Order o = Order();
        p.order = o;
        p.order_cart_id = "cartid";
        p.order_date = "order date";
        p.price = "Order price";
        p.product_image = null;
        p.productId = i;
        p.productImage = null;
        p.productName = "Product name";
        p.qty = 5;
        p.quantity = "quantity";
        p.service_date = "service date";
        p.service_time = "service time";
        p.store_order_id = 1;
        p.total_price = "Total price";
        p.vendor_id = global.user.venderId;
        l.add(p);
      }
      return l;
      /*final response = await http.post(
        Uri.parse("${global.baseUrl}product_orders"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_id": id, "lang": global.languageCode}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        if (json.decode(response.body)["data"] != null) {
          recordList = List<ProductOrder>.from(json.decode(response.body)["data"].map((x) => ProductOrder.fromJson(x)));
        }
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    */
    } catch (e) {
      print("Exception - productOrders(): " + e.toString());
    }
  }

  Future<dynamic> setting(int vendorId, String onlineStatus) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${global.baseUrl}Vendors/OpenClose/$vendorId/${onlineStatus == "ON" ? true : false}"),
      );

      dynamic recordList;
      if (response.statusCode == 200 && json.decode(response.body) != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Exception - setting(): " + e.toString());
    }
  }

  Future<dynamic> signUp(
      int type,
      String vendorName,
      String ownerName,
      String lname,
      String vendorEmail,
      String vendorPassword,
      String deviceId,
      String vendorPhone,
      String vendorAddress,
      String description,
      String city,
      File vendorImage) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'Picture': vendorImage != null
            ? MultipartFile.fromFileSync(vendorImage.path,
                filename: vendorImage.path.split('/').last)
            : null,
        'Email': vendorEmail,
        'city': city,
        'Password': vendorPassword,
        'ConfrimPassword': vendorPassword,
        'BussinessName': vendorName,
        'firstName': ownerName,
        'lastName': lname,
        'PhoneNumber': vendorPhone,
        'Address': vendorAddress,
        'Type': type.toString(),
        'Description': description,
      });

      response = await dio.post(
        '${global.baseUrl}Account/RegisterVendor',
        data: formData,
        /* options: Options(
            headers: await global.getApiHeaders(false),
          )*/
      );
      dynamic recordList;

      if (response.statusCode == 200 /*&& response.data["status"] == "1"*/) {
        return response.data['message'].toString();
      } else {
        recordList = null;
      }

      return response.data['message'].toString();
    } catch (e) {
      print("Exception - signUp(): " + e.toString());
    }
  }
  /* Future<dynamic> signUp(int type, String vendor_name, String owner_name, String vendor_email, String vendor_password, String device_id, String vendor_phone, String vendor_address, String description, File vendor_image) async {
    try {

      var dio = Dio();
     */ /* var map = new Map<String, dynamic>();
      //map['Picture']= vendor_image != null ? await MultipartFile.fromFile(vendor_image.path.toString()) : null;
      map['Picture']= vendor_image.path.isNotEmpty ? await MultipartFile.fromFile(vendor_image.path.toString()) : null;
      */ /*
      MultipartFile file = await MultipartFile.fromFile(vendor_image.path);
      var formData=jsonEncode({
        'Type': type.toString(),
        'BussinessName': vendor_name,
        'OwnerName': owner_name,
        'Email': vendor_email,
        'Password': vendor_password,
        'ConfirmPassword': vendor_password,
        //'device_id': device_id,
        'PhoneNumber': vendor_phone,
        'Address': vendor_address,
        'Description': description,
        'Picture': file,//vendor_image.path.isNotEmpty ? await MultipartFile.fromFile(vendor_image.path.toString()) : null
      });

      final response = await http.post(
        Uri.parse('${global.baseUrl}RegisterVendor'),
        headers: {
      //"Content-Type": "application/x-www-form-urlencoded",
     // "Content-type": "application/json",
          'Content-Type': 'multipart/form-data',
         // 'Authorization': 'token $token',
      },
        body: formData,
      );

      dynamic recordList;

      */ /*if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = CurrentUser.fromJson(response.data["data"]);
      } else {
        recordList = null;
      }*/ /*
      
      return getAPIResultDio(response, recordList);
    } catch (e) {
      print("Exception - signUp(): " + e.toString());
    }
  }*/

  Future<dynamic> updateProfile(
    int vendorId,
    String vendorName,
    String fowner,
    String lname,
    String vendorPhone,
    String vendorLoc,
    String description,
    String vendorEmail,
    File image,
  ) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'VendorId': vendorId,
        'BussinessName': vendorName,
        'firstName': fowner,
        'lastName': lname,
        'Phone': vendorPhone,
        'Address': vendorLoc,
        'Description': description,
        'Email': vendorEmail,
        'Picture': image != null
            ? await MultipartFile.fromFile(image.path.toString())
            : null,
      });

      response = await dio.post('${global.baseUrl}Vendors/EditProfile',
          data: formData);
      /*var response=await http.post(Uri.parse('${global.baseUrl}Vendors/UpdateProfile'),
      headers: await global.getApiHeaders(false),
      body: formData
      );*/
      dynamic recordList;

      if (response.statusCode == 200) {
        if (response.data == "Updated Successfully") {
          global.user.firstname = fowner;
          global.user.lastname = lname;
          global.user.vendor_name = vendorName;
          global.user.vendor_phone = vendorPhone;
          global.user.vendor_address = vendorLoc;
          global.user.shop_image = image != null
              ? image.path.split('/').last
              : global.user.shop_image;
          global.user.email = vendorEmail;
          global.user.description = description;
        }
        return response.data;
      } else {
        recordList = null;
      }

      return "Not";
    } catch (e) {
      print("Exception - updateProfile(): " + e.toString());
      return "Not";
    }
  }

  Future<dynamic> verifyOtp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}verifyOtp"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"vendor_email": email, "otp": otp}),
      );

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - verifyOtp(): " + e.toString());
    }
  }

  Future<bool> saveLatLon(double parse, double parse2) async {
    try {
      Dio dio = Dio();
      var response = await dio.post(global.baseUrl + "Vendors/SaveMapLatLong",
          data: {
            'Latitude': parse,
            'Longitude': parse2,
            'VendorId': global.user.venderId
          });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<dynamic> getReviews(List<Review> reviews) async {
    try {
      String str = '${global.baseUrl}Vendors/Reviews/${global.user.venderId}';

      final response = await Dio().get(
        str,
      );
      if (response.statusCode == 200) {
        reviews.clear();
        for (var element in (response.data as List)) {
          reviews.add(Review.fromMap(element));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return reviews;
  }
}
