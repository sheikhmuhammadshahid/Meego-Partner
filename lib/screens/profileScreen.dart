import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/partnerUserModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/screens/MyLocation.dart';
import 'package:app/screens/updateProfileScreen.dart';
import 'package:app/widgets/drawerWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends BaseRoute {
  ProfileScreen({a, o}) : super(a: a, o: o, r: 'ProfileScreen');
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;
  List<String> _openHourList = [];
  List<String> _closeHourList = [];
  List<String> _days = [];
  CurrentUser _user = new CurrentUser();
  bool _isDataLoaded = false;
  _ProfileScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: sc(
        Scaffold(
            backgroundColor: AppColors.background,
            drawer: DrawerWidget(
              a: widget.analytics,
              o: widget.observer,
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2));
                _init();
              },
              color: Colors.white,
              backgroundColor: Colors.purple,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Dimens.space_large),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space_medium),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  child: Icon(Icons.menu,
                                      color: AppColors.primary)),
                              SizedBox(width: 15.0),
                            ],
                          ),
                          Image.asset('assets/partner_logo.png', scale: 7.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(' '),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => MapSample()));
                                  },
                                  icon: Icon(Icons.location_on_outlined))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimens.space_small),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.space_xlarge),
                        decoration: BoxDecoration(
                            color: AppColors.background,
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/partner_background.png"))),
                        // margin: EdgeInsets.only(top: 80),
                        child: _isDataLoaded
                            ? _user != null
                                ? SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 30, bottom: 10),
                                                child: Text.rich(TextSpan(
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headline3,
                                                    text: global.user
                                                                .firstname !=
                                                            null
                                                        ? global.user.firstname
                                                                .toUpperCase() +
                                                            " "
                                                        : ' ',
                                                    children: <InlineSpan>[
                                                      TextSpan(
                                                        text: global.user
                                                                    .lastname !=
                                                                null
                                                            ? global
                                                                .user.lastname
                                                                .toUpperCase()
                                                            : ' ',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .headline3,
                                                      )
                                                    ])),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 05),
                                                child: CircleAvatar(
                                                  radius: 38,
                                                  child: global.user
                                                              .shop_image ==
                                                          null
                                                      ? Image.asset(
                                                          'assets/userImage.png')
                                                      : CachedNetworkImage(
                                                          imageUrl: global
                                                                  .baseUrlForImage +
                                                              "venders/" +
                                                              global.user
                                                                  .shop_image,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              CircleAvatar(
                                                            radius: 38,
                                                            backgroundImage:
                                                                imageProvider,
                                                          ),
                                                          placeholder: (context,
                                                                  url) =>
                                                              Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  '${global.user.vendor_name}',
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .subtitle2,
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    RatingBar.builder(
                                                      initialRating: global.user
                                                                      .rating !=
                                                                  null &&
                                                              global.user
                                                                      .rating !=
                                                                  0
                                                          ? global.user.rating
                                                          : 0,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 23,
                                                      glowColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                      ),
                                                      ignoreGestures: true,
                                                      updateOnDrag: false,
                                                      onRatingUpdate:
                                                          (rating) {},
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                      child: Text(
                                                        global.user.rating !=
                                                                null
                                                            ? '${global.user.rating}'
                                                            : '0',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .subtitle1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 17),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              global.user.description != null
                                                  ? Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .lbl_about,
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .subtitle2,
                                                    )
                                                  : SizedBox(),
                                              global.user.description != null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      child: Text(
                                                        '${global.user.description.replaceAll('<p>', '').replaceAll('</p>', '')}',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .subtitle1,
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                              global.user.weekly_time.length > 0
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .dotColor,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimens
                                                                    .space_medium)),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .lbl_opening_hours,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .surface),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              global.user.weekly_time.length > 0
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.75,
                                                      child: ListView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: global
                                                              .user
                                                              .weekly_time
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int i) {
                                                            return Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 4),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    '${_days[i]}',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .primaryTextTheme
                                                                        .subtitle1,
                                                                  ),
                                                                  Text(
                                                                    '${_openHourList[i].replaceAll('am', 'AM').replaceAll('pm', 'PM')} - ${_closeHourList[i].replaceAll('pm', 'PM').replaceAll('am', 'AM')}',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .primaryTextTheme
                                                                        .subtitle1,
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    )
                                                  : SizedBox(),
                                              global.user.vendor_address != null
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .lbl_address,
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .subtitle2,
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                              global.user.vendor_address != null
                                                  ? ListTile(
                                                      leading: Icon(
                                                        Icons.location_on,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      title: Text(
                                                        '${global.user.vendor_address}',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .subtitle1,
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                              SizedBox(
                                                  height: Dimens.space_xsmall),
                                              _isDataLoaded
                                                  ? Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.25),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          UpdateProfileScreen(
                                                                            global.user,
                                                                            a: widget.analytics,
                                                                            o: widget.observer,
                                                                          )));
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 40,
                                                          child: Center(
                                                            child: Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .btn_update_profile,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .surface)),
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .dotColor,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Text(AppLocalizations.of(context)
                                        .txt_profile_will_be_shown_here),
                                  )
                            : _shimmer())
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

  @override
  void initState() {
    super.initState();
    _init();
  }

  _getReview(int vendorId) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getPartnerReview(vendorId).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _user.review.addAll(result.recordList);
            } else {
              _user.review = null;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - expertListScreen.dart - _getExperts():" + e.toString());
    }
  }

  _getUserProfile() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getUserProfile(global.user.venderId).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _user = result.recordList;
            } else {
              _user = null;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - profileScreen.dart - _getUserProfile():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getUserProfile();

      _isDataLoaded = true;
      final localizations = MaterialLocalizations.of(context);
      if (global.user.weekly_time != null) {
        for (var i = 0; i < global.user.weekly_time.length; i++) {
          _openHourList.add(global.user.weekly_time[i].open_hour.toString());
          _closeHourList.add(global.user.weekly_time[i].close_hour.toString());
          _days.add(global.user.weekly_time[i].days);
        }
      }
      setState(() {});
    } catch (e) {
      print("Exception - profileScreen.dart - init():" + e.toString());
    }
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  child: Card(),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
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
                                        margin: EdgeInsets.only(
                                            bottom: 5, left: 5, top: 5),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          100,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
