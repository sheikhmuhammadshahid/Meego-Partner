import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/expertModel.dart';
import 'package:app/models/shareSendPendingModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalletDetailScreen extends BaseRoute {
  final String name;
  final List<ShareSentPending> shareList;

  WalletDetailScreen(this.name, this.shareList, {a, o}) : super(a: a, o: o, r: 'WalletDetailScreen');
  @override
  _WalletDetailScreenState createState() => new _WalletDetailScreenState(this.shareList, this.name);
}

class _WalletDetailScreenState extends BaseRouteState {
  String name;
  List<ShareSentPending> shareList = [];
  GlobalKey<ScaffoldState> _scaffoldKey;

  Expert experts = new Expert();
  _WalletDetailScreenState(this.shareList, this.name) : super();

  @override
  Widget build(BuildContext context) {
    return sc(
      WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
          bottomNavigationBar: (name == 'Total Admin Share pending at Vendor') && (shareList.length > 0)
              ? Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _paidToAdminConfirmationDialog(global.user);
                    },
                    child: Text(
                      AppLocalizations.of(context).btn_mask_as_paid,
                    ),
                  ),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(10))),
                )
              : SizedBox(),
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
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
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
                    SizedBox(height: Dimens.space_normal),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width*0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/image_vendor.png"),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                    SizedBox(height: Dimens.space_normal),
                    Container(
                        margin: EdgeInsets.only(top: 30, bottom: 10),
                        child: Text(
                          '$name',
                          style: Theme.of(context).primaryTextTheme.headline3,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        )),
                    shareList.length > 0
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: shareList.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    color: AppColors.surface,
                                      margin: EdgeInsets.only(top: 8),
                                      child: Padding(
                                        padding: const EdgeInsets.all(Dimens.space_medium),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${shareList[index].cart_id}',
                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                  ),
                                                  Text(
                                                    '${shareList[index].mobile}',
                                                    style: Theme.of(context).primaryTextTheme.subtitle1,
                                                  ),
                                                  Text(
                                                    '${shareList[index].service_date}',
                                                    style: Theme.of(context).primaryTextTheme.subtitle1,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 30,
                                                      width: 130,
                                                      decoration: BoxDecoration(
                                                          color: shareList[index].statustext == "Pending"
                                                              ? Colors.amber
                                                              : shareList[index].statustext == "Completed"
                                                                  ? Colors.green[600]
                                                                  : shareList[index].statustext == "Cancelled"
                                                                      ? Colors.grey
                                                                      : shareList[index].statustext == "Payment Failed"
                                                                          ? Colors.red
                                                                          : shareList[index].statustext == "Confirmed"
                                                                              ? Colors.blue[600]
                                                                              : Colors.red,
                                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                                      padding: EdgeInsets.all(4),
                                                      child: Center(
                                                        child: Text(
                                                          '${shareList[index].statustext}',
                                                          style: Theme.of(context).primaryTextTheme.headline5.copyWith(color: Theme.of(context).primaryTextTheme.headline5.color.withOpacity(0.8)),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                      top: 5,
                                                      bottom: 2,
                                                    ),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          child: Container(
                                                            width: 70,
                                                            decoration: BoxDecoration(
                                                              borderRadius: global.isRTL
                                                                  ? BorderRadius.only(
                                                                      topRight: new Radius.circular(5.0),
                                                                      bottomRight: new Radius.circular(5.0),
                                                                    )
                                                                  : BorderRadius.only(
                                                                      topLeft: new Radius.circular(5.0),
                                                                      bottomLeft: new Radius.circular(5.0),
                                                                    ),
                                                              color: Colors.grey[350],
                                                              border: new Border.all(
                                                                color: Colors.grey[350],
                                                              ),
                                                            ),
                                                            height: 25,
                                                            child: Center(
                                                              child: Text(
                                                                '${shareList[index].paymentStatus}',
                                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 25,
                                                          width: 70,
                                                          child: Center(
                                                            child: Text(
                                                              "${global.currency.currency_sign}${shareList[index].total_price}",
                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
                                                            ),
                                                          ),
                                                          decoration: BoxDecoration(
                                                            borderRadius: global.isRTL
                                                                ? BorderRadius.only(
                                                                    topLeft: new Radius.circular(5.0),
                                                                    bottomLeft: new Radius.circular(5.0),
                                                                  )
                                                                : BorderRadius.only(
                                                                    topRight: new Radius.circular(5.0),
                                                                    bottomRight: new Radius.circular(5.0),
                                                                  ),
                                                            border: new Border.all(
                                                              color: Colors.grey[350],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                }),
                          )
                        : Container(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
                            child: Text(
                              AppLocalizations.of(context).txt_nothing_yet_to_see_here,
                              style: Theme.of(context).primaryTextTheme.subtitle2,
                            ),
                          )
                  ],
                ),
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

  _paidToAdmin(int vendorId) async {
    bool isConnected = await br.checkConnectivity();
    if (isConnected) {
      showOnlyLoaderDialog();
      await apiHelper.paidToAdmin(vendorId).then((result) {
        if (result.status == "1") {
          Navigator.of(context).pop();
          showSnackBar(key: _scaffoldKey, snackBarMessage: "${result.message}");
        } else {
          Navigator.of(context).pop();

          showSnackBar(key: _scaffoldKey, snackBarMessage: "${result.message}");
        }
      });
    } else {
      showNetworkErrorSnackBar(_scaffoldKey);
    }
  }

  Future _paidToAdminConfirmationDialog(vendorId) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context).lbl_confirm_dialog,
            ),
            content: Text(AppLocalizations.of(context).txt_confirmation_message_for_paid_to_admin),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context).lbl_no),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(AppLocalizations.of(context).lbl_yes),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _paidToAdmin(vendorId);
                },
              )
            ],
          );
        });
  }
}
