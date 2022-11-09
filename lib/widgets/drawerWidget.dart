import 'package:app/screens/ApplyDeal.dart';
import 'package:app/screens/DealsListScreen.dart';
import 'package:app/screens/ServicesWithDeals.dart';
import 'package:app/screens/addDeals.dart';
import 'package:app/screens/reviewScreen.dart';

import '../models/businessLayer/base.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/screens/SupportScreen.dart';
import 'package:app/screens/appointmentHistoryScreen.dart';
import 'package:app/screens/changePasswordScreen.dart';
import 'package:app/screens/couponListScreen.dart';
import 'package:app/screens/helpAndSupportScreen.dart';
import 'package:app/screens/myWalletScreen.dart';
import 'package:app/screens/serviceListScreen.dart';
import 'package:app/screens/settingScreen.dart';
import 'package:app/screens/signInScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screens/AddTimeTable.dart';

class DrawerWidget extends BaseRoute {
  DrawerWidget({a, o}) : super(a: a, o: o, r: 'DrawerWidget');
  @override
  _DrawerWidgetState createState() => new _DrawerWidgetState();
}

class _DrawerWidgetState extends BaseRouteState {
  _DrawerWidgetState() : super();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.dotColor,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 08),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  child: global.user.shop_image == null
                      ? CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                            'assets/userImage.png',
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: global.baseUrlForImage +
                              "venders/" +
                              global.user.shop_image,
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            radius: 25,
                            backgroundImage: imageProvider,
                          ),
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                ),
                title: Text.rich(TextSpan(
                    style: Theme.of(context).primaryTextTheme.button,
                    text: global.user.firstname != null
                        ? global.user.firstname.toUpperCase() + " "
                        : ' ',
                    children: <InlineSpan>[
                      TextSpan(
                        text: global.user.lastname != null
                            ? global.user.lastname.toUpperCase()
                            : ' ',
                        style: Theme.of(context).primaryTextTheme.button,
                      )
                    ])),
                subtitle: Text(
                  global.user.vendor_phone != null
                      ? '${global.user.vendor_phone}'
                      : '',
                  style: Theme.of(context).primaryTextTheme.headline5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Image.asset("assets/wallet_icon.png",
                    scale: Dimens.space_small),
                title: Text(
                  AppLocalizations.of(context).lbl_my_wallet,
                  style: Theme.of(context).primaryTextTheme.button,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => MyWalletScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Image.asset("assets/service_icon.png",
                    scale: Dimens.space_small),
                title: Text(
                  "Services",
                  style: Theme.of(context).primaryTextTheme.button,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ServiceListScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Image.asset("assets/coupon_icon.png",
                    scale: Dimens.space_small),
                title: Text(
                  'Deal Services',
                  style: Theme.of(context).primaryTextTheme.button,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ServicesWithDealsScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Image.asset("assets/expert_icon.png",
                    scale: Dimens.space_small),
                title: Text(
                  'Time Table',
                  style: Theme.of(context).primaryTextTheme.button,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => AddTimings(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Image.asset("assets/coupon_icon.png",
                    scale: Dimens.space_small),
                title: Text(
                  'Deals',
                  style: Theme.of(context).primaryTextTheme.button,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DealListScreen(
                            a: widget.analytics,
                            o: widget.observer,
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Image.asset("assets/expert_icon.png",
                    scale: Dimens.space_small),
                title: Text(
                  'Reviews',
                  style: Theme.of(context).primaryTextTheme.button,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ReviewScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Image.asset("assets/password_icon.png",
                    scale: Dimens.space_small),
                title: Text(
                  AppLocalizations.of(context).lbl_change_password,
                  style: Theme.of(context).primaryTextTheme.button,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen(
                              false,
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Image.asset("assets/setting_icon.png",
                    scale: Dimens.space_small),
                title: Text(
                  AppLocalizations.of(context).lbl_settings,
                  style: Theme.of(context).primaryTextTheme.button,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => SettingScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Image.asset("assets/help_icon.png",
                    scale: Dimens.space_small),
                title: Text(
                  AppLocalizations.of(context).lbl_help_and_support,
                  style: Theme.of(context).primaryTextTheme.button,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => HelpAndSupportScreen(
                            a: widget.analytics,
                            o: widget.observer,
                          ));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Image.asset("assets/help_icon.png",
                    scale: Dimens.space_small),
                title: Text(
                  'Support',
                  style: Theme.of(context).primaryTextTheme.button,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => SupportScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                ServiceListScreen.serviceList = [];
                AppointmentHistoryScreen.appointmentHistoryList = [];
                CouponListScreen.couponList = [];
                _confirmationDialog();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.space_xxxxxxlarge,
                  vertical: Dimens.space_normal,
                ),
                child: Container(
                  height: Dimens.space_xxxxlarge,
                  child: Center(
                    child: Text(AppLocalizations.of(context).lbl_sign_out,
                        style: TextStyle(color: AppColors.surface)),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;

  @override
  void initState() {
    Base.count = 0;
    super.initState();
  }

  Future _confirmationDialog() async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context).lbl_sign_out,
            ),
            content: Text(AppLocalizations.of(context)
                .txt_confirmation_message_for_sign_out),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context).lbl_no),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(AppLocalizations.of(context).lbl_yes),
                onPressed: () async {
                  global.sp.remove("currentUser");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => SignInScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              )
            ],
          );
        });
  }
}
