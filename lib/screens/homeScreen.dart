import 'dart:async';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/chartDataModel.dart';
import 'package:app/models/homePageModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/screens/MyLocation.dart';
import 'package:app/screens/notificationScreen.dart';
import 'package:app/widgets/drawerWidget.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sinusoidals/flutter_sinusoidals.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends BaseRoute {
  static int notificationsCount;
  HomeScreen({a, o}) : super(a: a, o: o, r: 'HomeScreen');
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;
  HomePage _homeData = HomePage();
  bool _isDataLoaded = false;

  bool isloading = true;
  List<String> _days = [];

  List<double> ys = [];
  _HomeScreenState() : super();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
        init();
      },
      color: Colors.white,
      backgroundColor: Colors.purple,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: Image.asset(
            'assets/partner_logo.png',
            height: 30,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MapSample()));
                },
                color: AppColors.primary,
                icon: Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primary,
                )),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificationScreen(
                            a: widget.analytics,
                            o: widget.observer,
                          )));
                },
                icon: Stack(
                  children: [
                    Icon(Icons.notifications),
                    Badge(
                      showBadge: _isDataLoaded
                          ? HomeScreen.notificationsCount > 0
                              ? true
                              : false
                          : false,
                      badgeColor: Colors.red,
                      badgeContent: Text(
                        '${HomeScreen.notificationsCount}',
                        style: TextStyle(color: Colors.white, fontSize: 09),
                      ),
                    )
                  ],
                ))
            // Padding(
            //   padding: EdgeInsets.only(right: 10, left: 10, top: 11),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.of(context).push(MaterialPageRoute(
            //           builder: (context) => NotificationScreen(
            //                 a: widget.analytics,
            //                 o: widget.observer,
            //               )));
            //     },
            //     child: Stack(
            //       children: [
            //         CircleAvatar(
            //           radius: 15,
            //           backgroundColor: AppColors.primary,
            //           child: Icon(
            //             Icons.notifications_none,
            //             size: 20,
            //             color: Colors.white,
            //           ),
            //         ),
            //         Align(
            //           alignment: Alignment.topLeft,
            //           child: Badge(
            //             showBadge: _isDataLoaded
            //                 ? _homeData.unread_notification_count > 0
            //                     ? true
            //                     : false
            //                 : false,
            //             badgeColor: Theme.of(context).primaryColor,
            //             badgeContent: Text(
            //               '${_homeData.unread_notification_count}',
            //               style: TextStyle(color: Colors.white, fontSize: 09),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
        drawer: DrawerWidget(
          a: widget.analytics,
          o: widget.observer,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            _isDataLoaded
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.33,
                          child: CachedNetworkImage(
                            imageUrl:
                                '${global.baseUrlForImage}venders/${global.user.shop_image}',
                            imageBuilder: (context, imageProvider) => Container(
                              height: 70,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: imageProvider)),
                            ),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.33,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                            ),
                          ),
                        ),
                        global.isRTL
                            ? Positioned(
                                bottom: 15,
                                right: 15,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: global.isRTL
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      global.user.vendor_name != null
                                          ? '${global.user.vendor_name.toUpperCase()}'
                                          : " ",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline2,
                                    ),
                                    Text.rich(TextSpan(
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .headline5,
                                        text: global.user.firstname != null
                                            ? global.user.firstname
                                                    .toUpperCase() +
                                                " "
                                            : ' ',
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: global.user.lastname != null
                                                ? global.user.lastname
                                                    .toUpperCase()
                                                : ' ',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline5,
                                          )
                                        ])),
                                  ],
                                ),
                              )
                            : Positioned(
                                bottom: 15,
                                left: 15,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: global.isRTL
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      global.user.vendor_name != null
                                          ? '${global.user.vendor_name.toUpperCase()}'
                                          : " ",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline2,
                                    ),
                                    Text.rich(TextSpan(
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .headline5,
                                        text: global.user.firstname != null
                                            ? global.user.firstname
                                                    .toUpperCase() +
                                                " "
                                            : ' ',
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: global.user.lastname != null
                                                ? global.user.lastname
                                                    .toUpperCase()
                                                : ' ',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline5,
                                          )
                                        ])),
                                  ],
                                ),
                              )
                      ],
                    ),
                  )
                : _shimmer1(),
            _isDataLoaded
                ? Card(
                    elevation: 5,
                    margin: EdgeInsets.only(left: 12, right: 10, top: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: global.isRTL
                                ? EdgeInsets.only(right: 10, top: 10)
                                : EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              AppLocalizations.of(context).lbl_weekly_earn,
                              style: Theme.of(context).primaryTextTheme.caption,
                            ),
                          ),
                          _homeData.weeklyEarning.isEmpty
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height -
                                      ((MediaQuery.of(context).size.height *
                                              0.33) +
                                          50 +
                                          220),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .txt_weekly_earn_will_shown_here,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle2,
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(
                                      top: 5, left: 55, right: 30, bottom: 5),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height -
                                      ((MediaQuery.of(context).size.height *
                                              0.33) +
                                          50 +
                                          220),
                                  child: _isDataLoaded
                                      ? _charts()
                                      : Center(
                                          child: CircularProgressIndicator(),
                                        ))
                        ]))
                : _shimmer4(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 25, left: 10, right: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _isDataLoaded
                      ? Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          height: 172,
                          width: (MediaQuery.of(context).size.width / 3) - 10,
                          child: Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      AppLocalizations.of(context).lbl_total,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle2,
                                    ),
                                  ),
                                  Text(
                                      AppLocalizations.of(context).lbl_services,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle2),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: _isDataLoaded
                                        ? Text(
                                            _homeData != null
                                                ? '${_homeData.allOrders}'
                                                : '0',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .overline
                                                .copyWith(color: Colors.blue),
                                          )
                                        : Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: 40,
                                    width: 150,
                                    child: Stack(children: [
                                      Sinusoidal(
                                        model: const SinusoidalModel(
                                          formular: WaveFormular.travelling,
                                          amplitude: 20,
                                          waves: 2.5,
                                          frequency: 1,
                                        ),
                                        child: Container(
                                          height: 40,
                                          color: Color(0xFF8EEBEC),
                                        ),
                                      ),
                                      Sinusoidal(
                                        model: const SinusoidalModel(
                                          formular: WaveFormular.normal,
                                          amplitude: 10,
                                          waves: 2.5,
                                          frequency: 0.5,
                                        ),
                                        child: Container(
                                            height: 40,
                                            color: Color(0xFF41145a)),
                                      ),
                                      Sinusoidal(
                                        model: const SinusoidalModel(
                                          formular: WaveFormular.standing,
                                          amplitude: 20,
                                          waves: 2.5,
                                          frequency: 1,
                                        ),
                                        child: Container(
                                          height: 40,
                                          color: Color(0xFF34434D),
                                        ),
                                      ),
                                    ]),
                                  )
                                ],
                              )),
                        )
                      : _shimmer2(),
                  _isDataLoaded
                      ? Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          height: 172,
                          width: (MediaQuery.of(context).size.width / 3) - 20,
                          child: Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      AppLocalizations.of(context).lbl_pending,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle2,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context).lbl_services,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: _isDataLoaded
                                        ? Text(
                                            _homeData != null
                                                ? '${_homeData.pendingOrders}'
                                                : '0',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .overline
                                                .copyWith(
                                                    color: Color(0xFFFBD18B)),
                                          )
                                        : Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: 40,
                                    width: 150,
                                    child: Stack(children: [
                                      Sinusoidal(
                                        model: const SinusoidalModel(
                                          formular: WaveFormular.travelling,
                                          amplitude: 20,
                                          waves: 2.5,
                                          frequency: 1,
                                        ),
                                        child: Container(
                                          height: 40,
                                          color: Color(0xFF8EEBEC),
                                        ),
                                      ),
                                      Sinusoidal(
                                        model: const SinusoidalModel(
                                          formular: WaveFormular.normal,
                                          amplitude: 10,
                                          waves: 2.5,
                                          frequency: 0.5,
                                        ),
                                        child: Container(
                                            height: 40,
                                            color: Color(0xFF41145a)),
                                      ),
                                      Sinusoidal(
                                        model: const SinusoidalModel(
                                          formular: WaveFormular.standing,
                                          amplitude: 20,
                                          waves: 2.5,
                                          frequency: 1,
                                        ),
                                        child: Container(
                                          height: 40,
                                          color: Color(0xFF34434D),
                                        ),
                                      ),
                                    ]),
                                  )
                                ],
                              )),
                        )
                      : _shimmer2(),
                  _isDataLoaded
                      ? Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          height: 172,
                          width: (MediaQuery.of(context).size.width / 3) - 20,
                          child: Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .lbl_completed,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle2,
                                    ),
                                  ),
                                  Text(
                                      AppLocalizations.of(context).lbl_services,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle2),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: _isDataLoaded
                                        ? Text(
                                            _homeData != null
                                                ? '${_homeData.completedOrders}'
                                                : '0',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .overline
                                                .copyWith(
                                                    color: Color(0xFF49EC97)),
                                          )
                                        : Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: 40,
                                    width: 150,
                                    child: Stack(children: [
                                      Sinusoidal(
                                        model: const SinusoidalModel(
                                          formular: WaveFormular.travelling,
                                          amplitude: 20,
                                          waves: 2.5,
                                          frequency: 1,
                                        ),
                                        child: Container(
                                          height: 40,
                                          color: Color(0xFF8EEBEC),
                                        ),
                                      ),
                                      Sinusoidal(
                                        model: const SinusoidalModel(
                                          formular: WaveFormular.normal,
                                          amplitude: 10,
                                          waves: 2.5,
                                          frequency: 0.5,
                                        ),
                                        child: Container(
                                            height: 40,
                                            color: Color(0xFF41145a)),
                                      ),
                                      Sinusoidal(
                                        model: const SinusoidalModel(
                                          formular: WaveFormular.standing,
                                          amplitude: 20,
                                          waves: 2.5,
                                          frequency: 1,
                                        ),
                                        child: Container(
                                          height: 40,
                                          color: Color(0xFF34434D),
                                        ),
                                      ),
                                    ]),
                                  )
                                ],
                              )),
                        )
                      : _shimmer2()
                ],
              ),
            ),
            _isDataLoaded
                ? Container(
                    margin: EdgeInsets.only(bottom: 15, top: 5),
                    height: MediaQuery.of(context).size.height * 0.27,
                    width: MediaQuery.of(context).size.width - 25,
                    padding: EdgeInsets.only(),
                    child: Card(
                      elevation: 15,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                AppLocalizations.of(context)
                                    .lbl_complete_our_goals,
                                style:
                                    Theme.of(context).primaryTextTheme.caption,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: _isDataLoaded
                                  ? CircularPercentIndicator(
                                      radius: 75.0,
                                      lineWidth: 12.0,
                                      percent: double.parse(_homeData
                                              .completedGloals
                                              .toStringAsFixed(2)) /
                                          100,
                                      center: Text(
                                          "${double.parse(_homeData.completedGloals.toStringAsFixed(2))}%"),
                                      progressColor:
                                          Theme.of(context).primaryColor,
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : _shimmer3(),
          ],
        )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  getHomePage() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getHomePage(global.user.venderId).then((result) {
          if (result != null) {
            if (true) {
              _homeData = result.recordList;
              HomeScreen.notificationsCount =
                  _homeData.unread_notification_count;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - homeScreen.dart - getHomePage():" + e.toString());
    }
  }

  init() async {
    try {
      await getHomePage();
      _isDataLoaded = true;
      setState(() {});
      timetsamp();
      if (_homeData.weeklyEarning != null) {
        for (ChartData v in _homeData.weeklyEarning) {
          _days.add(v.day);
        }
        _days.add('m');
        _days.add('m');
        _days.add('m');
      } else {
        _days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
      }
    } catch (e) {
      print("Exception - homeScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void timetsamp() {
    try {
      var duration = Duration(milliseconds: 500);
      Timer(duration, () {
        setState(() {
          if (_homeData.weeklyEarning.isEmpty) {
            for (int i = 0; i < 7; i++) {
              ys.add(10);
            }
          } else {
            ys = [];
            for (var v in _homeData.weeklyEarning) {
              ys.add(double.parse(v.earning.toString()));
            }
            /*y1 = 10;//double.parse(_homeData.weeklyEarning[0].earning.toString());
            y2 = 10;//double.parse(_homeData.weeklyEarning[0].earning.toString());
            y3 =10; //double.parse(_homeData.weeklyEarning[0].earning.toString());
            y4 = 8;//double.parse(_homeData.weeklyEarning[0].earning.toString());
            y5 =7; //double.parse(_homeData.weeklyEarning[0].earning.toString());
            y6 = 10;//double.parse(_homeData.weeklyEarning[0].earning.toString());
            y7 = 10;//double.parse(_homeData.weeklyEarning[0].earning.toString());
          */
          }
        });
      });
    } catch (e) {
      print("Exception - homeScreen.dart - timetsamp():" + e.toString());
    }
  }

  void timetsamp2() {
    try {
      var duration = Duration(milliseconds: 800);
      Timer(duration, () {
        setState(() {
          //y7 = 1500.00;
        });
      });
    } catch (e) {
      print("Exception - homeScreen.dart - timetsamp2():" + e.toString());
    }
  }

  _charts() {
    final barGroups = <BarChartGroupData>[];
    int i = 0;
    print(ys);
    if (ys.isNotEmpty) {
      for (var v in _homeData.weeklyEarning) {
        if (i == 0) {
          barGroups.add(BarChartGroupData(
            x: 15,
            barRods: [
              BarChartRodData(
                  y: ys[i],
                  color: Color(0xFFE91E64),
                  width: 30,
                  borderRadius: BorderRadius.zero),
            ],
          ));
        } else if (i == 2) {
          barGroups.add(BarChartGroupData(
            x: 15,
            barRods: [
              BarChartRodData(
                  y: ys[i],
                  color: Color(0xFFF44336),
                  width: 30,
                  borderRadius: BorderRadius.zero),
            ],
          ));
        } else if (i == 3) {
          barGroups.add(BarChartGroupData(
            x: 15,
            barRods: [
              BarChartRodData(
                  y: ys[i],
                  color: Color(0xFF4CAF50),
                  width: 30,
                  borderRadius: BorderRadius.zero),
            ],
          ));
        } else if (i == 4) {
          barGroups.add(BarChartGroupData(
            x: 15,
            barRods: [
              BarChartRodData(
                  y: ys[i],
                  color: Color(0xFFFDEB3B),
                  width: 30,
                  borderRadius: BorderRadius.zero),
            ],
          ));
        } else if (i == 5) {
          barGroups.add(BarChartGroupData(
            x: 15,
            barRods: [
              BarChartRodData(
                  y: ys[i],
                  color: Color(0xFf40C4FF),
                  width: 30,
                  borderRadius: BorderRadius.zero),
            ],
          ));
        } else if (i == 6) {
          barGroups.add(BarChartGroupData(
            x: 15,
            barRods: [
              BarChartRodData(
                  y: ys[i],
                  color: Color(0xFFE91E64),
                  width: 30,
                  borderRadius: BorderRadius.zero),
            ],
          ));
        } else if (i == 1) {
          barGroups.add(BarChartGroupData(
            x: 15,
            barRods: [
              BarChartRodData(
                  y: ys[i],
                  color: Color(0xFF9C27B0),
                  width: 30,
                  borderRadius: BorderRadius.zero),
            ],
          ));
        }
        i++;
      }

      final barChartData = BarChartData(
        barGroups: barGroups,
        barTouchData: BarTouchData(
          allowTouchBarBackDraw: false,
          enabled: false,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        gridData: FlGridData(show: false),
        axisTitleData: FlAxisTitleData(
          show: true,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
              showTitles: true,
              getTitles: (double val) =>
                  _homeData.weeklyEarning[(val.toInt())].date
                      .split('T')[0]
                      .split('-')[1] +
                  "-" +
                  _homeData.weeklyEarning[(val.toInt())].date
                      .split('T')[0]
                      .split('-')[2]),
          leftTitles: SideTitles(
            showTitles: false,
            getTitles: (double val) {
              if (val.toInt() % 5 != 0) return '';
              return '${val.toInt() * 10}';
            },
          ),
        ),
      );

      return BarChart(
        barChartData,
        swapAnimationDuration: Duration(milliseconds: 500),
      );
    } else
      return SizedBox(
        height: 1,
      );
  }

  Widget _shimmer1() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width,
            child: Card()));
  }

  Widget _shimmer2() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          height: 165,
          width: (MediaQuery.of(context).size.width / 3) - 20,
          child: Card(),
        ));
  }

  Widget _shimmer3() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          margin: EdgeInsets.only(bottom: 15, top: 5),
          height: MediaQuery.of(context).size.height * 0.27,
          width: MediaQuery.of(context).size.width - 25,
          child: Card(),
        ));
  }

  Widget _shimmer4() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                ((MediaQuery.of(context).size.height * 0.33) + 50 + 220),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: MediaQuery.of(context).size.height -
                      ((MediaQuery.of(context).size.height * 0.33) + 50 + 220),
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: 155,
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: 200,
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: MediaQuery.of(context).size.height -
                      ((MediaQuery.of(context).size.height * 0.33) + 50 + 50),
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: 125,
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: 100,
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: MediaQuery.of(context).size.height -
                      ((MediaQuery.of(context).size.height * 0.33) + 50 + 100),
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: MediaQuery.of(context).size.height -
                      ((MediaQuery.of(context).size.height * 0.33) + 50 + 100),
                  width: 20,
                  child: Card(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  height: 150,
                  width: 20,
                  child: Card(),
                ),
              ],
            )));
  }
}
