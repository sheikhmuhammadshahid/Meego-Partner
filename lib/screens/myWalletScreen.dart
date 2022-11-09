import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/myWalletModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/screens/walletDetailScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class MyWalletScreen extends BaseRoute {
  final int screenId;
  MyWalletScreen({a, o, this.screenId}) : super(a: a, o: o, r: 'MyWalletScreen');
  @override
  _MyWalletScreenState createState() => new _MyWalletScreenState(screenId: screenId);
}

class _MyWalletScreenState extends BaseRouteState {
  MyWallet _myWallet = new MyWallet();
  GlobalKey<ScaffoldState> _scaffoldKey;
  bool _isDataLoaded = false;
  int screenId;
  _MyWalletScreenState({this.screenId}) : super();

  @override
  Widget build(BuildContext context) {
    return sc(
      WillPopScope(
        onWillPop: () {
          screenId == 1
              ? Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationWidget(
                            a: widget.analytics,
                            o: widget.observer,
                          )),
                )
              : Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
            body: Container(
              color: AppColors.background,
              child: SingleChildScrollView(
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
                          screenId == 1
                              ? Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => BottomNavigationWidget(
                                  a: widget.analytics,
                                  o: widget.observer,
                                )),
                          )
                              : Navigator.of(context).pop();
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
                          Container(
                              margin: EdgeInsets.only(top: 30, bottom: 5),
                              child: Text(
                                AppLocalizations.of(context).lbl_my_wallet,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimens.space_xlarge
                                ),
                              )),
                          SizedBox(height: Dimens.space_medium),
                          _isDataLoaded
                              ? Expanded(
                                  child: ListView(
                                  children: [
                                   getWidget('Total Earnings'),
                                    SizedBox(height: Dimens.space_medium),
                                    getWidget('To Pay'),
                                    SizedBox(height: Dimens.space_medium),

                                   ])):_shimmer()

                        ],
                      ),
                    ))
          ],
        ),
              ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }


  Widget getWidget(label)
  {
    return Container(
        height: 55,
        margin: EdgeInsets.only(bottom: 5),
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 5,
          color: AppColors.surface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Column(
                  children: [
                    Padding(
                      padding: global.isRTL ? EdgeInsets.only(right: 10, top: 10) : EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        label=='Total Earnings'?label:'Balance Amount',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                            color: AppColors.primary
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: global.isRTL ? EdgeInsets.only(left: 10) : EdgeInsets.only(right: 10),
                height: 30,


                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(Dimens.radius_xxxsmall),
                    border: Border.all(color: Theme.of(context).primaryColor, width: 1)),
                padding: EdgeInsets.only(left: 5, right: 2, top: 2, bottom: 2),
                child: Center(
                    child: Text(
                      label=='To Pay'?  ' ${global.currency.currency_sign}: ${(_myWallet.toGet)-_myWallet.toPay}'
                          :' ${global.currency.currency_sign}: ${_myWallet.total_price}',

                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(

                          color: AppColors.surface

                      ),
                    )),
              ),
            ],
          ),
        ));
  }
  getMyWallet() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getMyWallet(global.user.venderId).then((result) {
          if (result != null) {

              _myWallet = result;

          }
          else {

          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - myWalletScreen.dart - getMyWallet():" + e.toString());
    }
  }

  init() async {
    try {
      await getMyWallet();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - myWalletScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 55,
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(),
              );
            }),
      ),
    );
  }
}
