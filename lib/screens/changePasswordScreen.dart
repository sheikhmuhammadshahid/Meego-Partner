import 'dart:io';
import 'dart:ui';

import 'package:app/dialogs/changePasswordSuccessDialog.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends BaseRoute {
  final bool isFromVarifyOtp;

  ChangePasswordScreen(this.isFromVarifyOtp, {a, o}) : super(a: a, o: o, r: 'ChangePasswordScreen');
  @override
  _ChangePasswordScreenState createState() => new _ChangePasswordScreenState(this.isFromVarifyOtp);
}

class _ChangePasswordScreenState extends BaseRouteState {
  bool isFromVarifyOtp;
  TextEditingController _cEmail = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();
  TextEditingController _cConfirmPassword = new TextEditingController();
  TextEditingController _cOldPassword = new TextEditingController();
  bool _showOldPassword = true;
  bool _showNewPassword = true;
  bool _showConfirmPassword = true;
  GlobalKey<ScaffoldState> _scaffoldKey;
  var _fOldPassword = FocusNode();
  var _fPassword = FocusNode();

  var _fConfirmPassword = FocusNode();
  var _fDismiss = FocusNode();
  _ChangePasswordScreenState(this.isFromVarifyOtp) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return null;
      },
      child: sc(
        Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.background,
                      image: DecorationImage(
                          image: AssetImage("assets/partner_background.png")
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: Dimens.space_large),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_large),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.arrow_back)),
                              Image.asset('assets/partner_logo.png',
                                  scale: 7.0),
                              Text(' ')
                            ],
                          ),
                        ),
                        SizedBox(height: Dimens.space_xxlarge),
                        Container(
                            margin: EdgeInsets.only(top: 25),
                            child: Text(
                              AppLocalizations.of(context).lbl_change_password,
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0
                                )
                            )),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                                top: 15,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  !isFromVarifyOtp
                                      ? Text(
                                          AppLocalizations.of(context).lbl_old_password,
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        )
                                      : SizedBox(),
                                  !isFromVarifyOtp
                                      ? Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: TextFormField(
                                            controller: _cOldPassword,
                                            obscureText: _showOldPassword,
                                            focusNode: _fOldPassword,
                                            onFieldSubmitted: (val) {
                                              FocusScope.of(context).requestFocus(_fPassword);
                                            },
                                            decoration: InputDecoration(
                                              hintText: AppLocalizations.of(context).hnt_email,
                                              prefixIcon: Icon(
                                                Icons.lock,
                                              ),
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  _showOldPassword = !_showOldPassword;
                                                  setState(() {});
                                                },
                                                icon: Icon(_showOldPassword ? Icons.visibility_off : Icons.visibility),
                                                color: Colors.black,
                                              ),
                                              contentPadding: EdgeInsets.only(top: 5),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  isFromVarifyOtp
                                      ? Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text(
                                            AppLocalizations.of(context).lblEmail,
                                            style: Theme.of(context).primaryTextTheme.subtitle2,
                                          ),
                                        )
                                      : SizedBox(),
                                  isFromVarifyOtp
                                      ? Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: TextFormField(
                                            controller: _cEmail,
                                            onFieldSubmitted: (val) {
                                              FocusScope.of(context).requestFocus(_fConfirmPassword);
                                            },
                                            decoration: InputDecoration(
                                              hintText: AppLocalizations.of(context).hnt_email,
                                              prefixIcon: Icon(Icons.mail),
                                              contentPadding: EdgeInsets.only(top: 5),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      isFromVarifyOtp ? AppLocalizations.of(context).lblPassword : AppLocalizations.of(context).lbl_new_password,
                                      style: Theme.of(context).primaryTextTheme.subtitle2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: TextFormField(
                                      controller: _cPassword,
                                      obscureText: _showNewPassword,
                                      onFieldSubmitted: (val) {
                                        FocusScope.of(context).requestFocus(_fConfirmPassword);
                                      },
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context).hnt_email,
                                        prefixIcon: Icon(Icons.lock),
                                        suffixIcon: IconButton(
                                          icon: Icon(_showNewPassword ? Icons.visibility_off : Icons.visibility),
                                          color: Colors.black,
                                          onPressed: () {
                                            _showNewPassword = !_showNewPassword;
                                            setState(() {});
                                          },
                                        ),
                                        contentPadding: EdgeInsets.only(top: 5),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      AppLocalizations.of(context).lbl_confirm_password,
                                      style: Theme.of(context).primaryTextTheme.subtitle2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: TextFormField(
                                      obscureText: _showConfirmPassword,
                                      controller: _cConfirmPassword,
                                      onFieldSubmitted: (val) {
                                        FocusScope.of(context).requestFocus(_fDismiss);
                                      },
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context).hnt_email,
                                        prefixIcon: Icon(
                                          Icons.lock,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(_showConfirmPassword ? Icons.visibility_off : Icons.visibility),
                                          color: Colors.black,
                                          onPressed: () {
                                            _showConfirmPassword = !_showConfirmPassword;
                                            setState(() {});
                                          },
                                        ),
                                        contentPadding: EdgeInsets.only(top: 5),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Dimens.space_xxxxlarge),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context).size.width*0.25,
                                      vertical: Dimens.space_large,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        _changePassword();
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 40,
                                        child: Center(
                                          child: Text(
                                              AppLocalizations.of(context).btn_change_password,
                                              style: TextStyle(
                                                  color: AppColors.surface
                                              )),
                                        ),
                                        decoration: BoxDecoration(
                                            color: AppColors.dotColor,
                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
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

  _changePassword() async {
    try {
      if (isFromVarifyOtp) // change password from otp...
      {
        if (_cPassword.text.isNotEmpty && _cPassword.text == _cConfirmPassword.text) {
          bool isConnected = await br.checkConnectivity();
          if (isConnected) {
            showOnlyLoaderDialog();

            await apiHelper.changePasswordFromOtp(_cEmail.text.trim(), _cPassword.text.trim()).then((result) {
              if (result.status == "1") {
                hideLoader();

                showDialog(
                    context: context,
                    builder: (BuildContext context) => ChangePasswordSuccessDialog(
                          a: widget.analytics,
                          o: widget.observer,
                        ));
              } else {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
              }
            });
          } else {
            showNetworkErrorSnackBar(_scaffoldKey);
          }
        } else if (_cEmail.text.isEmpty) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_email);
        } else if (_cPassword.text != _cConfirmPassword.text) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_password_and_confirm_password_do_not_match);
        }
      } else //simple change password
      {
        if (_cPassword.text.isNotEmpty && _cPassword.text == _cConfirmPassword.text && _cOldPassword.text.isNotEmpty) {
          bool isConnected = await br.checkConnectivity();
          if (isConnected) {
            showOnlyLoaderDialog();

            await apiHelper.changePassword(global.user.id, _cOldPassword.text.trim(), _cPassword.text.trim(), _cConfirmPassword.text.trim()).then((result) {

                hideLoader();

                showDialog(
                    context: context,
                    builder: (BuildContext context) => ChangePasswordSuccessDialog(
                          a: widget.analytics,
                          o: widget.observer,
                      msg: result,
                        ));


            });
          } else {
            showNetworkErrorSnackBar(_scaffoldKey);
          }
        } else if (_cOldPassword.text.isEmpty) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_old_password);
        } else if (_cPassword.text != _cConfirmPassword.text) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_password_and_confirm_password_do_not_match);
        } else if (_cPassword.text.isEmpty) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_new_password);
        }
      }
    } catch (e) {
      print("Exception - changePassword.dart - _changePassword():" + e.toString());
    }
  }
}
