import 'package:app/models/DealServicesModel.dart';
import 'package:app/models/Offers.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;

import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';

import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:getwidget/getwidget.dart';
import '../models/Deal.dart';
import 'ApplyDeal.dart';

class ServicesWithDealsScreen extends BaseRoute {
  // final int screenId;
  // static List<Coupon> couponList = [];
  // final String caller;
  ServicesWithDealsScreen({
    a,
    o,
  }) : super(a: a, o: o, r: 'CouponListScreen');
  @override
  _ServicesWithDealsScreenState createState() =>
      new _ServicesWithDealsScreenState();
}

class _ServicesWithDealsScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;

  bool _isDataLoaded = false;
  int screenId;
  String caller;
  Offers bestDeals;
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
                          child: Text('Deal Services',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0))),
                      _isDataLoaded
                          ? bestDeals != null
                              ? getListView(context)
                              : Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                3),
                                    child: Text('No Services Found'),
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ApplyDealScreen(
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )),
                        );
                      },
                      child: Container(
                        height: 40,
                        child: Center(
                          child: Text('ADD NEW DEAL SERVICE',
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
      if (bestDeals == null || check || caller != null) await _getDeals();
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

  _deleteCoupon(int couponId) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.deleteDeal(couponId, 'service').then((result) {
          if (result != null) {
            if (result != null) {
              hideLoader();
              bestDeals.services.remove(bestDeals.services
                  .where((element) => element.serviceId == couponId)
                  .first);
              setState(() {});
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: 'Not Deleted');
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

  var toShow = [];
  Widget getListView(BuildContext context) {
    toShow.clear();

    if (bestDeals != null) {
      for (Deal d in bestDeals.dealCategories) {
        var v = bestDeals.services
            .where((element) => element.dealCategoryId == d.dealCategoryId)
            .toList();
        if (v.isNotEmpty) {
          toShow.add(
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  d.name,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                ),
              ),
            ),
          );
        }
        for (var vs in v) {
          if (vs.dealName
              .toLowerCase()
              .contains(searchController.text.toLowerCase().trim())) {
            toShow.add(getListViewWidget(context, vs));
          }
        }
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          for (var item in toShow) ...{item}
        ],
      ),
    );
  }

  Widget getListViewWidget(
    BuildContext context,
    DealServicesModel service,
  ) {
    return InkWell(
      onTap: () {
        //

        // Goto.push(ServiceDetails(model: service));
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Card(
              elevation: 5,
              shadowColor: Colors.black38,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0, top: 26.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      service.serviceTitle,
                                      // style: AppFont.medStyleAppClr,
                                    ),

                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_filled_rounded,
                                          size: 10,
                                        ),
                                        // smalHGap(),
                                        Text(
                                          service.serviceTime,
                                          // style: AppFont.smalStyle
                                          //     .copyWith(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    // smalGap(),

                                    if (service.discountedRate > 0
                                    // service.coupon.name.isNotEmpty &&
                                    //service.couponId > 0
                                    ) ...[
                                      Row(
                                        children: [
                                          Text(
                                            "Rs.${service.serviceRate}",
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.combine([
                                                TextDecoration.lineThrough,
                                              ]),
                                              decorationStyle:
                                                  TextDecorationStyle.solid,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Rs.${service.discountedRate}",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ] else ...[
                                      Text(
                                        "Rs.${service.serviceRate}",
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              //smalHGap(),
                            ],
                          ),
                          // smalGap(),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 6),
                      height: 100,
                      width: 120,
                      margin: EdgeInsets.only(left: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          width: 100,
                          height: 180,
                          color:
                              Colors.amber, // added only for view this example
                          child: CachedNetworkImage(
                            imageUrl:
                                '${global.baseUrlForImage}Services/${service.serviceImage}',
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => GFAvatar(
                              shape: GFAvatarShape.square,
                              maxRadius: 50,
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                const GFAvatar(
                              shape: GFAvatarShape.square,
                              maxRadius: 50,
                              child: Icon(Icons.error),
                            ),
                            imageBuilder: (context, imageProvider) => GFAvatar(
                              shape: GFAvatarShape.square,
                              backgroundImage: imageProvider,
                              maxRadius: 50,
                            ),
                          ), // add Product image here
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                service.dealName != "" || service.dealName.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                        ),
                        child: Container(
                          color: Colors.red, // added only for view this example
                          //decoration: BoxDecoration(image: ),// add label image here
                          width: 150,
                          height: 25,
                          child: Text(
                            service.dealName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      )
                    : const SizedBox(),
                PopupMenuButton(itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      padding: EdgeInsets.all(0),
                      child: new ListTile(
                        leading: Icon(Icons.delete,
                            color: Theme.of(context).primaryColor),
                        title: Text('Delete',
                            style:
                                Theme.of(context).primaryTextTheme.subtitle2),
                        onTap: () {
                          Navigator.of(context).pop();
                          _deleteCouponConfirmationDialog(service.serviceId);
                        },
                      ),
                    ),
                    PopupMenuItem(
                      padding: EdgeInsets.all(0),
                      child: new ListTile(
                        leading: Icon(Icons.edit,
                            color: Theme.of(context).primaryColor),
                        title: Text('Edit',
                            style:
                                Theme.of(context).primaryTextTheme.subtitle2),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ApplyDealScreen(
                                    a: widget.analytics,
                                    o: widget.observer,
                                    coupon: service,
                                  )));
                        },
                      ),
                    ),
                  ];
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _deleteCouponConfirmationDialog(couponId) async {
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
                    await _deleteCoupon(couponId);
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
        await apiHelper
            .getDeals(global.user.venderId, 'services')
            .then((result) {
          if (result != null) {
            bestDeals = result;

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
    for (var v in bestDeals.services) {
      if (v.dealName
          .toLowerCase()
          .contains(searchController.text.toLowerCase().trim())) {
        con = true;
      }
    }
    return con;
  }

  dothis() {
    if (searchController.text != "") {
      if (bestDeals.services.isNotEmpty) {
        if (check()) {
          setState(() {});
        } else {
          showSnackBar(key: _scaffoldKey, snackBarMessage: 'No Services Found');
          setState(() {});
        }
      } else {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: 'No Service to Search!');
      }
    } else {
      showSnackBar(
          key: _scaffoldKey, snackBarMessage: 'Enter a name to Search!');
    }
  }
}
