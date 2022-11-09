import 'package:app/models/businessLayer/baseRoute.dart';

import 'package:app/models/serviceModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import '../models/Deal.dart';
import '../models/DealServicesModel.dart';

import 'ServicesWithDeals.dart';

class ApplyDealScreen extends BaseRoute {
  final DealServicesModel coupon;
  ApplyDealScreen({a, o, this.coupon})
      : super(a: a, o: o, r: 'AddCouponScreen');
  @override
  _ApplyDealScreenState createState() => new _ApplyDealScreenState(this.coupon);
}

class _ApplyDealScreenState extends BaseRouteState {
  String _deals;
  String _dealCategory;
  String serviceName;
  List<Service> services = [];
  List<Deal> deals = [];
  DealServicesModel deal;
  _ApplyDealScreenState(this.deal);
  List<Deal> dealCategories = [];
  var _fdealName = FocusNode();
  var _fdiscount = FocusNode();
  List<DropdownMenuItem> dealstoShow = [];
  List<DropdownMenuItem> servicestoShow = [];
  List<DropdownMenuItem> dealsCategoriestoshow = [];
  GlobalKey<ScaffoldState> _scaffoldKey;
  var isLoading = true;
  @override
  Widget build(BuildContext context) {
    return sc(
      Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
              decoration: BoxDecoration(
                  color: AppColors.background,
                  image: DecorationImage(
                      image: AssetImage("assets/partner_background.png"))),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: !isLoading
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: Dimens.space_large),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.space_large),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          ),
                          SizedBox(height: Dimens.space_normal),
                          Container(
                              margin: EdgeInsets.only(
                                top: 30,
                                bottom: 10,
                              ),
                              child: Text('Deal Service',
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0))),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 15.0,
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Deal Category',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2,
                                      ),
                                    ),
                                    DropdownButtonFormField(
                                      items: dealsCategoriestoshow,
                                      hint: Text(
                                        'Select Category',
                                        style: Theme.of(context)
                                            .inputDecorationTheme
                                            .hintStyle,
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          _dealCategory = val;
                                        });
                                      },
                                      value: _dealCategory,
                                      isExpanded: true,
                                    ),
                                    Text(
                                      'Deal',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle2,
                                    ),
                                    DropdownButtonFormField(
                                      items: dealstoShow,
                                      hint: Text(
                                        'Select Deal',
                                        style: Theme.of(context)
                                            .inputDecorationTheme
                                            .hintStyle,
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          _deals = val;
                                        });
                                      },
                                      value: _deals,
                                      isExpanded: true,
                                    ),
                                    Text(
                                      'Service',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle2,
                                    ),
                                    DropdownButtonFormField(
                                      items: servicestoShow,
                                      hint: Text(
                                        'Select Service',
                                        style: Theme.of(context)
                                            .inputDecorationTheme
                                            .hintStyle,
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          serviceName = val;
                                        });
                                      },
                                      value: serviceName,
                                      isExpanded: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(14),
                            child: GestureDetector(
                              onTap: () {
                                _addCoupon();
                              },
                              child: Container(
                                height: 40,
                                child: Center(
                                  child: Text("Save Deal",
                                      style:
                                          TextStyle(color: AppColors.surface)),
                                ),
                                decoration: BoxDecoration(
                                    color: AppColors.dotColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future init() async {
    await getDealCategories();
    await getServices();
    await getdeals();

    for (var v in deals) {
      dealstoShow.add(DropdownMenuItem(
        child: Text(v.name),
        value: v.name,
      ));
    }
    for (var v in dealCategories) {
      dealsCategoriestoshow.add(DropdownMenuItem(
        child: Text(v.name),
        value: v.name,
      ));
    }
    for (var v in services) {
      servicestoShow.add(DropdownMenuItem(
        child: Text(v.service_name),
        value: v.service_name,
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (deal != null) {
      _deals = deal.dealName;
      _dealCategory = deal.dealCategoryName;
      serviceName = deal.serviceTitle;
    }
    init();
  }

  _addCoupon() async {
    try {
      if (_dealCategory != null && _deals != null && serviceName != null) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          var dealid = deals.where((element) => element.name == _deals).first;
          int dId = dealid.id;
          var catid = dealCategories
              .where((element) => element.name == _dealCategory)
              .single;
          int catIds = catid.dealCategoryId;
          var servicess = services
              .where((element) => element.service_name == serviceName)
              .first;
          int serid = servicess.service_id;
          await apiHelper.ApplyDeal(serid, dId, catIds).then((result) {
            if (result != null) {
              hideLoader();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ServicesWithDealsScreen(
                        a: widget.analytics,
                        o: widget.observer,
                      )));
            } else {
              hideLoader();
              showSnackBar(
                  key: _scaffoldKey, snackBarMessage: 'Deal Not Updated!');
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (_deals == null) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Select Deal ');
      } else if (_dealCategory == null) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Select Category ');
      } else if (serviceName == null) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Select Service');
      }
    } catch (e) {
      print("Exception - addCouponScreen.dart - addCoupon():" + e.toString());
    }
  }

  Future getDealCategories() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.getDealsCategory().then((result) {
          if (result.isNotEmpty) {
            dealCategories = result;
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - couponListScreen.dart - _getCoupon():" + e.toString());
    }
  }

  Future getServices() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getService(global.user.venderId).then((result) {
          if (result.isNotEmpty) {
            services = result;
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - couponListScreen.dart - _getCoupon():" + e.toString());
    }
  }

  Future getdeals() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getDeals(global.user.venderId, 'deal').then((result) {
          if (result.isNotEmpty) {
            deals = result;
          }
          hideLoader();
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - couponListScreen.dart - _getCoupon():" + e.toString());
    }
  }
}
