import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/screens/changePasswordScreen.dart';
import 'package:app/screens/signInScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerifyOtpScreen extends BaseRoute {
  final String userId;
  final String opt;
  VerifyOtpScreen(this.userId, this.opt, {a, o})
      : super(a: a, o: o, r: 'VerifyOtpScreen');
  @override
  _VerifyOtpScreenState createState() =>
      new _VerifyOtpScreenState(this.userId, this.opt);
}

class _VerifyOtpScreenState extends BaseRouteState {
  String userId;
  String otp;
  GlobalKey<ScaffoldState> _scaffoldKey;
  final TextEditingController _pinPutController = TextEditingController();

  _VerifyOtpScreenState(this.userId, this.otp) : super();
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Theme.of(context).primaryColor, width: 1));
  }

  var otpController = TextEditingController();
  var pass = TextEditingController();
  var conPass = TextEditingController();
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return null;
      },
      child: sc(
        Scaffold(
            bottomNavigationBar: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _verifyOtp();
                },
                child: Text(
                  AppLocalizations.of(context).btn_submit,
                ),
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            resizeToAvoidBottomInset: false,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).primaryColor,
                                BlendMode.screen,
                              ),
                              child: Image.asset(
                                'assets/banner.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: Platform.isAndroid
                                ? EdgeInsets.only(bottom: 15, left: 10, top: 10)
                                : EdgeInsets.only(
                                    bottom: 15, left: 10, top: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_left_outlined,
                                  color: Colors.black,
                                ),
                                Text(
                                  AppLocalizations.of(context).lbl_back,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17.5),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      margin: EdgeInsets.only(top: 80),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 25),
                                child: Text(
                                  AppLocalizations.of(context).lbl_verify_otp,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline3,
                                )),
                            SizedBox(
                              height: 70,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: TextFormField(
                                controller: otpController,
                                onFieldSubmitted: (val) {},
                                decoration: InputDecoration(
                                  hintText: 'Enter Otp',
                                  contentPadding:
                                      EdgeInsets.only(top: 5, left: 40),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: TextFormField(
                                controller: pass,
                                obscureText: _showPassword,
                                onFieldSubmitted: (val) {},
                                decoration: InputDecoration(
                                  hintText: 'Enter New Password',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(_showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      _showPassword = !_showPassword;
                                      setState(() {});
                                    },
                                  ),
                                  contentPadding: EdgeInsets.only(top: 5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: TextFormField(
                                controller: conPass,
                                obscureText: _showPassword,
                                onFieldSubmitted: (val) {},
                                decoration: InputDecoration(
                                  hintText: 'Confirm New Password',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(_showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      _showPassword = !_showPassword;
                                      setState(() {});
                                    },
                                  ),
                                  contentPadding: EdgeInsets.only(top: 5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Column(
                                children: [
                                  Text(
                                    'Enter the Verification Code from',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle2,
                                  ),
                                  Text(
                                    'Gmail we just sent you',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle2,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  _verifyOtp() async {
    try {
      if (userId.isNotEmpty &&
          pass.text.isNotEmpty &&
          conPass.text.isNotEmpty &&
          otpController.text.isNotEmpty) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          if (otp == otpController.text.trim()) {
            if (pass.text.trim() == conPass.text.trim()) {
              showOnlyLoaderDialog();

              await apiHelper
                  .changePasswordFromOtp(userId, pass.text.trim())
                  .then((result) {
                if (result) {
                  hideLoader();
                  showSnackBar(
                      key: _scaffoldKey,
                      snackBarMessage: 'Password Saved Successfully');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                } else {
                  hideLoader();
                  showSnackBar(key: _scaffoldKey, snackBarMessage: 'Try Again');
                }
              });
            } else {
              showSnackBar(
                  key: _scaffoldKey,
                  snackBarMessage: 'Password does not match');
            }
          } else {
            showSnackBar(
                key: _scaffoldKey, snackBarMessage: 'Otp does not match');
          }
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (userId.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_email);
      } else if (otpController.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage: AppLocalizations.of(context).txt_please_enter_otp);
      } else if (pass.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: "Please enter Password");
      } else if (conPass.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage: 'Please enter confirm Password');
      }
    } catch (e) {
      print("Exception - verifyOtpScreen.dart - _verifyOtp():" + e.toString());
    }
  }
}
