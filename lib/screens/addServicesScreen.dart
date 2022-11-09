import 'dart:convert';

import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;


import 'package:app/dialogs/saveServiceDialog.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/serviceModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddServiceScreen extends BaseRoute {
  final Service service;
 static String selectedCategory="Select Category";
  static List<String> categoryIds=[];
 static List<DropdownMenuItem<String>> items=[];
  AddServiceScreen({a, o, this.service}) : super(a: a, o: o, r: 'AddServiceScreen');
  @override
  _AddServiceScreenState createState() => new _AddServiceScreenState(this.service);
}

class _AddServiceScreenState extends BaseRouteState {


  String selected='';
  //String selectedInd="";


  Service service = new Service();
  File _tImage;
  TextEditingController _cServiceName = new TextEditingController();
  TextEditingController _cServiceDescription = new TextEditingController();
  TextEditingController _cServiceRate = new TextEditingController();
  TextEditingController _cServiceTime = new TextEditingController();

  Service _service = new Service();
  GlobalKey<ScaffoldState> _scaffoldKey;
  var dropdownval;

  _AddServiceScreenState(this.service) : super();

  @override
  Widget build(BuildContext context) {



    return AddServiceScreen.items.isNotEmpty? sc(
      WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();

          return null;
        },
        child:Scaffold(
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
                                  Text(' ')
                                ],
                              ),
                            ),
                            SizedBox(height: Dimens.space_normal),
                            Container(
                                decoration: BoxDecoration(
                                    color: AppColors.background,
                                ),
                                margin: EdgeInsets.only(top: 30, bottom: 10),
                                child: Text(
                                  service != null ? AppLocalizations.of(context).lbl_edit_service : AppLocalizations.of(context).lbl_Add_service,
                                  style: Theme.of(context).primaryTextTheme.headline3,
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
                                          AppLocalizations.of(context).lbl_service_name,
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          textCapitalization: TextCapitalization.words,
                                          controller: _cServiceName,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context).hnt_service_name,
                                            contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text("Category: ",
                                          // AppLocalizations.of(context).lbl_service_rate,
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                      ), Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child:AddServiceScreen.items!=null? SizedBox(

                                          child: DropdownButtonFormField(

                                            alignment: Alignment.center,
                                              enableFeedback: true,
                                              value: selected==""? AddServiceScreen.items[0].value:AddServiceScreen.items.where((element) => element.value==selected).first.value,
                                              onChanged: (String newValue){
                                                setState(() {
                                                  AddServiceScreen.selectedCategory = newValue;
                                                  selected=newValue;
                                                });
                                              },
                                              items: AddServiceScreen.items
                                          ),
                                        ):null
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text("Service Rate",
                                         // AppLocalizations.of(context).lbl_service_rate,
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          textCapitalization: TextCapitalization.words,
                                          controller: _cServiceRate,
                                          decoration: InputDecoration(
                                            hintText:service==null? "100,200 etc.":service.rate+" Rs",//AppLocalizations.of(context).hnt_service_rate,
                                            contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text("Service Time",
                                          //AppLocalizations.of(context).lbl_service_time,
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          textCapitalization: TextCapitalization.words,
                                          controller: _cServiceTime,
                                          decoration: InputDecoration(
                                            hintText: service==null? "1hour,2hour,30mnt":service.Time+"Hours",//AppLocalizations.of(context).hnt_service_time,
                                            contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text("Service Description",
                                          //AppLocalizations.of(context).lbl_service_time,
                                          style: Theme.of(context).primaryTextTheme.subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          textCapitalization: TextCapitalization.words,
                                          maxLines: 5,
                                          controller: _cServiceDescription,
                                          decoration: InputDecoration(
                                            hintText: "This is a Description",//AppLocalizations.of(context).hnt_service_time,
                                            contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10),
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
                                                        imageUrl: global.baseUrlForImage+"Services/" + service.service_image,
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
                            ElevatedButton(onPressed: (){}, child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width*0.25,
                                vertical: Dimens.space_medium,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  _addService();
                                },
                                child: Container(

                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                        AppLocalizations.of(context).btn_save_service,
                                        style: TextStyle(
                                            color: AppColors.surface
                                        )),
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppColors.dotColor,
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                ),
                              ),
                            ), )
                          ],

                        ),
                      )
              ),
            ),

        ),
      ),
    ):Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20),
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey,
          color: Colors.purple,
        )
    );

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
      _init();



  }

  _addService() async {
    try {
      _service.vendor_id = global.user.venderId;
      _service.service_name = _cServiceName.text.trim();

      if (_cServiceName.text.isNotEmpty) {
        if(AddServiceScreen.selectedCategory.isNotEmpty) {
          if(_cServiceRate.text.isNotEmpty) {
            if(_cServiceTime.text.isNotEmpty) {
              bool isConnected = await br.checkConnectivity();
              if (isConnected) {
                showOnlyLoaderDialog();

                if (_service.service_id == null) {
                  if (_tImage != null) {
                    await apiHelper.addService(
                        global.user.id,
                        _service.service_name,
                        AddServiceScreen.selectedCategory,
                        _cServiceRate.text,
                        _cServiceTime.text,
                        _tImage,
                        _cServiceDescription.text).then((result) {
                      if (result.status == "1") {
                        hideLoader();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                SaveServiceDialog(
                                  a: widget.analytics,
                                  o: widget.observer,
                                ));
                      } else {
                        hideLoader();
                        showSnackBar(key: _scaffoldKey,
                            snackBarMessage: '${result.message}');
                      }
                    });
                  } else {
                    hideLoader();
                    showSnackBar(
                        key: _scaffoldKey, snackBarMessage: AppLocalizations
                        .of(context)
                        .txt_please_select_image);
                  }
                } else //update
                    {
                  await apiHelper.editService(
                      global.user.id,
                      _service.service_id,
                      _service.service_name,
                      AddServiceScreen.selectedCategory,
                      _cServiceRate.text,
                      _cServiceTime.text,
                      _tImage,
                      _cServiceDescription.text).then((result) {
                    if (result != null) {
                      hideLoader();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SaveServiceDialog(
                                a: widget.analytics,
                                o: widget.observer,
                                msg: "updated",

                              ));
                    } else {
                      hideLoader();
                      showSnackBar(
                          key: _scaffoldKey, snackBarMessage: 'Not Updated!');
                    }
                  });
                }
              } else {
                showNetworkErrorSnackBar(_scaffoldKey);
              }
            }
            else{
              showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please Enter Time');
            }
          }
          else{
            showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please Enter Rate');
          }
        }
        else{
          showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please Select Category');

        }
      } else if (_cServiceName.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_name);
      }
    } catch (e) {
      print("Exception - addServicesScreen.dart - _addService():" + e.toString());
    }
  }

  _init() async {
    try {

      if (service != null) {
        if (service.service_id != null) {
          _cServiceTime.text=service.Time;
          _cServiceRate.text=service.rate;
          selected=AddServiceScreen.categoryIds.where((element) => element.split(':')[0]==service.categoryId).first.split(':')[1];
          _cServiceName.text = service.service_name;
          AddServiceScreen.selectedCategory=selected;
         // _tImage=File(global.baseUrlForImage+"Services/" + service.service_image);
          _service.service_id = service.service_id;
          _cServiceDescription.text=service.description;
            }

      }

    } catch (e) {
      print("Exception - addServiceScreen.dart - init():" + e.toString());
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
                
                setState(() {

                });
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
      print("Exception - addServicesScreen.dart - _showCupertinoModalSheet():" + e.toString());
    }
  }
}
