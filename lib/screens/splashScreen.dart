import 'dart:async';
import 'dart:convert';

import 'package:app/models/businessLayer/apiHelper.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/partnerUserModel.dart';
import 'package:app/provider/local_provider.dart';
import 'package:app/screens/introScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SplashScreen extends BaseRoute {
  static var token;
  SplashScreen({a, o,token}) : super(a: a, o: o, r: 'SplashScreen');
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends BaseRouteState {
  bool isloading = true;
  GlobalKey<ScaffoldState> _scaffoldKey;

  _SplashScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return sc(
      Scaffold(
          body: Image.asset(
            'assets/splash.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          )
      //     Container(
      //   decoration: BoxDecoration(gradient: LinearGradient(stops: [0.75, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColorLight])),
      //   child: Container(
      //     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.28),
      //     child: Center(
      //       child: Column(
      //         children: [
      //           CircleAvatar(
      //             radius: 55,
      //             backgroundImage: AssetImage('assets/appicon_120x120.png'),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(top: 15),
      //             child: Text(
      //               AppLocalizations.of(context).lbl_gofresha,
      //               style: TextStyle(color: Colors.black, fontSize: 27, fontWeight: FontWeight.w100),
      //             ),
      //           ),
      //           Container(
      //               margin: EdgeInsets.only(top: 140),
      //               child: Text(
      //                 AppLocalizations.of(context).lbl_loading,
      //                 style: TextStyle(color: Colors.black, fontSize: 17),
      //               ))
      //         ],
      //       ),
      //     ),
      //   ),
      // )
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

  _getCurrency() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getCurrency().then((result) {
          if (result != null) {
            if (result.status == "1") {
              global.currency = result.recordList;

              setState(() {});
            } else {
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - splashScreen.dart - _getCurrency(): " + e.toString());
    }
  }

  void _init() async {
    try {
      await br.getSharedPreferences();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final provider = Provider.of<LocaleProvider>(context, listen: false);
        if (global.sp.getString("selectedLang") == null) {
          var locale = provider.locale ?? Locale('en');
          global.languageCode = locale.languageCode;
        } else {
          global.languageCode = global.sp.getString("selectedLang");
          provider.setLocale(Locale(global.languageCode));
        }
        if (global.rtlLanguageCodeLList.contains(global.languageCode)) {
          global.isRTL = true;
        } else {
          global.isRTL = false;
        }
      });
      var duration = Duration(seconds: 1);
      Timer(duration, () async {
        global.appDeviceId = await FirebaseMessaging.instance.getToken();
        await _getCurrency();
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          if (global.sp.getString('currentUser') != null) {
            global.user = CurrentUser.fromJson(json.decode(global.sp.getString("currentUser")));
            APIHelper.vid=global.user.venderId;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BottomNavigationWidget(
                      a: widget.analytics,
                      o: widget.observer,
                    )));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IntroScreen(
                      a: widget.analytics,
                      o: widget.observer,
                    )));
          }
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      });
    } catch (e) {
      print("Exception - splashScreen.dart - init():" + e.toString());
    }
  }
}
