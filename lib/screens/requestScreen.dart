import 'package:app/dialogs/userRequestAcceptDialog.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/userRequestModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/widgets/drawerWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import 'appointmentHistoryScreen.dart';

class RequestScreen extends BaseRoute {
  RequestScreen({a, o}) : super(a: a, o: o, r: 'RequestScreen');
  @override
  _RequestScreenState createState() => new _RequestScreenState();
}

class _RequestScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;
  List<UserRequest> _userRequest = [];
  bool _isDataLoaded = false;
  _RequestScreenState() : super();
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
                                  /* InkWell(
                                    onTap: (){

                                    },
                                    child: Image.asset('assets/account_pic.png',
                                        scale: 8.0),
                                  ),*/
                                ],
                              ),
                              Image.asset('assets/partner_logo.png',
                                  scale: 7.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  /*  IconButton(
                                      padding: EdgeInsets.all(0),
                                      alignment: global.isRTL
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      onPressed: () {
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           SearchScreen(0,
                                        //               a: widget.analytics,
                                        //               o: widget.observer)),
                                        // );
                                      },
                                      icon: Icon(
                                        Icons.location_on,
                                        size: 22,
                                        color: AppColors.primary,
                                      )),*/
                                ],
                              ),
                              // IconButton(
                              //     padding: EdgeInsets.all(0),
                              //     alignment: global.isRTL
                              //         ? Alignment.centerLeft
                              //         : Alignment.centerRight,
                              //     onPressed: () {
                              //       global.user.id == null
                              //           ? Navigator.of(context).push(
                              //               MaterialPageRoute(
                              //                   builder: (context) =>
                              //                       SignInScreen(
                              //                         a: widget.analytics,
                              //                         o: widget.observer,
                              //                       )),
                              //             )
                              //           : Navigator.of(context).push(
                              //               MaterialPageRoute(
                              //                   builder: (context) =>
                              //                       NotificationScreen(
                              //                           a: widget.analytics,
                              //                           o: widget.observer)),
                              //             );
                              //     },
                              //     icon: Icon(
                              //       Icons.notifications,
                              //       size: 22,
                              //     ))
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
                          child: Text(
                              AppLocalizations.of(context).lbl_user_request,
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
                                          return AppointmentHistoryScreen
                                                  .appointmentHistoryList[index]
                                                  .customerName
                                                  .toLowerCase()
                                                  .contains(searchController
                                                      .text
                                                      .toLowerCase()
                                                      .trim())
                                              ? (AppointmentHistoryScreen
                                                              .appointmentHistoryList[
                                                                  index]
                                                              .statustext ==
                                                          'Pending' ||
                                                      AppointmentHistoryScreen
                                                              .appointmentHistoryList[
                                                                  index]
                                                              .statustext ==
                                                          'Accepted')
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        //_detailDialog(index);
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
                                                          trailing: AppointmentHistoryScreen
                                                                      .appointmentHistoryList[
                                                                          index]
                                                                      .statustext ==
                                                                  "Accepted"
                                                              ? Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              2),
                                                                  child:
                                                                      ElevatedButton(
                                                                    child: const Text(
                                                                        'Complete'),
                                                                    onPressed:
                                                                        () {
                                                                      _requestCancelConfirmationDialog(
                                                                          AppointmentHistoryScreen
                                                                              .appointmentHistoryList[index]
                                                                              .id,
                                                                          'Completed');
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .purple,
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                1,
                                                                            vertical:
                                                                                1),
                                                                        textStyle: const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle: FontStyle.normal)),
                                                                  ),
                                                                )
                                                              : PopupMenuButton(
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                          context) {
                                                                  return [
                                                                    PopupMenuItem(
                                                                      child:
                                                                          new ListTile(
                                                                        leading:
                                                                            Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Theme.of(context).primaryColor,
                                                                        ),
                                                                        title:
                                                                            Text(
                                                                          "Accept",
                                                                          style: Theme.of(context)
                                                                              .primaryTextTheme
                                                                              .subtitle2,
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          _requestCancelConfirmationDialog(
                                                                              AppointmentHistoryScreen.appointmentHistoryList[index].id,
                                                                              'Accepted');
                                                                        },
                                                                      ),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      child:
                                                                          new ListTile(
                                                                        leading:
                                                                            Icon(
                                                                          Icons
                                                                              .cancel,
                                                                          color:
                                                                              Theme.of(context).primaryColor,
                                                                        ),
                                                                        title:
                                                                            Text(
                                                                          "Reject",
                                                                          style: Theme.of(context)
                                                                              .primaryTextTheme
                                                                              .subtitle2,
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          _requestCancelConfirmationDialog(
                                                                              AppointmentHistoryScreen.appointmentHistoryList[index].id,
                                                                              'Rejected');
                                                                          /*Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (context) => AddServiceScreen(
                                                                a: widget.analytics,
                                                                o: widget.observer,
                                                                service: _serviceList[index],
                                                              )));*/
                                                                        },
                                                                      ),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      child:
                                                                          new ListTile(
                                                                        leading: Icon(
                                                                            Icons
                                                                                .delete,
                                                                            color:
                                                                                Theme.of(context).primaryColor),
                                                                        title: Text(
                                                                            AppLocalizations.of(context)
                                                                                .lbl_delete,
                                                                            style:
                                                                                Theme.of(context).primaryTextTheme.subtitle2),
                                                                        onTap:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          _deleteRequestConfirmationDialog(
                                                                              AppointmentHistoryScreen.appointmentHistoryList[index].id,
                                                                              index);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ];
                                                                }),
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
                                                                            5,
                                                                      )
                                                                    : EdgeInsets
                                                                        .only(
                                                                        left: 5,
                                                                      ),
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
                                                                      Container(
                                                                          child:
                                                                              Text(
                                                                        AppointmentHistoryScreen.appointmentHistoryList[index].customerName !=
                                                                                null
                                                                            ? '${AppointmentHistoryScreen.appointmentHistoryList[index].serviceTitle}'
                                                                            : 'No Name',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            2,
                                                                        style: Theme.of(context)
                                                                            .primaryTextTheme
                                                                            .subtitle1,
                                                                      )),
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
                                                                width: 100,
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
                                      child: Text('No Requests Found'),
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

  getUserRequest() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper
            .getAppointmentHistory(global.user.venderId, "Requests")
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
          "Exception - requestScreen.dart - getUserRequest():" + e.toString());
    }
  }

  init(check) async {
    try {
      /* setState(() {
        _isDataLoaded = false;
      });
      */
      var v = AppointmentHistoryScreen.appointmentHistoryList.where((element) =>
          element.statustext == 'Pending' || element.statustext == 'Accepted');
      if (AppointmentHistoryScreen.appointmentHistoryList.isEmpty ||
          check ||
          v.isEmpty) await getUserRequest();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - requestScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init(false);
  }

  _cancelRequest(int orderId, todo) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.cancelRequest(orderId, todo).then((result) {
          if (result) {
            Navigator.of(context).pop();
            var v = AppointmentHistoryScreen.appointmentHistoryList
                .where((element) => element.id == orderId)
                .first;
            v.statustext = todo;
            var s = AppointmentHistoryScreen.appointmentHistoryList
                .where((element) => element.statustext == 'Pending')
                .toList();
            AppointmentHistoryScreen.totalPending = s.length.toString();

            if (todo == "Rejected")
              showSnackBar(
                  key: _scaffoldKey, snackBarMessage: 'Request Rejected');
            else if (todo == "Accepted")
              showSnackBar(
                  key: _scaffoldKey, snackBarMessage: 'Request Accepted');
            else if (todo == "Completed")
              showSnackBar(
                  key: _scaffoldKey, snackBarMessage: 'Request Completed');

            init(false);
          } else {
            Navigator.of(context).pop();
            // showSnackBar(
            //     key: _scaffoldKey, snackBarMessage: 'No Response Try Again!');
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - requestScreen.dart - _cancelRequest():" + e.toString());
    }
  }

  Future _deleteRequestConfirmationDialog(serviceId, _index) async {
    try {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                "Delete Request",
              ),
              content: Text("Are you sure you want to delete this request!"),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context).lbl_no),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context).lbl_yes),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _deleteRequest(serviceId, _index);
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

  _deleteRequest(int serviceId, int _index) async {
    bool isConnected = await br.checkConnectivity();
    if (isConnected) {
      showOnlyLoaderDialog();
      await apiHelper.deleteRequest(serviceId).then((result) {
        if (result) {
          hideLoader();
          var s = AppointmentHistoryScreen.appointmentHistoryList
              .where((element) => element.statustext == 'Pending')
              .toList();
          AppointmentHistoryScreen.totalPending = s.length.toString();
          AppointmentHistoryScreen.appointmentHistoryList.removeAt(_index);
          showSnackBar(
              key: _scaffoldKey, snackBarMessage: '${"Request Deleted"}');
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

  Future _requestCancelConfirmationDialog(orderId, todo) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(todo == 'Accepted'
                ? "Accept request"
                : todo != "Completed"
                    ? AppLocalizations.of(context).lbl_cancel_request
                    : "Completed Request"),
            content: Text(todo == 'Accepted'
                ? "Are you sure to Accept this request?"
                : todo != "Completed"
                    ? AppLocalizations.of(context)
                        .txt_confirmation_message_for_cancel_request
                    : "Are you sure to Save this request as Completed?"),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context).lbl_no),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(AppLocalizations.of(context).lbl_yes),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _cancelRequest(orderId, todo);
/*
                  var v=AppointmentHistoryScreen.appointmentHistoryList.where((element) => element.id==orderId).first;
                  v.statustext=todo;*/
                },
              )
            ],
          );
        });
    await init(false);
  }

  Future _requestCompleteConfirmationDialog(orderId) async {
    try {
      showDialog(
          context: context,
          builder: (context) => UserRequestAcceptDialog(
                orderId,
                false,
                2,
                a: widget.analytics,
                o: widget.observer,
              ));
    } catch (e) {
      print(
          "Exception - requestScreen.dart - _requestCompleteConfirmationDialog():" +
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

  _userRequestDialog(int _index) {
    try {
      showDialog(
          context: context,
          builder: (context) => UserRequestAcceptDialog(
                AppointmentHistoryScreen
                    .appointmentHistoryList[_index].serviceId,
                false,
                1,
                a: widget.analytics,
                o: widget.observer,
              ));
    } catch (e) {
      print(
          'Exception - requestScreen - _userRequestDialog(): ${e.toString()}');
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
}
