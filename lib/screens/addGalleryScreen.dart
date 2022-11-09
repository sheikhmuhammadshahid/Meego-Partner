import 'dart:io';
import 'dart:ui';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/galleryModel.dart';
import 'package:app/models/serviceModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/screens/galleryListScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddGalleryScreen extends BaseRoute {
  final Service service;

  AddGalleryScreen({a, o, this.service}) : super(a: a, o: o, r: 'AddGalleryScreen');
  @override
  _AddGalleryScreenState createState() => new _AddGalleryScreenState(this.service);
}

class _AddGalleryScreenState extends BaseRouteState {
  Service service = new Service();
  File _tImage;
  Gallery _gallery = new Gallery();
  GlobalKey<ScaffoldState> _scaffoldKey;
  var dropdownval;

  _AddGalleryScreenState(this.service) : super();

  @override
  Widget build(BuildContext context) {
    return sc(
      WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
            // resizeToAvoidBottomInset: false,
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
                  // margin: EdgeInsets.only(top: 80),
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
                              AppLocalizations.of(context).lbl_Add_gallery,
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
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      AppLocalizations.of(context).lbl_upload_image,
                                      style: Theme.of(context).primaryTextTheme.subtitle2,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2, color: Theme.of(context).inputDecorationTheme.enabledBorder.borderSide.color),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(top: 5),
                                    height: 300,
                                    width: MediaQuery.of(context).size.width,
                                    child: _tImage == null
                                        ? service == null
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
                                                    imageUrl: global.baseUrlForImage + service.service_image,
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width*0.25,
                            vertical: Dimens.space_medium,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              _addGallery();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: Center(
                                child: Text(
                                    AppLocalizations.of(context).btn_save_gallery,
                                    style: TextStyle(
                                        color: AppColors.surface
                                    )),
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.dotColor,
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                        )
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
    _init();
  }

  _addGallery() async {
    try {
      _gallery.vendor_id = global.user.id;

      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();

        if (_tImage != null) {
          await apiHelper.addGallery(_gallery.vendor_id, _tImage).then((result) {
            if (result.status == "1") {
              hideLoader();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GalleryListScreen(
                        a: widget.analytics,
                        o: widget.observer,
                        screenId: 1,
                      )));
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
            }
          });
        } else {
          hideLoader();
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_select_image);
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - addgalleryScreen.dart - _addGallery():" + e.toString());
    }
  }

  _init() async {}

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
      print("Exception - addGalleryScreen.dart - _showCupertinoModalSheet():" + e.toString());
    }
  }
}
