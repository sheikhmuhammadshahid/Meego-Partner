import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/serviceModel.dart';
import 'package:app/models/serviceVariantModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/screens/addServiceVariantScreen.dart';
import 'package:app/screens/addServicesScreen.dart';
import 'package:app/screens/couponListScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class ServiceListScreen extends BaseRoute {
  static List<Service> serviceList = [];

  final int screenId;
  final String msg;
  ServiceListScreen({a, o, this.screenId, this.msg})
      : super(a: a, o: o, r: 'ServiceListScreen');
  @override
  _ServiceListScreenState createState() =>
      new _ServiceListScreenState(screenId: screenId, msg: this.msg);
}

class _ServiceListScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;

  int screenId;
  bool _isDataLoaded = false;
  String msg;
  _ServiceListScreenState({this.screenId, this.msg}) : super();
  var searchController = TextEditingController();

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return AppColors.primary;
  }

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
              color: AppColors.background,
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.background,
                      image: DecorationImage(
                          image: AssetImage("assets/partner_background.png"))),
                  // margin: EdgeInsets.only(top: 80),
                  // height: MediaQuery.of(context).size.height - 190,
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
                                    if (screenId == 4) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CouponListScreen(
                                                    a: widget.analytics,
                                                    o: widget.observer,
                                                    caller: 'updated',
                                                  )));
                                    } else
                                      Navigator.pop(context);
                                  },
                                  child: Icon(Icons.arrow_back)),
                              Image.asset('assets/partner_logo.png',
                                  scale: 7.0),
                              Text(' ')
                              /* IconButton(
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    color: Theme.of(context).primaryColor,
                                  )),*/
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
                              AppLocalizations.of(context).lbl_services,
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            )),
                        _isDataLoaded
                            ? ServiceListScreen.serviceList.length > 0
                                ? Expanded(
                                    child: ListView.builder(
                                        itemCount: ServiceListScreen
                                            .serviceList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ServiceListScreen
                                                  .serviceList[index]
                                                  .service_name
                                                  .toLowerCase()
                                                  .contains(searchController
                                                      .text
                                                      .toLowerCase()
                                                      .trim())
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Card(
                                                    color: AppColors.surface,
                                                    child: ExpansionTile(
                                                      tilePadding:
                                                          EdgeInsets.only(
                                                              left: 2),
                                                      children: [
                                                        _serviceVariant1(index)
                                                      ],
                                                      trailing: screenId != 4
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(),
                                                              child: PopupMenuButton(
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
                                                                      leading:
                                                                          Icon(
                                                                        Icons
                                                                            .edit,
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                      ),
                                                                      title:
                                                                          Text(
                                                                        AppLocalizations.of(context)
                                                                            .lbl_edit,
                                                                        style: Theme.of(context)
                                                                            .primaryTextTheme
                                                                            .subtitle2,
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        Navigator.of(context).push(MaterialPageRoute(
                                                                            builder: (context) => AddServiceScreen(
                                                                                  a: widget.analytics,
                                                                                  o: widget.observer,
                                                                                  service: ServiceListScreen.serviceList[index],
                                                                                )));
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
                                                                              .delete,
                                                                          color:
                                                                              Theme.of(context).primaryColor),
                                                                      title: Text(
                                                                          AppLocalizations.of(context)
                                                                              .lbl_delete,
                                                                          style: Theme.of(context)
                                                                              .primaryTextTheme
                                                                              .subtitle2),
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        _deleteServiceConfirmationDialog(
                                                                            ServiceListScreen.serviceList[index].service_id,
                                                                            index);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  /*PopupMenuItem(
                                                        padding: EdgeInsets.all(0),
                                                        child: new ListTile(
                                                          leading: Icon(
                                                            Icons.add,
                                                            color: Theme.of(context).primaryColor,
                                                          ),
                                                          title: Text(
                                                            AppLocalizations.of(context).lbl_add_service_variant,
                                                            style: Theme.of(context).primaryTextTheme.subtitle2,
                                                          ),
                                                          onTap: () {
                                                            Navigator.of(context).pop();
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                builder: (context) => AddServiceVariantScreen(
                                                                      _serviceList[index].service_id,
                                                                      a: widget.analytics,
                                                                      o: widget.observer,
                                                                    )));
                                                          },
                                                        ),
                                                      ),*/
                                                                ];
                                                              }),
                                                            )
                                                          : Checkbox(
                                                              checkColor:
                                                                  Colors.white,
                                                              fillColor: MaterialStateProperty
                                                                  .resolveWith(
                                                                      getColor),
                                                              value: ServiceListScreen
                                                                  .serviceList[
                                                                      index]
                                                                  .isChecked,
                                                              onChanged:
                                                                  (value) {
                                                                if ((value &&
                                                                        ServiceListScreen.serviceList[index].couponId ==
                                                                            null) ||
                                                                    ServiceListScreen
                                                                            .serviceList[index]
                                                                            .couponId ==
                                                                        0 ||
                                                                    !value) {
                                                                  setState(() {
                                                                    ServiceListScreen
                                                                        .serviceList[
                                                                            index]
                                                                        .isChecked = value;
                                                                  });
                                                                } else {
                                                                  showSnackBar(
                                                                      key:
                                                                          _scaffoldKey,
                                                                      snackBarMessage:
                                                                          'Another Coupon is Already Applied.');
                                                                }
                                                              },
                                                            ),
                                                      title: Container(
                                                        //height: 110,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 3,
                                                                      right: 3),
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            7)),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(15))),
                                                                  height: 70,
                                                                  width: 70,
                                                                  child: ServiceListScreen
                                                                              .serviceList[
                                                                                  index]
                                                                              .service_image ==
                                                                          'N/A'
                                                                      ? Image
                                                                          .asset(
                                                                          'assets/sample_image.jpg',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )
                                                                      : CachedNetworkImage(
                                                                          imageUrl: global.baseUrlForImage +
                                                                              "Services/" +
                                                                              ServiceListScreen.serviceList[index].service_image,
                                                                          imageBuilder: (context, imageProvider) =>
                                                                              Container(
                                                                            height:
                                                                                70,
                                                                            decoration:
                                                                                BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: imageProvider)),
                                                                          ),
                                                                          placeholder: (context, url) =>
                                                                              Center(child: CircularProgressIndicator()),
                                                                          errorWidget: (context, url, error) =>
                                                                              Icon(Icons.error),
                                                                        ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: global
                                                                        .isRTL
                                                                    ? EdgeInsets.only(
                                                                        right:
                                                                            15.0,
                                                                        top: 5)
                                                                    : EdgeInsets.only(
                                                                        left:
                                                                            15.0,
                                                                        top: 2),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                        child:
                                                                            Text(
                                                                      '${ServiceListScreen.serviceList[index].service_name}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .primaryTextTheme
                                                                          .subtitle2,
                                                                      maxLines:
                                                                          2,
                                                                    )),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              2),
                                                                      child:
                                                                          Text(
                                                                        ServiceListScreen.serviceList[index].Time !=
                                                                                null
                                                                            ? ServiceListScreen.serviceList[index].Time +
                                                                                " Hour"
                                                                            : " ",
                                                                        style: Theme.of(context)
                                                                            .primaryTextTheme
                                                                            .subtitle1,
                                                                        overflow:
                                                                            TextOverflow.clip,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              1),
                                                                      child:
                                                                          Text(
                                                                        ServiceListScreen.serviceList[index].Time !=
                                                                                null
                                                                            ? ServiceListScreen.serviceList[index].rate +
                                                                                " RS"
                                                                            : " ",
                                                                        style: Theme.of(context)
                                                                            .primaryTextTheme
                                                                            .subtitle1,
                                                                        overflow:
                                                                            TextOverflow.clip,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              2),
                                                                      child:
                                                                          Text(
                                                                        ServiceListScreen.serviceList[index].createdAt !=
                                                                                null
                                                                            ? '${ServiceListScreen.serviceList[index].createdAt.toString().split(' ')[0]}'
                                                                            : '',
                                                                        style: Theme.of(context)
                                                                            .primaryTextTheme
                                                                            .subtitle1,
                                                                        overflow:
                                                                            TextOverflow.clip,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
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
                                    child: Text('No Services Found'),
                                  ))
                            : Expanded(child: _shimmer())
                      ],
                    ),
                  )),
            ),
            floatingActionButton: _isDataLoaded
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.25,
                      vertical: Dimens.space_medium,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        screenId != 4
                            ? Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddServiceScreen(
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )))
                            : saveServices();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: Center(
                          child: Text(
                              screenId != 4
                                  ? AppLocalizations.of(context)
                                      .btn_add_new_service
                                  : 'Apply to Services',
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

  getService() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getService(global.user.venderId).then((result) {
          if (result != null) {
            ServiceListScreen.serviceList = result;
          } else {
            ServiceListScreen.serviceList = [];
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - serviceListScreen.dart - _getServices():" +
          e.toString());
    }
  }

  init(check) async {
    if (check ||
        ServiceListScreen.serviceList.isEmpty ||
        msg == 'updated' ||
        screenId == 4) await getService();
    await apiHelper.getCategories();
    _isDataLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init(false);
  }

  _deleteService(int serviceId, int _index) async {
    bool isConnected = await br.checkConnectivity();
    if (isConnected) {
      showOnlyLoaderDialog();
      await apiHelper.deleteService(serviceId).then((result) {
        if (result) {
          hideLoader();
          ServiceListScreen.serviceList.removeAt(_index);
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
                    await _deleteService(serviceId, _index);
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

  _deleteServiceVariant(int varientId, int _index, int parentId) async {
    try {
      showOnlyLoaderDialog();
      await apiHelper.deleteServiceVariant(varientId).then((result) {
        if (result.status == '1') {
          hideLoader();
          ServiceListScreen.serviceList[parentId].varients.removeAt(_index);

          setState(() {});
        } else {
          hideLoader();
          showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
        }
      });
    } catch (e) {
      print("Exception - serviceListScreen.dart - _deleteServiceVariant():" +
          e.toString());
    }
  }

  Future _deleteServiceVariantConfirmationDialog(
      varientId, _index, parentId) async {
    try {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context).lbl_delete_service_variant,
              ),
              content: Text(AppLocalizations.of(context)
                  .txt_confirmation_message_for_delete_service_variant),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context).lbl_no),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context).lbl_yes),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _deleteServiceVariant(varientId, _index, parentId);
                  },
                )
              ],
            );
          });
    } catch (e) {
      print(
          "Exception - serviceListScreen.dart - _deleteServiceVariantConfirmationDialog():" +
              e.toString());
    }
  }

  Widget _serviceVariant1(int index) {
    try {
      List<ServiceVariant> _serviceVariant = [];
      _serviceVariant = ServiceListScreen.serviceList[index].varients;

      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _serviceVariant.length,
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
                trailing: Container(
                  height: 40,
                  width: 100,
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1)),
                        padding: EdgeInsets.only(
                            left: 5, right: 2, top: 2, bottom: 2),
                        child: Center(
                            child: Text(
                          '${global.currency.currency_sign} ${_serviceVariant[i].price}',
                          overflow: TextOverflow.ellipsis,
                        )),
                      ),
                      Container(
                        width: 30,
                        padding: const EdgeInsets.only(),
                        child: PopupMenuButton(
                            itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              padding: EdgeInsets.all(0),
                              child: new ListTile(
                                leading: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: Text(
                                  AppLocalizations.of(context).lbl_edit,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          AddServiceVariantScreen(
                                            _serviceVariant[i].service_id,
                                            a: widget.analytics,
                                            o: widget.observer,
                                            serviceVariant: _serviceVariant[i],
                                          )));
                                },
                              ),
                            ),
                            PopupMenuItem(
                              padding: EdgeInsets.all(0),
                              child: new ListTile(
                                leading: Icon(Icons.delete,
                                    color: Theme.of(context).primaryColor),
                                title: Text(
                                    AppLocalizations.of(context).lbl_delete,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle2),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _deleteServiceVariantConfirmationDialog(
                                      _serviceVariant[i].varient_id, i, index);
                                },
                              ),
                            ),
                          ];
                        }),
                      ),
                    ],
                  ),
                ),
                leading: Container(
                  margin: EdgeInsets.only(right: 6),
                  width: 35,
                  child: Text(
                    "${i + 1}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                title: Text('${_serviceVariant[i].varient}'),
                subtitle: Text('${_serviceVariant[i].time}' +
                    " " +
                    AppLocalizations.of(context).lbl_min));
          });
    } catch (e) {
      print("Exception - serviceListScreen.dart - _serviceVariant1():" +
          e.toString());
      return null;
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
                    Container(
                      height: 90,
                      width: 80,
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
    for (var v in ServiceListScreen.serviceList) {
      if (v.service_name
          .toLowerCase()
          .contains(searchController.text.toLowerCase().trim())) {
        con = true;
      }
    }
    return con;
  }

  dothis() {
    if (searchController.text != "") {
      if (ServiceListScreen.serviceList.isNotEmpty) {
        if (check()) {
          setState(() {});
        } else {
          showSnackBar(key: _scaffoldKey, snackBarMessage: 'No Service Found');
          setState(() {});
        }
      } else {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: 'No Services to Search!');
      }
    } else {
      showSnackBar(
          key: _scaffoldKey, snackBarMessage: 'Enter a name to Search!');
    }
  }

  saveServices() async {
    try {
      var lst =
          ServiceListScreen.serviceList.where((element) => element.isChecked);

      List<int> l = [];
      for (var v in lst) {
        l.add(v.service_id);
      }
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.addServicesToApplyCoupon(l, msg).then((value) {
          if (value) {
            hideLoader();
            showSnackBar(
                key: _scaffoldKey, snackBarMessage: "Applied Successfully!");
          } else {
            hideLoader();
            showSnackBar(
                key: _scaffoldKey, snackBarMessage: "Can't Apply Try Again!");
          }
        });
      } else
        showNetworkErrorSnackBar(_scaffoldKey);
    } catch (e) {
      print(
          "Exception - serviceListScreen.dart - saveService():" + e.toString());
    }
  }
}
