import 'dart:io';

import 'package:app/l10n/l10n.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/provider/local_provider.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ChooseLanguageScreen extends BaseRoute {
  ChooseLanguageScreen({a, o}) : super(a: a, o: o, r: 'ChooseLanguageScreen');
  @override
  _ChooseLanguageScreenState createState() => new _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends BaseRouteState {
  bool shopValue = false;
  String onlineStatus;
  bool isloading = true;

  _ChooseLanguageScreenState() : super();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    var locale = provider.locale ?? Locale('en');
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
                        Icon(Icons.menu)
                      ],
                    ),
                  ),
                  SizedBox(height: Dimens.space_xxlarge),
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(AppLocalizations.of(context).lbl_selet_language,
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                        )),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: L10n.languageListName.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.space_medium,
                              vertical: Dimens.space_medium,),
                          child: Container(
                            color: AppColors.surface,
                            child: RadioListTile(
                              activeColor: Theme.of(context).primaryColor,
                              value: L10n.all[index].languageCode,
                              groupValue: global.languageCode,
                              onChanged: (val) {
                                final provider = Provider.of<LocaleProvider>(context, listen: false);
                                locale = Locale(val);
                                provider.setLocale(locale);
                                global.languageCode = locale.languageCode;
                                global.sp.setString('selectedLang', global.languageCode);

                                if (global.rtlLanguageCodeLList.contains(locale.languageCode)) {
                                  global.isRTL = true;
                                } else {
                                  global.isRTL = false;
                                }
                                setState(() {});
                              },
                              title: Text(L10n.languageListName[index], style: Theme.of(context).primaryTextTheme.subtitle2),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )),
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
  }
}
