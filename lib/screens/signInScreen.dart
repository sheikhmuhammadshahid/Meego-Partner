import 'dart:async';
import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/homePageModel.dart';
import 'package:app/models/partnerUserModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/screens/chooseSignUpSignInScreen.dart';
import 'package:app/screens/homeScreen.dart';
import 'package:app/screens/signUpScreen.dart';
import 'package:app/screens/verifyOtpScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends BaseRoute {
  final int screenId;
  SignInScreen({a, o, this.screenId}) : super(a: a, o: o, r: 'SignInScreen');
  @override
  _SignInScreenState createState() =>
      new _SignInScreenState(screenId: screenId);
}

class _SignInScreenState extends BaseRouteState {
  bool _isValidateEmail = false;
  bool _isValidate = false;
  var _fPassword = new FocusNode();

  TextEditingController _cEmail = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();
  TextEditingController _cForgotEmail = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey;
  int screenId;
  LoginModel user = new LoginModel();
  bool _showPassword = false;
  bool _isRemember = false;
  _SignInScreenState({this.screenId}) : super();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        screenId == 1
            ? exitAppDialog()
            : Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChooseSignUpSignInScreen(
                      a: widget.analytics,
                      o: widget.observer,
                    )));
        return null;
      },
      child: sc(
        Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
                decoration: BoxDecoration(
                    color: AppColors.background,
                    image: DecorationImage(
                        image: AssetImage("assets/partner_background.png"))),
                // margin: EdgeInsets.only(top: 80),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChooseSignUpSignInScreen(
                                                  a: widget.analytics,
                                                  o: widget.observer,
                                                )),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Text("Skip")),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChooseSignUpSignInScreen(
                                                  a: widget.analytics,
                                                  o: widget.observer,
                                                )),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Icon(Icons.arrow_back)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Image.asset('assets/partner_signin_logo.png',
                                scale: 10.0)),
                        SizedBox(
                          height: 20.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Welcome back!",
                            style: Theme.of(context).primaryTextTheme.headline4,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text("SIGN IN TO CONTINUE",
                              style: TextStyle(fontSize: 15.0)),
                        ),
                        // Container(
                        //     margin: EdgeInsets.only(top: 30, bottom: 10),
                        //     child: Text(
                        //       AppLocalizations.of(context).lblSignIn,
                        //       style: Theme.of(context).primaryTextTheme.headline3,
                        //     )),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context).lblEmail,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextFormField(
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(_fPassword);
                                  },
                                  controller: _cEmail,
                                  onChanged: (val) {
                                    _isValidate = EmailValidator.validate(val);
                                  },
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context).hnt_email,
                                    prefixIcon: Icon(Icons.mail),
                                    contentPadding: EdgeInsets.only(top: 5),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  AppLocalizations.of(context).lblPassword,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextFormField(
                                  focusNode: _fPassword,
                                  controller: _cPassword,
                                  obscureText: _showPassword,
                                  onFieldSubmitted: (val) {},
                                  decoration: InputDecoration(
                                    hintText: '******',
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
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 17,
                                    width: 17,
                                    child: Checkbox(
                                        value: _isRemember,
                                        onChanged: (val) {
                                          _isRemember = val;
                                          setState(() {});
                                          if (!_isRemember) {
                                            global.sp
                                                .remove('isRememberMeEmail');
                                          }
                                        }),
                                  ),
                                  Container(
                                      margin: global.isRTL
                                          ? EdgeInsets.only(right: 7)
                                          : EdgeInsets.only(left: 7),
                                      child: GestureDetector(
                                        onTap: () {
                                          _isRemember = !_isRemember;
                                          setState(() {});
                                          if (!_isRemember) {
                                            global.sp
                                                .remove('isRememberMeEmail');
                                          }
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .lblRememberMe,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      )),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  _forgotPassword();
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .lblForgotPassword,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline1,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: Dimens.space_xxxlarge),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.space_xxxxxxxlarge,
                            vertical: Dimens.space_large,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              _loginWithEmail();
                            },
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                    AppLocalizations.of(context).btnSignIn,
                                    style: TextStyle(color: AppColors.surface)),
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.dotColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 50,
                        //   margin: EdgeInsets.only(top: 25),
                        //   width: MediaQuery.of(context).size.width,
                        //   child: TextButton(
                        //     onPressed: () {
                        //       _loginWithEmail();
                        //     },
                        //     child: Text(
                        //       AppLocalizations.of(context).btnSignIn,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2),
                        Container(
                          margin: EdgeInsets.only(top: 25, left: 30),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .txt_if_you_have_no_account,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SignUpScreen(
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                                },
                                child: Text(
                                  AppLocalizations.of(context).btnSignUp,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline1,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))),
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
    if (global.sp.getString('isRememberMeEmail') != null &&
        global.sp.getString('isRememberMePassword') != null) {
      _cEmail.text = global.sp.getString('isRememberMeEmail');
      _cPassword.text = global.sp.getString('isRememberMePassword');
      _isRemember = true;
      _isValidate = true;
    }
  }

  Future _forgotPassword() async {
    try {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  AppLocalizations.of(context).lbl_forgot_password,
                  textAlign: TextAlign.center,
                ),
                titleTextStyle: Theme.of(context).primaryTextTheme.headline3,
                content: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          AppLocalizations.of(context).lblEmail,
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TextFormField(
                          controller: _cForgotEmail,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).hnt_email,
                            prefixIcon: Icon(Icons.mail),
                            contentPadding: EdgeInsets.only(top: 5, left: 10),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 17),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: () async {
                            _isValidateEmail = EmailValidator.validate(
                                _cForgotEmail.text.trim());
                            if (_isValidateEmail &&
                                _cForgotEmail.text.isNotEmpty) {
                              bool isConnected = await br.checkConnectivity();
                              if (isConnected) {
                                showOnlyLoaderDialog();
                                await apiHelper
                                    .forGotPassword(_cForgotEmail.text.trim())
                                    .then((result) {
                                  if (result != '') {
                                    hideLoader();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VerifyOtpScreen(
                                                  result
                                                      .toString()
                                                      .trim()
                                                      .split(':')[0],
                                                  result
                                                      .toString()
                                                      .trim()
                                                      .split(':')[1],
                                                  a: widget.analytics,
                                                  o: widget.observer,
                                                )));
                                  } else {
                                    hideLoader();
                                    Navigator.of(context).pop();
                                    showSnackBar(
                                        key: _scaffoldKey,
                                        snackBarMessage:
                                            'Email not Registered.');
                                  }
                                });
                              } else {
                                showNetworkErrorSnackBar(_scaffoldKey);
                              }
                            } else {
                              showSnackBar(
                                  key: _scaffoldKey,
                                  snackBarMessage: AppLocalizations.of(context)
                                      .txt_please_enter_valid_email);
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context).btn_send_code,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )).then((paymentMode2) {});
    } catch (e) {
      print('Exception: signInScreen: _forgotPassword(): ${e.toString()}');
    }
  }

  _loginWithEmail() async {
    try {
      FocusScope.of(context).unfocus();
      user.username = _cEmail.text.trim();
      user.password = _cPassword.text.trim();
      //user. = global.appDeviceId;
      user.role = "Vendor";
      if (_cEmail.text.isNotEmpty &&
          _cPassword.text.isNotEmpty &&
          _cPassword.text.trim().length >= 2 &&
          _isValidate) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper.loginWithEmail(user).then((result) async {
            // print(result);
            if (result != null) {
              if (result.status == "0") {
                global.user = result.recordList;
                br.saveUser(global.user);
                if (_isRemember) {
                  await global.sp
                      .setString('isRememberMeEmail', _cEmail.text.trim());
                  await global.sp.setString(
                      'isRememberMePassword', _cPassword.text.trim());
                }
                hideLoader();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BottomNavigationWidget(
                          a: widget.analytics,
                          o: widget.observer,
                        )
                    // HomeScreen(a: widget.analytics, o: widget.observer)),
                    ));
              } else {
                hideLoader();
                showSnackBar(
                    key: _scaffoldKey, snackBarMessage: '${result.message}');
              }
            } else {
              hideLoader();
              showSnackBar(
                  key: _scaffoldKey, snackBarMessage: 'User Not Found');
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (_cEmail.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: 'Please enter valid Email Id');
      } else if (_cPassword.text.isEmpty || _cPassword.text.trim().length < 2) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage: 'Password should be of minimun 2 characters');
      } else if (_cEmail.text.isEmpty || !_isValidate) {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: 'Please enter valid email');
      }
    } catch (e) {
      print(
          "Exception - signInScreen.dart - _loginWithEmail():" + e.toString());
    }
  }
}
