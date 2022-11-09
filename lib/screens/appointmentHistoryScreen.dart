import 'package:app/dialogs/userRequestAcceptDialog.dart';
import 'package:app/models/appointmentHistoryModel.dart';
import 'package:app/models/businessLayer/apiHelper.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/widgets/drawerWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class AppointmentHistoryScreen extends BaseRoute {
  static List<AppointmentHistory> appointmentHistoryList = [];
  static String totalPending;
  AppointmentHistoryScreen({a, o})
      : super(a: a, o: o, r: 'AppointmentHistoryScreen');
  @override
  _AppointmentHistoryScreenState createState() =>
      new _AppointmentHistoryScreenState();
}

class _AppointmentHistoryScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;

  bool _isDataLoaded = false;
  _AppointmentHistoryScreenState() : super();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
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
        child: sc(
          Scaffold(
              drawer: DrawerWidget(
                a: widget.analytics,
                o: widget.observer,
              ),
              body: Container(
                  decoration: BoxDecoration(
                      color: AppColors.background,
                      image: DecorationImage(
                          image: AssetImage("assets/partner_background.png"))),
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
                              Image.asset('assets/partner_logo.png',
                                  scale: 7.0),
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
                                  hintText: ' Search Here!',
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
                          child: Text(
                              AppLocalizations.of(context)
                                  .lbl_appointment_history,
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0)),
                        ),
                        _isDataLoaded
                            ? AppointmentHistoryScreen
                                        .appointmentHistoryList.length >
                                    0
                                ? Expanded(
                                    child: ListView.builder(
                                        itemCount: AppointmentHistoryScreen
                                            .appointmentHistoryList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return (AppointmentHistoryScreen
                                                  .appointmentHistoryList[index]
                                                  .customerName
                                                  .toLowerCase()
                                                  .contains(searchController
                                                      .text
                                                      .toLowerCase()
                                                      .trim()))
                                              ? (AppointmentHistoryScreen
                                                              .appointmentHistoryList[
                                                                  index]
                                                              .statustext ==
                                                          "Completed" ||
                                                      AppointmentHistoryScreen
                                                              .appointmentHistoryList[
                                                                  index]
                                                              .statustext ==
                                                          "Rejected")
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        _detailDialog(index);
                                                      },
                                                      child: Card(
                                                        color:
                                                            AppColors.surface,
                                                        margin: EdgeInsets.only(
                                                            top: 8),
                                                        child: ExpansionTile(
                                                          tilePadding:
                                                              EdgeInsets.only(
                                                                  left: 2),
                                                          title: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: global
                                                                        .isRTL
                                                                    ? EdgeInsets
                                                                        .only(
                                                                            right:
                                                                                5)
                                                                    : EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                5),
                                                                child:
                                                                    CircleAvatar(
                                                                  child: AppointmentHistoryScreen
                                                                              .appointmentHistoryList[
                                                                                  index]
                                                                              .user ==
                                                                          null
                                                                      ? CircleAvatar(
                                                                          radius:
                                                                              25,
                                                                          backgroundImage: AssetImage(
                                                                              'assets/userImage.png'))
                                                                      : AppointmentHistoryScreen.appointmentHistoryList[index].customerImage ==
                                                                              null
                                                                          ? CircleAvatar(
                                                                              radius: 25,
                                                                              backgroundImage: AssetImage('assets/userImage.png'))
                                                                          : CachedNetworkImage(
                                                                              imageUrl: global.baseUrlForImage + "Users/" + AppointmentHistoryScreen.appointmentHistoryList[index].customerImage,
                                                                              imageBuilder: (context, imageProvider) => CircleAvatar(
                                                                                radius: 25,
                                                                                backgroundImage: imageProvider,
                                                                              ),
                                                                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                                                            ),
                                                                  radius: 25,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: global
                                                                          .isRTL
                                                                      ? EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10.0,
                                                                        )
                                                                      : EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10.0,
                                                                        ),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                          child:
                                                                              Text(
                                                                        AppointmentHistoryScreen.appointmentHistoryList[index].customerName !=
                                                                                null
                                                                            ? '${AppointmentHistoryScreen.appointmentHistoryList[index].customerName}'
                                                                            : 'No Name',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .primaryTextTheme
                                                                            .subtitle2,
                                                                      )),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 2),
                                                                        child:
                                                                            Text(
                                                                          AppointmentHistoryScreen
                                                                              .appointmentHistoryList[index]
                                                                              .serviceTitle,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: Theme.of(context)
                                                                              .primaryTextTheme
                                                                              .subtitle1,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 2),
                                                                        child:
                                                                            Text(
                                                                          AppointmentHistoryScreen.appointmentHistoryList[index].serviceDate != null
                                                                              ? '${AppointmentHistoryScreen.appointmentHistoryList[index].serviceDate.split(':')[0].split('T')[0]}'
                                                                              : " ",
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: Theme.of(context)
                                                                              .primaryTextTheme
                                                                              .subtitle1,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 2),
                                                                        child:
                                                                            Text(
                                                                          AppointmentHistoryScreen.appointmentHistoryList[index].time != null
                                                                              ? AppointmentHistoryScreen.appointmentHistoryList[index].time.split(' ')[0] + AppointmentHistoryScreen.appointmentHistoryList[index].time.split(' ')[1] + "-" + AppointmentHistoryScreen.appointmentHistoryList[index].time.split(' ')[2] + AppointmentHistoryScreen.appointmentHistoryList[index].time.split(' ')[3]
                                                                              : " ",
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              color: AppColors.circleAvatarColor),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 110,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    if (AppointmentHistoryScreen.appointmentHistoryList[index].discountedPrice !=
                                                                            "0" &&
                                                                        AppointmentHistoryScreen.appointmentHistoryList[index].discountedPrice !=
                                                                            null) ...[
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 5),
                                                                        child:
                                                                            Wrap(
                                                                          children: [
                                                                            Text(
                                                                              "Rs.${AppointmentHistoryScreen.appointmentHistoryList[index].totalPrice}",
                                                                              style: TextStyle(
                                                                                fontSize: 13,
                                                                                decoration: TextDecoration.combine([
                                                                                  TextDecoration.lineThrough,
                                                                                ]),
                                                                                decorationStyle: TextDecorationStyle.solid,
                                                                                color: Colors.red,
                                                                              ),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                            Text(
                                                                              "  Rs.${AppointmentHistoryScreen.appointmentHistoryList[index].discountedPrice}",
                                                                              style: TextStyle(
                                                                                color: Colors.red,
                                                                                fontSize: 12,
                                                                              ),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ] else ...[
                                                                      Text(
                                                                        "Rs.${AppointmentHistoryScreen.appointmentHistoryList[index].totalPrice}",
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    Text(
                                                                      '${AppointmentHistoryScreen.appointmentHistoryList[index].statustext}',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .primaryTextTheme
                                                                          .subtitle1,
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    AppointmentHistoryScreen.appointmentHistoryList[index].paymentMethod !=
                                                                            null
                                                                        ? Text(
                                                                            AppointmentHistoryScreen.appointmentHistoryList[index].paymentMethod.toLowerCase().contains('cash')
                                                                                ? 'Cash'
                                                                                : 'Paid',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 13,
                                                                              color: AppointmentHistoryScreen.appointmentHistoryList[index].paymentMethod.toLowerCase().contains('cash') ? AppColors.primary : AppColors.darkGreen,
                                                                            ),
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          )
                                                                        : SizedBox()
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox()
                                              : SizedBox();
                                        }),
                                  )
                                : Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3),
                                      child: Text('No Appointments Found'),
                                    ),
                                  )
                            : Expanded(child: _shimmer())
                      ],
                    ),
                  ))),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  getAppointmentHistory() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper
            .getAppointmentHistory(global.user.venderId, "History")
            .then((result) {
          if (result != null) {
            if (result != null) {
              AppointmentHistoryScreen.appointmentHistoryList =
                  result; //.recordList;
            } else {
              AppointmentHistoryScreen.appointmentHistoryList = [];
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - appointmentHistoryScreen.dart - getAppointmentHistory():" +
              e.toString());
    }
  }

  init(check) async {
    try {
      if (AppointmentHistoryScreen.appointmentHistoryList.isEmpty || check) {
        await getAppointmentHistory();
        APIHelper.appointments =
            AppointmentHistoryScreen.appointmentHistoryList;
      }
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print(
          "Exception - appointmentHistoryScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init(false);
  }

  _detailDialog(int _index) {
    try {
      showDialog(
          context: context,
          builder: (context) => UserRequestAcceptDialog(
                _index,
                true,
                1,
                a: widget.analytics,
                o: widget.observer,
              ));
    } catch (e) {
      print(
          'Exception: appointmentHistoryScreen: _detailDialog(): ${e.toString()}');
    }
  }

  bool check() {
    bool con = false;
    for (var v in AppointmentHistoryScreen.appointmentHistoryList) {
      if (v.customerName
          .toLowerCase()
          .contains(searchController.text.toLowerCase().trim())) {
        con = true;
      }
    }
    return con;
  }

  dothis() {
    if (searchController.text != "") {
      if (AppointmentHistoryScreen.appointmentHistoryList.isNotEmpty) {
        if (check()) {
          setState(() {});
        } else {
          showSnackBar(
              key: _scaffoldKey, snackBarMessage: 'No Appointments Found');
          setState(() {});
        }
      } else {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage: 'No Appointments History to Search!');
      }
    } else {
      showSnackBar(
          key: _scaffoldKey, snackBarMessage: 'Enter a name to Search!');
    }
  }

  _deleteAppointment(int serviceId, int _index) async {
    bool isConnected = await br.checkConnectivity();
    if (isConnected) {
      showOnlyLoaderDialog();
      await apiHelper.deleteRequest(serviceId).then((result) {
        if (result) {
          hideLoader();
          AppointmentHistoryScreen.appointmentHistoryList.removeAt(_index);
          showSnackBar(key: _scaffoldKey, snackBarMessage: '${"Deleted"}');
          setState(() {});
        } else {
          hideLoader();
          showSnackBar(key: _scaffoldKey, snackBarMessage: '${"Not Deleted"}');
        }
      });
    } else {
      showNetworkErrorSnackBar(_scaffoldKey);
    }
  }

  Future _deleteServiceConfirmationDialog(serviceId, _index) async {
    try {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context).lbl_delete_service,
              ),
              content: Text(AppLocalizations.of(context)
                  .txt_confirmation_message_for_delete_service),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context).lbl_no),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context).lbl_yes),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _deleteAppointment(serviceId, _index);
                  },
                )
              ],
            );
          });
    } catch (e) {
      print(
          "Exception - serviceListScreen.dart - _deleteServiceConfirmationDialog():" +
              e.toString());
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
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 85,
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Card(),
                    ),
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
                              width: MediaQuery.of(context).size.width,
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
}
