import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/serviceModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/screens/addDeals.dart';
import 'package:app/screens/serviceListScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../models/Deal.dart';

class DealListScreen extends BaseRoute {
  // final int screenId;
  // static List<Coupon> couponList = [];
  // final String caller;
  DealListScreen({
    a,
    o,
  }) : super(a: a, o: o, r: 'CouponListScreen');
  @override
  _DealListScreenState createState() => new _DealListScreenState();
}

class _DealListScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;

  bool _isDataLoaded = false;
  int screenId;
  String caller;
  List<Deal> dealsList = [];
  var searchController = TextEditingController();
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
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2));
            init(true);
          },
          color: Colors.white,
          backgroundColor: Colors.purple,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          child: Scaffold(
            body: Container(
                decoration: BoxDecoration(
                    color: AppColors.background,
                    image: DecorationImage(
                        image: AssetImage("assets/partner_background.png"))),
                // margin: EdgeInsets.only(top: 80),
                height: MediaQuery.of(context).size.height * 0.97,
                // width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
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
                            Image.asset('assets/partner_logo.png', scale: 7.0),
                            Text(' ')
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 0, left: 5, right: 5),
                          child: Center(
                            child: TextFormField(
                              expands: false,
                              controller: searchController,
                              onSaved: (val) {
                                dothis();
                              },
                              decoration: InputDecoration(
                                prefix: Text('     '),
                                hintText: ' Search By Name!',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    dothis();
                                  },
                                ),
                                contentPadding: EdgeInsets.only(top: 5),
                              ),
                            ),
                          )),
                      SizedBox(height: Dimens.space_normal),
                      Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text('Deals',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0))),
                      _isDataLoaded
                          ? dealsList.length > 0
                              ? Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: dealsList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return dealsList[index]
                                                    .dealCategoryName
                                                    .toLowerCase()
                                                    .contains(searchController
                                                        .text
                                                        .toLowerCase()
                                                        .trim()) ||
                                                dealsList[index]
                                                    .name
                                                    .toLowerCase()
                                                    .contains(searchController
                                                        .text
                                                        .toLowerCase()
                                                        .trim())
                                            ? GestureDetector(
                                                onTap: () {
                                                  _detailDialog(index);
                                                },
                                                child: SizedBox(
                                                  // height: 80,
                                                  child: Card(
                                                      color: AppColors.surface,
                                                      margin: EdgeInsets.only(
                                                          bottom: 8),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding: global
                                                                      .isRTL
                                                                  ? EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              10,
                                                                          right:
                                                                              15)
                                                                  : EdgeInsets.only(
                                                                      left:
                                                                          15.0,
                                                                      top: 10),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '${dealsList[index].dealCategoryName}',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .primaryTextTheme
                                                                        .subtitle2,
                                                                  ),
                                                                  Text(
                                                                    '${dealsList[index].name}',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .primaryTextTheme
                                                                        .subtitle2,
                                                                  ),
                                                                  Text(
                                                                    '${dealsList[index].description.replaceAll('<p>', '').replaceAll('</p>', '')}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          PopupMenuButton(
                                                              itemBuilder:
                                                                  (BuildContext
                                                                      context) {
                                                            return [
                                                              PopupMenuItem(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                child:
                                                                    new ListTile(
                                                                  leading: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                                  title: Text(
                                                                      AppLocalizations.of(
                                                                              context)
                                                                          .lbl_delete,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .primaryTextTheme
                                                                          .subtitle2),
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    _deleteCouponConfirmationDialog(
                                                                        dealsList[index]
                                                                            .id,
                                                                        index);
                                                                  },
                                                                ),
                                                              ),
                                                              PopupMenuItem(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                child:
                                                                    new ListTile(
                                                                  leading: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                                  title: Text(
                                                                      AppLocalizations.of(
                                                                              context)
                                                                          .lbl_edit,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .primaryTextTheme
                                                                          .subtitle2),
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (context) => AddDealScreen(
                                                                                  a: widget.analytics,
                                                                                  o: widget.observer,
                                                                                  deal: dealsList[index],
                                                                                )));
                                                                  },
                                                                ),
                                                              ),
                                                              // PopupMenuItem(
                                                              //   padding:
                                                              //       EdgeInsets
                                                              //           .all(0),
                                                              //   child:
                                                              //       new ListTile(
                                                              //     leading: Image.asset(
                                                              //         "assets/service_icon.png",
                                                              //         scale: Dimens
                                                              //             .space_small),
                                                              //     title: Text(
                                                              //         'Apply On Services',
                                                              //         style: Theme.of(
                                                              //                 context)
                                                              //             .primaryTextTheme
                                                              //             .subtitle2),
                                                              //     onTap: () {
                                                              //       Navigator.of(
                                                              //               context)
                                                              //           .pop();
                                                              //       Service
                                                              //           .toCheckCouponId = dealsList[
                                                              //               index]
                                                              //           .dealCategoryId;
                                                              //       Navigator.of(
                                                              //               context)
                                                              //           .push(MaterialPageRoute(
                                                              //               builder: (context) => ServiceListScreen(
                                                              //                     a: widget.analytics,
                                                              //                     o: widget.observer,
                                                              //                     screenId: 4,
                                                              //                     msg: dealsList[index].dealCategoryId.toString(),
                                                              //                   )));
                                                              //     },
                                                              //   ),
                                                              // ),
                                                            ];
                                                          }),
                                                        ],
                                                      )),
                                                ),
                                              )
                                            : SizedBox();
                                      }),
                                )
                              : Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                3),
                                    child: Text('No Deals Found'),
                                  ),
                                )
                          : Expanded(child: _shimmer()),
                    ],
                  ),
                )),
            floatingActionButton: _isDataLoaded
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.space_xxxxxxlarge,
                      vertical: Dimens.space_large,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddDealScreen(
                                  a: widget.analytics,
                                  o: widget.observer,
                                )));
                      },
                      child: Container(
                        height: 40,
                        child: Center(
                          child: Text('ADD NEW DEAL +',
                              style: TextStyle(color: AppColors.surface)),
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.dotColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  )
                : _shimmer1(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  init(check) async {
    try {
      if (dealsList.isEmpty || check || caller != null) await _getDeals();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - couponListScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    init(false);
  }

  _deleteCoupon(int couponId, int _index) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.deleteDeal(couponId, 'deal').then((result) {
          if (result != null) {
            if (result) {
              hideLoader();
              dealsList.remove(
                  dealsList.where((element) => element.id == couponId).first);

              setState(() {});
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: 'Not Deleted');
              hideLoader();
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - couponListScreen.dart - _deleteCoupon():" +
          e.toString());
    }
  }

  Future _deleteCouponConfirmationDialog(couponId, _index) async {
    try {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                'Delete Deal',
              ),
              content: Text('Are you sure to delete this deal?'),
              actions: [
                TextButton(
                  child: Text('NO'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text('YES'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _deleteCoupon(couponId, _index);
                  },
                )
              ],
            );
          });
    } catch (e) {
      print(
          "Exception - couponListScreen.dart - _deleteCouponConfirmationDialog():" +
              e.toString());
    }
  }

  _detailDialog(int _index) {
    try {
      // showDialog(
      //     context: context,
      //     builder: (context) => CouponDetailDialog(
      //           dealsList[_index],
      //           a: widget.analytics,
      //           o: widget.observer,
      //         ));
    } catch (e) {
      print(
          'Exception - couponListScreen.dart - _detailDialog(): ${e.toString()}');
    }
  }

  _getDeals() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getDeals(global.user.venderId, 'deal').then((result) {
          if (result != null) {
            dealsList = result;

            setState(() {});
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - couponListScreen.dart - _getCoupon():" + e.toString());
    }
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 85,
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              child: Card(
                                margin:
                                    EdgeInsets.only(bottom: 5, left: 5, top: 5),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              height: 30,
                              child: Card(
                                  margin: EdgeInsets.only(
                                      bottom: 5, left: 5, top: 5)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _shimmer1() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Card(),
          )),
    );
  }

  bool check() {
    bool con = false;
    for (var v in dealsList) {
      if (v.dealCategoryName
              .toLowerCase()
              .contains(searchController.text.toLowerCase().trim()) ||
          v.name
              .toLowerCase()
              .contains(searchController.text.toLowerCase().trim())) {
        con = true;
      }
    }
    return con;
  }

  dothis() {
    if (searchController.text != "") {
      if (dealsList.isNotEmpty) {
        if (check()) {
          setState(() {});
        } else {
          showSnackBar(key: _scaffoldKey, snackBarMessage: 'No Deal Found');
          setState(() {});
        }
      } else {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'No Deal to Search!');
      }
    } else {
      showSnackBar(
          key: _scaffoldKey, snackBarMessage: 'Enter a name to Search!');
    }
  }
}
