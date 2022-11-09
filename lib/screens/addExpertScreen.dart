import 'dart:io';
import 'dart:ui';

import 'package:app/dialogs/saveExpertDialog.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/expertModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddExpertScreen extends BaseRoute {
  final Expert experts;
  AddExpertScreen({a, o, this.experts}) : super(a: a, o: o, r: 'AddExpertScreen');
  @override
  _AddExpertScreenState createState() => new _AddExpertScreenState(this.experts);
}

class _AddExpertScreenState extends BaseRouteState {
  Expert experts = new Expert();
  TextEditingController _cStaffName = new TextEditingController();
  TextEditingController _cStaffDescription = new TextEditingController();
  bool _showConfirmPassword = false;
  GlobalKey<ScaffoldState> _scaffoldKey;
  File _tImage;

  var _fEmail = FocusNode();
  var _fPassword = FocusNode();
  Expert _experts = new Expert();
  var dropdownval;
  _AddExpertScreenState(this.experts) : super();

  @override
  Widget build(BuildContext context) {
    return sc(
      WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
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
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
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
                                  Icon(Icons.menu)
                                ],
                              ),
                            ),
                            SizedBox(height: Dimens.space_normal),
                            Container(
                                margin: EdgeInsets.only(top: 30, bottom: 10),
                                child: Text(
                                  experts != null ? AppLocalizations.of(context).lbl_edit_expert : AppLocalizations.of(context).lbl_add_Expert,
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
                                    top: 15,
                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).lbl_expert_name,
                                        style: Theme.of(context).primaryTextTheme.subtitle2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          textCapitalization: TextCapitalization.words,
                                          controller: _cStaffName,
                                          focusNode: _fEmail,
                                          onFieldSubmitted: (val) {
                                            FocusScope.of(context).requestFocus(_fPassword);
                                          },
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context).hnt_expert_name,
                                            contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context).lbl_description,
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          textCapitalization: TextCapitalization.sentences,
                                          controller: _cStaffDescription,
                                          maxLines: 5,
                                          obscureText: _showConfirmPassword,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context).hnt_description,
                                            contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context).lbl_upload_image,
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.surface,
                                          border: Border.all(width: 2, color: Theme.of(context).inputDecorationTheme.enabledBorder.borderSide.color),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        margin: EdgeInsets.only(top: 5),
                                        height: 300,
                                        width: MediaQuery.of(context).size.width,
                                        child: _tImage == null
                                            ? experts == null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      _showCupertinoModalSheet();
                                                      setState(() {});
                                                    },
                                                    child: Center(
                                                        child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.image,
                                                          size: 55,
                                                          color: Theme.of(context).primaryTextTheme.headline1.color,
                                                        ),
                                                        Text(AppLocalizations.of(context).lbl_tap_to_add_image)
                                                      ],
                                                    )),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      _showCupertinoModalSheet();
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      child: CachedNetworkImage(
                                                        imageUrl: global.baseUrlForImage + experts.staff_image,
                                                        imageBuilder: (context, imageProvider) => Container(
                                                          height: 90,
                                                          decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.contain, image: imageProvider)),
                                                        ),
                                                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                      ),
                                                    ),
                                                  )
                                            : GestureDetector(
                                                onTap: () {
                                                  _showCupertinoModalSheet();
                                                },
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  child: Container(
                                                    decoration: BoxDecoration(image: DecorationImage(image: FileImage(_tImage), fit: BoxFit.contain)),
                                                  ),
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
                      )
              ),
            ),
          floatingActionButton:  Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width*0.25,
            ),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                _addExperts();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Center(
                  child: Text(
                      AppLocalizations.of(context).btn_save_expert,
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
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  init() async {
    try {
      if (experts != null) {
        if (experts.staff_id != null) {
          _cStaffName.text = experts.staff_name;
          _cStaffDescription.text = experts.staff_description;
          _experts.staff_id = experts.staff_id;
        }
      }
    } catch (e) {
      print("Exception - addExpertScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  _addExperts() async {
    try {
      _experts.vendor_id = global.user.id;
      _experts.staff_name = _cStaffName.text.trim();
      _experts.staff_description = _cStaffDescription.text.trim();

      if (_cStaffName.text.isNotEmpty && _cStaffDescription.text.isNotEmpty) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();

          if (_experts.staff_id == null) {
            if (_tImage != null) {
              await apiHelper.addExpert(_experts.vendor_id, _experts.staff_name, _experts.staff_description, _tImage).then((result) {
                if (result.status == "1") {
                  hideLoader();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => SaveExpertDialog(
                            a: widget.analytics,
                            o: widget.observer,
                          ));
                } else {
                  hideLoader();
                  showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
                }
              });
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_select_image);
            }
          } else //update
          {
            await apiHelper.editExpert(_experts.vendor_id, _experts.staff_name, _experts.staff_description, _tImage, _experts.staff_id).then((result) {
              if (result.status == "1") {
                hideLoader();
                showDialog(
                    context: context,
                    builder: (BuildContext context) => SaveExpertDialog(
                          a: widget.analytics,
                          o: widget.observer,
                        ));
              } else {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
              }
            });
          }
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (_cStaffName.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_name);
      } else if (_cStaffDescription.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_description);
      }
    } catch (e) {
      print("Exception - addExpertScreen.dart - addExpert():" + e.toString());
    }
  }

  _showCupertinoModalSheet() {
    try {
      FocusScope.of(context).unfocus();

      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(AppLocalizations.of(context).lbl_action),
          actions: [
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context).lbl_take_picture, style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.openCamera();
                hideLoader();

                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context).lbl_choose_from_library, style: TextStyle(color: Color(0xFF171D2C))),
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
            child: Text(AppLocalizations.of(context).lbl_cancel, style: TextStyle(color: Color(0xFF41145a))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print("Exception - addExpertScreen.dart - _showCupertinoModalSheet():" + e.toString());
    }
  }
}
