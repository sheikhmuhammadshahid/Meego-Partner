import 'dart:io';

import 'package:app/dialogs/settingSaveDialog.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends BaseRoute {
  SettingScreen({a, o}) : super(a: a, o: o, r: 'SettingScreen');
  @override
  _SettingScreenState createState() => new _SettingScreenState();
}

class _SettingScreenState extends BaseRouteState {
  bool shopValue = false;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String onlineStatus;
  bool isloading = true;

  _SettingScreenState() : super();

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
              decoration: BoxDecoration(
                  color: AppColors.background,
                  image: DecorationImage(
                      image: AssetImage("assets/partner_background.png")
                  )
              ),
              // margin: EdgeInsets.only(top: 80),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
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
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(AppLocalizations.of(context).lbl_settings,
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_medium),
                    child: Card(
                      color: AppColors.surface,
                      margin: EdgeInsets.only(top: 8),
                      child: ListTile(
                        title: Text(AppLocalizations.of(context).lbl_shop_open),
                        trailing: Switch(
                          value: shopValue,
                          onChanged: (val) {
                            setState(() {
                              shopValue = val;
                            });
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          floatingActionButton: Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                _saveSetting();
              },
              child: Container(
                height: 40,
                child: Center(
                  child: Text(
                      AppLocalizations.of(context).btn_save_setting,
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

  @override
  void initState() {
    super.initState();

    if (global.user.online_status != null) {
      if (global.user.online_status == "ON") {
        setState(() {
          shopValue = true;
        });
      } else {
        setState(() {
          shopValue = false;
        });
      }
    }
  }

  _saveSetting() async {
    try {
      if (shopValue) {
        setState(() {
          onlineStatus = "ON";
        });
      } else {
        setState(() {
          onlineStatus = "OFF";
        });
      }
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.setting(global.user.venderId, onlineStatus).then((result) async {
          if (result) {
            hideLoader();


              global.user.online_status = onlineStatus;
              br.saveUser(global.user);

            showDialog(
                context: context,
                builder: (BuildContext context) => SettingSaveDialog(
                      a: widget.analytics,
                      o: widget.observer,
                    ));
          } else {
            hideLoader();
            showSnackBar(key: _scaffoldKey, snackBarMessage: 'Status Not Changed');

          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {}
  }
}
