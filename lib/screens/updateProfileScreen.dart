import 'dart:io';

import 'package:app/dialogs/updateProfileSuccessDialog.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/partnerUserModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateProfileScreen extends BaseRoute {
  final CurrentUser userFromProfile;

  UpdateProfileScreen(this.userFromProfile, {a, o})
      : super(a: a, o: o, r: 'UpdateProfileScreen');
  @override
  _UpdateProfileScreenState createState() =>
      new _UpdateProfileScreenState(this.userFromProfile);
}

class _UpdateProfileScreenState extends BaseRouteState {
  CurrentUser userFromProfile;
  bool _isValidate = false;

  TextEditingController _cVenderName = new TextEditingController();
  TextEditingController _cOwnerFName = new TextEditingController();
  TextEditingController _cOwnerLName = new TextEditingController();
  TextEditingController _cPhoneNumber = new TextEditingController();
  TextEditingController _cAddress = new TextEditingController();
  TextEditingController _cDescription = new TextEditingController();
  TextEditingController _cEmail = new TextEditingController();
  File _tImage;

  var _fOwnerLName = new FocusNode();
  var _fOwnerFName = new FocusNode();
  var _fPhoneNumber = new FocusNode();
  var _fAddress = new FocusNode();
  var _fEmail = new FocusNode();

  GlobalKey<ScaffoldState> _scaffoldKey;
  var dropdownval;

  _UpdateProfileScreenState(
    this.userFromProfile,
  ) : super();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null;
        },
        child: sc(
          Scaffold(
            backgroundColor: AppColors.background,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.space_large),
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.background,
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/partner_background.png"))),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Dimens.space_large),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back)),
                                  Image.asset('assets/partner_logo.png',
                                      scale: 7.0),
                                  Text(' ')
                                ],
                              ),
                              SizedBox(height: Dimens.space_xxlarge),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        CircleAvatar(
                                          radius: 50,
                                          child: _tImage != null
                                              ? CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage:
                                                      FileImage(_tImage))
                                              : global.user.shop_image != null
                                                  ? CachedNetworkImage(
                                                      imageUrl: global
                                                              .baseUrlForImage +
                                                          "venders/" +
                                                          global
                                                              .user.shop_image,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          CircleAvatar(
                                                        radius: 50,
                                                        backgroundImage:
                                                            imageProvider,
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    )
                                                  : Image(
                                                      image: AssetImage(
                                                          'assets/userImage.png'),
                                                      color: Colors.transparent,
                                                    ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
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
                              SizedBox(height: Dimens.space_medium),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)
                                        .lbl_upload_image,
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimens.space_xlarge),
                              Text(
                                AppLocalizations.of(context).lbl_parlour_name,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 3, bottom: 3),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(_fEmail);
                                  },
                                  controller: _cVenderName,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .hnt_parlour_name,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, left: 10, right: 10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocalizations.of(context).lblEmail,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 3, bottom: 3),
                                child: TextFormField(
                                  focusNode: _fEmail,
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(_fOwnerFName);
                                  },
                                  onChanged: (val) {
                                    _isValidate = EmailValidator.validate(val);
                                  },
                                  textCapitalization: TextCapitalization.words,
                                  controller: _cEmail,
                                  decoration: InputDecoration(
                                    hintText:
                                        AppLocalizations.of(context).hnt_email,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, left: 10, right: 10),
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
                                  textCapitalization: TextCapitalization.words,
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
                                  textCapitalization: TextCapitalization.words,
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
                                padding:
                                    const EdgeInsets.only(top: 3, bottom: 3),
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  focusNode: _fPhoneNumber,
                                  controller: _cPhoneNumber,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .hnt_phone_number,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, left: 10, right: 10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocalizations.of(context).lbl_address,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 3, bottom: 3),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  focusNode: _fAddress,
                                  controller: _cAddress,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .hnt_address,
                                    contentPadding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  AppLocalizations.of(context).lbl_description,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 3, bottom: 3),
                                child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: _cDescription,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .hnt_address,
                                    contentPadding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal:
                            Dimens.space_xxxxxxlarge + Dimens.space_xxxlarge,
                        vertical: Dimens.space_large,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          updateProfile();
                        },
                        child: Container(
                          height: 40,
                          child: Center(
                            child: Text(
                                AppLocalizations.of(context).btn_update_profile,
                                style: TextStyle(color: AppColors.surface)),
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.dotColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
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
    _init();
  }

  updateProfile() async {
    try {
      if (_cVenderName.text.isNotEmpty &&
          _cPhoneNumber.text.isNotEmpty &&
          RegExp(r"^((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})$")
              .hasMatch(_cPhoneNumber.text) &&
          _isValidate) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper
              .updateProfile(
                  global.user.venderId,
                  _cVenderName.text.trim(),
                  _cOwnerFName.text.trim(),
                  _cOwnerLName.text.trim(),
                  _cPhoneNumber.text.trim(),
                  _cAddress.text.trim(),
                  _cDescription.text.trim(),
                  _cEmail.text.trim(),
                  _tImage)
              .then((result) async {
            if (result == "Updated Successfully") {
              br.saveUser(global.user);
              if (global.sp.getString('isRememberMeEmail') != null) {
                await global.sp
                    .setString('isRememberMeEmail', _cEmail.text.trim());
              }

              hideLoader();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => UpdateProfileSuccessDialog(
                        a: widget.analytics,
                        o: widget.observer,
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
      } else if (_cPhoneNumber.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_phone_number);
      } else if (_cOwnerFName.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: "Please Enter First Name");
      } else if (_cOwnerLName.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: "Please Enter Last Name");
      } else if (!RegExp(r"^((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})$")
          .hasMatch(_cPhoneNumber.text)) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage: AppLocalizations.of(context)
                .txt_please_enter_valid_phone_number);
      } else if (!_isValidate || _cEmail.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_valid_email);
      }
    } catch (e) {
      print("Exception - updateProfileScreen.dart - _updateProfile():" +
          e.toString());
    }
  }

  _init() {
    try {
      setState(() {
        _cVenderName.text = global.user.vendor_name;
        _cOwnerFName.text = global.user.firstname;
        _cOwnerLName.text = global.user.lastname;
        _cPhoneNumber.text = global.user.vendor_phone;
        _cAddress.text = global.user.vendor_address;
        _cDescription.text = global.user.description;
        _cEmail.text = global.user.vendor_email;
        _isValidate = EmailValidator.validate(global.user.vendor_email);
      });
    } catch (e) {
      print("Exception - updateProfileScreen.dart - _init():" + e.toString());
    }
  }

  _showCupertinoModalSheet() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(AppLocalizations.of(context).lbl_action),
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
          "Exception - updateProfileScreen.dart - _showCupertinoModalSheet():" +
              e.toString());
    }
  }
}
