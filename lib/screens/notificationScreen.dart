import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/notificationModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/screens/homeScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:app/widgets/bottomNavigationBar.dart';

class NotificationScreen extends BaseRoute {
  static int v = -1;
  static bool isinNotification = false;
  static List<Notifications> _notificationList = [];
  NotificationScreen({a, o}) : super(a: a, o: o, r: 'NotificationScreen');
  @override
  _NotificationScreenState createState() => new _NotificationScreenState();
}

class _NotificationScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;

  bool _isDataLoaded = false;
  _NotificationScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return sc(
      WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
          body: _isDataLoaded
              ? NotificationScreen._notificationList.isNotEmpty
                  ? Column(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Stack(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigationWidget(
                                                    a: widget.analytics,
                                                    o: widget.observer,
                                                  )));
                                    },
                                    icon: Icon(Icons.arrow_back)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context).lbl_notification,
                                style: TextStyle(
                                    color: AppColors.primary, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount:
                                NotificationScreen._notificationList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                                bottom: 20, top: 20, left: 10, right: 10),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: InkWell(
                                  onLongPress: () {
                                    _deleteServiceConfirmationDialog(
                                        NotificationScreen
                                            ._notificationList[index].id,
                                        index);
                                  },
                                  child: Card(
                                      color: NotificationScreen
                                              ._notificationList[index].isSeen
                                          ? AppColors.greyLight
                                          : AppColors.secondaryVariant,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: global.isRTL
                                              ? BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20))
                                              : BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20))),
                                      child: ExpansionTile(
                                        onExpansionChanged: (value) {
                                          if (!value) {
                                            setState(() {
                                              NotificationScreen.v = -1;
                                            });
                                          }
                                          if (value) {
                                            setState(() {
                                              NotificationScreen.v = index;
                                            });
                                            if (!NotificationScreen
                                                ._notificationList[index]
                                                .isSeen)
                                              _updateStatus(NotificationScreen
                                                  ._notificationList[index].id);
                                          }
                                        },
                                        leading: Container(
                                          padding: EdgeInsets.only(
                                              top: 3, bottom: 3),
                                          margin: global.isRTL
                                              ? EdgeInsets.only(right: 0)
                                              : EdgeInsets.only(left: 0),
                                          child: CircleAvatar(
                                            child: NotificationScreen
                                                            ._notificationList[
                                                                index]
                                                            .userImage ==
                                                        null ||
                                                    NotificationScreen
                                                            ._notificationList[
                                                                index]
                                                            .userImage ==
                                                        'https://thecodecafe.in/gofresha/N/A'
                                                ? CircleAvatar(
                                                    radius: 28,
                                                    backgroundColor:
                                                        AppColors.surface,
                                                    backgroundImage: AssetImage(
                                                      "assets/userImage.png",
                                                    ),
                                                  )
                                                : CachedNetworkImage(
                                                    color: AppColors.surface,
                                                    imageUrl: global
                                                            .baseUrlForImage +
                                                        "Users/" +
                                                        NotificationScreen
                                                            ._notificationList[
                                                                index]
                                                            .userImage,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        CircleAvatar(
                                                      radius: 28,
                                                      backgroundImage:
                                                          imageProvider,
                                                    ),
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                            radius: 28,
                                          ),
                                        ),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              '${NotificationScreen._notificationList[index].body}',
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .subtitle1,
                                            ),
                                          ),
                                        ],
                                        title: RichText(
                                          text: TextSpan(
                                            text: NotificationScreen
                                                ._notificationList[index]
                                                .userName,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .subtitle2,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: NotificationScreen.v !=
                                                          index
                                                      ? "  " +
                                                          NotificationScreen
                                                              ._notificationList[
                                                                  index]
                                                              .time
                                                      : "",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                        ),
                                        subtitle: NotificationScreen.v != index
                                            ? Text(
                                                NotificationScreen
                                                    ._notificationList[index]
                                                    .body,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .subtitle1,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              )
                                            : Text(
                                                NotificationScreen
                                                        ._notificationList[
                                                            index]
                                                        .date
                                                        .replaceAll('/m', '') +
                                                    "  " +
                                                    NotificationScreen
                                                        ._notificationList[
                                                            index]
                                                        .time,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                      )),
                                ),
                              );
                            }),
                      ),
                    ])
                  : Center(
                      child: Text("No Notifications Found."),
                    )
              : _shimmer(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _updateStatus(int id) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.updateRead(id).then((result) {
          if (result) {
            setState(() {
              var v = NotificationScreen._notificationList
                  .where((element) => element.id == id)
                  .first;
              if (HomeScreen.notificationsCount > 0)
                HomeScreen.notificationsCount--;
              v.isSeen = true;
            });
          } else {}
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - notificationScreen.dart - _getNotification():" +
          e.toString());
    }
  }

  getNotification() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getNotification(global.user.id).then((result) {
          if (result != null) {
            NotificationScreen._notificationList = result;
          } else {
            NotificationScreen._notificationList = [];
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - notificationScreen.dart - _getNotification():" +
          e.toString());
    }
  }

  init() async {
    try {
      await getNotification();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - notificationScreen.dart - init():" + e.toString());
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
            itemCount: 9,
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

  _deleteNotification(int notid, int _index) async {
    bool isConnected = await br.checkConnectivity();
    if (isConnected) {
      showOnlyLoaderDialog();
      await apiHelper.deleteNotification(notid).then((result) {
        if (result) {
          hideLoader();
          NotificationScreen._notificationList.removeAt(_index);
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
              title: Text('Delete Notification'),
              content: Text('Are You Sure to delete this Notification'),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context).lbl_no),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context).lbl_yes),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _deleteNotification(serviceId, _index);
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
}
