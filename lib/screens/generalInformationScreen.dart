import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/partnerUserModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/screens/signInScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../dialogs/updateProfileSuccessDialog.dart';
import 'package:csc_picker/csc_picker.dart';

class GeneralInformationScreen extends BaseRoute {
  final String email;
  final String password;
  GeneralInformationScreen(this.email, this.password, {a, o})
      : super(a: a, o: o, r: 'GeneralInformationScreen');
  @override
  _GeneralInformationScreenState createState() =>
      new _GeneralInformationScreenState(this.email, this.password);
}

class _GeneralInformationScreenState extends BaseRouteState {
  var countryValue;
  var stateValue;
  var cityValue;
  String email;
  String password;
  CurrentUser user = new CurrentUser();
  TextEditingController _cVenderName = new TextEditingController();
  TextEditingController _cOwnerFName = new TextEditingController();
  TextEditingController _cOwnerLName = new TextEditingController();
  TextEditingController _cPhoneNumber = new TextEditingController();
  TextEditingController _cAddress = new TextEditingController();
  TextEditingController _cDescription = new TextEditingController();
  File _tImage;
  var _fOwnerFName = new FocusNode();
  var _fOwnerLName = new FocusNode();
  var _fPhoneNumber = new FocusNode();
  var _fAddress = new FocusNode();

  GlobalKey<ScaffoldState> _scaffoldKey;
  int _saloonType = 2;

  var dropdownval;

  _GeneralInformationScreenState(this.email, this.password) : super();
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
                decoration: BoxDecoration(
                    color: AppColors.background,
                    image: DecorationImage(
                        image: AssetImage("assets/partner_background.png"))),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(children: [
                      SizedBox(height: Dimens.space_large),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.space_large),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back)),
                            Image.asset('assets/partner_logo.png', scale: 7.0),
                            Icon(Icons.menu, color: AppColors.background)
                          ],
                        ),
                      ),
                      SizedBox(height: Dimens.space_normal),
                      Container(
                          margin: EdgeInsets.only(top: 30, bottom: 10),
                          child: Text(
                            AppLocalizations.of(context)
                                .lbl_generall_information,
                            style: Theme.of(context).primaryTextTheme.headline3,
                          )),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 15,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context).lbl_parlour_name,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(_fOwnerFName);
                                    },
                                    controller: _cVenderName,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .hnt_parlour_name,
                                      contentPadding:
                                          EdgeInsets.only(top: 5, left: 10),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: "First Name",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle2,
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: "(",
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2,
                                      ),
                                      TextSpan(
                                        text: "Owner",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      TextSpan(
                                        text: ")",
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(_fOwnerLName);
                                    },
                                    focusNode: _fOwnerFName,
                                    controller: _cOwnerFName,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .hnt_owner_name,
                                      contentPadding:
                                          EdgeInsets.only(top: 5, left: 10),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: "Last Name",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle2,
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: "(",
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2,
                                      ),
                                      TextSpan(
                                        text: "Owner",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      TextSpan(
                                        text: ")",
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(_fPhoneNumber);
                                    },
                                    focusNode: _fOwnerLName,
                                    controller: _cOwnerLName,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .hnt_owner_name,
                                      contentPadding:
                                          EdgeInsets.only(top: 5, left: 10),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  AppLocalizations.of(context).lbl_phone_number,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: TextFormField(
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(_fAddress);
                                    },
                                    focusNode: _fPhoneNumber,
                                    controller: _cPhoneNumber,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .hnt_phone_number,
                                      contentPadding:
                                          EdgeInsets.only(top: 5, left: 10),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    AppLocalizations.of(context).lbl_address,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle2,
                                  ),
                                ),
                                CSCPicker(
                                  onCountryChanged: (value) {
                                    setState(() {
                                      countryValue = value;
                                    });
                                  },
                                  onStateChanged: (value) {
                                    setState(() {
                                      stateValue = value;
                                    });
                                  },
                                  onCityChanged: (value) {
                                    setState(() {
                                      cityValue = value;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    focusNode: _fAddress,
                                    controller: _cAddress,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .hnt_address,
                                      contentPadding:
                                          EdgeInsets.only(top: 10, left: 10),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .lbl_saloon_type,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle2,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                              value: 1,
                                              groupValue: _saloonType,
                                              onChanged: (val) {
                                                setState(() {
                                                  _saloonType = val;
                                                });
                                              }),
                                          Text(AppLocalizations.of(context)
                                              .lbl_male)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                              value: 2,
                                              groupValue: _saloonType,
                                              onChanged: (val) {
                                                setState(() {
                                                  _saloonType = val;
                                                });
                                              }),
                                          Text(AppLocalizations.of(context)
                                              .lbl_female)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                              value: 3,
                                              groupValue: _saloonType,
                                              onChanged: (val) {
                                                setState(() {
                                                  _saloonType = val;
                                                });
                                              }),
                                          Text("Unisex")
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .lbl_description,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controller: _cDescription,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .hnt_description,
                                      contentPadding:
                                          EdgeInsets.only(top: 10, left: 10),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .lbl_upload_image,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle2,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          children: [
                                            CircleAvatar(
                                              radius: 50,
                                              backgroundImage: _tImage != null
                                                  ? FileImage(_tImage)
                                                  : AssetImage(
                                                      'assets/userImage.png'),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                _showCupertinoModalSheet();
                                              },
                                              child: CircleAvatar(
                                                radius: 20,
                                                child: Icon(Icons.image),
                                              ),
                                            )
                                          ]),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    signUp();
                                  },
                                  child: Container(
                                    height: 50,
                                    margin: EdgeInsets.only(top: 25),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: AppColors.dotColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimens.space_normal)),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .btn_create_account,
                                        style:
                                            TextStyle(color: AppColors.surface),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .txt_already_have_an_account,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignInScreen(
                                                        a: widget.analytics,
                                                        o: widget.observer,
                                                      )));
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .btnSignIn,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headline1,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: Dimens.space_large)
                              ],
                            ),
                          ),
                        ),
                      )
                    ]))),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  signUp() async {
    try {
      user.vendor_email = email;

      user.vendor_password = password;
      user.vendor_address = _cAddress.text.trim();
      user.vendor_name = _cVenderName.text.trim();
      user.vendor_phone = _cPhoneNumber.text.trim();
      user.description = _cDescription.text.trim();
      user.firstname = _cOwnerFName.text.trim();
      user.lastname = _cOwnerLName.text.trim();
      user.city = cityValue.toString();

      if (_saloonType != null) {
        user.type = _saloonType;
      }
      user.vendor_image = _tImage;

      user.device_id = global.appDeviceId;
      if (_cVenderName.text.isNotEmpty &&
          _cPhoneNumber.text.isNotEmpty &&
          _cOwnerFName.text.isNotEmpty &&
          _cOwnerLName.text.isNotEmpty &&
          cityValue != null &&
          _cAddress.text.isNotEmpty &&
          _cDescription.text.isNotEmpty &&
          _tImage != null) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper
              .signUp(
                  user.type,
                  user.vendor_name,
                  user.firstname,
                  user.lastname,
                  user.vendor_email,
                  user.vendor_password,
                  user.device_id,
                  user.vendor_phone,
                  user.vendor_address,
                  user.description,
                  user.city,
                  _tImage)
              .then((result) {
            if (result == 'Registered Successfully') {
              hideLoader();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => UpdateProfileSuccessDialog(
                        a: widget.analytics,
                        o: widget.observer,
                        msg: 'signed up',
                      ));
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: result);
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (_cVenderName.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_parlour_name);
      } else if (_cOwnerFName.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: "Please Enter First Name");
      } else if (_cOwnerLName.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: "Please Enter Last Name");
      } else if (_cPhoneNumber.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_phone_number);
      } else if (cityValue == null) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please select City.');
      } else if (_cAddress.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_address);
      } else if (_cDescription.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_description);
      } else if (_tImage == null) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_select_image);
      }
    } catch (e) {
      print("Exception - generalInformationScreen.dart - _signUp():" +
          e.toString());
    }
  }

  _showCupertinoModalSheet() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(
            AppLocalizations.of(context).lbl_action,
          ),
          actions: [
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context).lbl_take_picture,
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.openCamera();
                hideLoader();

                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context).lbl_choose_from_library,
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.selectImageFromGallery();
                hideLoader();

                setState(() {});
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(AppLocalizations.of(context).lbl_cancel,
                style: TextStyle(color: Color(0xFF41145a))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print(
          "Exception - generalInformationScreen.dart - _showCupertinoModalSheet():" +
              e.toString());
    }
  }
}
