import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/expertModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/screens/addExpertScreen.dart';
import 'package:app/screens/reviewScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class ExpertListScreen extends BaseRoute {
  final int screenId;
  ExpertListScreen({a, o, this.screenId})
      : super(a: a, o: o, r: 'ExpertListScreen');
  @override
  _ExpertListScreenState createState() =>
      new _ExpertListScreenState(screenId: screenId);
}

class _ExpertListScreenState extends BaseRouteState {
  bool _isDataLoaded = false;
  GlobalKey<ScaffoldState> _scaffoldKey;
  List<Expert> _expertList = [];
  int screenId;
  Expert experts = new Expert();
  _ExpertListScreenState({this.screenId}) : super();

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
              decoration: BoxDecoration(
                  color: AppColors.background,
                  image: DecorationImage(
                      image: AssetImage("assets/partner_background.png"))),
              // height: double.infinity,
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
                          Icon(Icons.menu)
                        ],
                      ),
                    ),
                    SizedBox(height: Dimens.space_normal),
                    Container(
                        margin: EdgeInsets.only(top: 30, bottom: 10),
                        child: Text(AppLocalizations.of(context).lbl_experts,
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0))),
                    _isDataLoaded
                        ? _expertList.length > 0
                            ? Expanded(
                                child: ListView.builder(
                                    itemCount: _expertList.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 95,
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Card(
                                            color: AppColors.surface,
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: global.isRTL
                                                      ? EdgeInsets.only(
                                                          right: 6)
                                                      : EdgeInsets.only(
                                                          left: 6),
                                                  child: CircleAvatar(
                                                    child: _expertList[index]
                                                                .staff_image ==
                                                            'N/A'
                                                        ? Image.asset(
                                                            'assets/sample_image.jpg',
                                                            fit: BoxFit.cover,
                                                          )
                                                        : CachedNetworkImage(
                                                            imageUrl: global
                                                                    .baseUrlForImage +
                                                                _expertList[
                                                                        index]
                                                                    .staff_image,
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                CircleAvatar(
                                                              radius: 30,
                                                              backgroundImage:
                                                                  imageProvider,
                                                            ),
                                                            placeholder: (context,
                                                                    url) =>
                                                                Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                          ),
                                                    radius: 30,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: global.isRTL
                                                        ? EdgeInsets.only(
                                                            right: 15.0,
                                                            top: 10)
                                                        : EdgeInsets.only(
                                                            left: 15.0,
                                                            top: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            '${_expertList[index].staff_name}',
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .subtitle2,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 2),
                                                          child: Text(
                                                            '${_expertList[index].staff_description}',
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .subtitle1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                PopupMenuButton(itemBuilder:
                                                    (BuildContext context) {
                                                  return [
                                                    PopupMenuItem(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      child: new ListTile(
                                                        leading: Icon(
                                                          Icons.edit,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                        title: Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .lbl_edit,
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .subtitle2,
                                                        ),
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          AddExpertScreen(
                                                                            a: widget.analytics,
                                                                            o: widget.observer,
                                                                            experts:
                                                                                _expertList[index],
                                                                          )));
                                                        },
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      child: new ListTile(
                                                        leading: Icon(
                                                            Icons.delete,
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
                                                          Navigator.of(context)
                                                              .pop();
                                                          _deleteExpertConfirmationDialog(
                                                              _expertList[index]
                                                                  .staff_id,
                                                              index);
                                                        },
                                                      ),
                                                    ),
                                                    if (_expertList[index]
                                                            .review !=
                                                        null)
                                                      PopupMenuItem(
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        child: _expertList[
                                                                        index]
                                                                    .review !=
                                                                null
                                                            ? ListTile(
                                                                leading: Icon(
                                                                  Icons
                                                                      .visibility,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                                title: Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .lbl_reviews,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .primaryTextTheme
                                                                      .subtitle2,
                                                                ),
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) => ReviewScreen(
                                                                                a: widget.analytics,
                                                                                o: widget.observer,
                                                                              )));
                                                                },
                                                              )
                                                            : SizedBox(
                                                                height: 0),
                                                      ),
                                                  ];
                                                })
                                              ],
                                            )),
                                      );
                                    }),
                              )
                            : Container(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 3),
                                child: Text(AppLocalizations.of(context)
                                    .txt_expert_will_shown_here))
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
                          builder: (context) => AddExpertScreen(
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                    },
                    child: Container(
                      height: 40,
                      child: Center(
                        child: Text(
                            AppLocalizations.of(context).btn_add_new_expert,
                            style: TextStyle(color: AppColors.surface)),
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.dotColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                )
              : _shimmer1(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
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

  _deleteExpert(int staffId, int _index) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.deleteExpert(staffId).then((result) {
          if (result.status == "1") {
            hideLoader();
            _expertList.removeAt(_index);
            setState(() {});
          } else {
            hideLoader();
            showSnackBar(
                key: _scaffoldKey, snackBarMessage: '${result.message}');
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - expertListScreen.dart - _deleteExpert():" +
          e.toString());
    }
  }

  Future _deleteExpertConfirmationDialog(staffId, _index) async {
    try {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context).lbl_delete_expert,
              ),
              content: Text(AppLocalizations.of(context)
                  .txt_confirmation_message_for_delete_expert),
              actions: [
                TextButton(
                  child: Text(
                    AppLocalizations.of(context).lbl_no,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(
                    AppLocalizations.of(context).lbl_yes,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _deleteExpert(staffId, _index);
                  },
                )
              ],
            );
          });
    } catch (e) {
      print(
          "Exception - expertListScreen.dart - _deleteExpertConfirmationDialog():" +
              e.toString());
    }
  }

  _getExpertReview(int staffId, int _index) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getExpertReview(staffId).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _expertList[_index].review = result.recordList;
            } else {
              _expertList[_index].review = null;
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

  _getExperts() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getExperts(global.user.id).then((result) {
          if (result != null) {
            if (result.status == "1") {
              List<Expert> _tList = result.recordList;

              _expertList.addAll(_tList);
            } else {
              _expertList = [];
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

  _init() async {
    try {
      await _getExperts();
      for (var i = 0; i < _expertList.length; i++) {
        await _getExpertReview(_expertList[i].staff_id, i);
      }

      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - expertListScreen.dart - _init():" + e.toString());
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
}
