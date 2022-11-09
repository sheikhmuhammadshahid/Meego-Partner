import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../models/vendorTimingModel.dart';

class AddTimings extends BaseRoute {
  AddTimings({a, o}) : super(a: a, o: o, r: 'SettingScreen');
  @override
  _AddTimingsState createState() => new _AddTimingsState();
}

class _AddTimingsState extends BaseRouteState {
  bool shopValue = false;
  GlobalKey<ScaffoldState> _scaffoldKey;

  bool isloading = true;
  bool add = true;
  bool show = false;
  VendorTiming timing;
  _AddTimingsState() : super();

  String Day;
  int DayNo;
  var cStartTime = TextEditingController();
  var cEndTime = TextEditingController();

  List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return sc(
      WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                  color: AppColors.background,
                  image: DecorationImage(
                      image: AssetImage("assets/partner_background.png"))),
              // margin: EdgeInsets.only(top: 80),

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Dimens.space_large),
                    Row(
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
                    SizedBox(height: Dimens.space_xxlarge),
                    Container(
                      margin: EdgeInsets.only(top: 30, bottom: 10),
                      child: Text('Time Table',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (show) {
                                        add = true;
                                        show = false;
                                        isloading = true;
                                        timing = null;
                                        cStartTime.text = "";
                                        cEndTime.text = "";
                                        DayNo = null;
                                        Day = null;
                                        init();
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              40,
                                      child: Center(
                                        child: Text('Add Time',
                                            style: TextStyle(
                                                color: AppColors.surface)),
                                      ),
                                      decoration: BoxDecoration(
                                          color: !add
                                              ? AppColors.dotColor
                                              : AppColors.primary,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  width: 5,
                                  thickness: 2,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (add) {
                                        add = false;
                                        show = true;
                                        timing = null;
                                        isloading = true;
                                        init();
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              40,
                                      child: Center(
                                        child: Text('Show Time',
                                            style: TextStyle(
                                                color: AppColors.surface)),
                                      ),
                                      decoration: BoxDecoration(
                                          color: !show
                                              ? AppColors.dotColor
                                              : AppColors.primary,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          !isloading
                              ? show
                                  ? global.user.weekly_time.isNotEmpty
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          child: ListView.builder(
                                              physics: ScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: global
                                                  .user.weekly_time.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int i) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4),
                                                  child: Card(
                                                    child: ListTile(
                                                      title: Text(
                                                        '${global.user.weekly_time[i].days}',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .subtitle1,
                                                      ),
                                                      subtitle: Text(
                                                        '${global.user.weekly_time[i].open_hour} - ${global.user.weekly_time[i].close_hour}',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .subtitle1,
                                                      ),
                                                      trailing: Padding(
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
                                                                leading: Icon(
                                                                    Icons.edit,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor),
                                                                title: Text(
                                                                    "Edit",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .primaryTextTheme
                                                                        .subtitle2),
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  timing = global
                                                                      .user
                                                                      .weekly_time[i];
                                                                  add = true;
                                                                  show = false;
                                                                  init();
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
                                                                  _deleteServiceConfirmationDialog(
                                                                      global
                                                                          .user
                                                                          .weekly_time[
                                                                              i]
                                                                          .time_slot_id,
                                                                      i);
                                                                },
                                                              ),
                                                            ),
                                                          ];
                                                        }),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        )
                                      : SizedBox(
                                          height: 1,
                                        )
                                  : SizedBox(
                                      height: 1,
                                    )
                              : _shimmer2(),
                          add
                              ? Padding(
                                  padding: EdgeInsets.all(50),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        DropdownButtonFormField(
                                          items: <String>[
                                            'Monday',
                                            'Tuesday',
                                            'Wednesday',
                                            'Thursday',
                                            'Friday',
                                            'Saturday',
                                            'Sunday'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .subtitle2),
                                            );
                                          }).toList(),
                                          hint: Text(
                                            "Select Day",
                                            style: Theme.of(context)
                                                .inputDecorationTheme
                                                .hintStyle,
                                          ),
                                          onChanged: (val) {
                                            setState(() {
                                              Day = val;
                                              DayNo = weekDays.indexWhere(
                                                      (element) =>
                                                          element == Day) +
                                                  1;
                                            });
                                          },
                                          value: timing == null
                                              ? Day
                                              : timing.days,
                                          isExpanded: true,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: TextFormField(
                                            controller: cStartTime,
                                            onTap: () async {
                                              await _selectTime(
                                                  context, "start");
                                            },
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: "Select Start Time",
                                              contentPadding: EdgeInsets.only(
                                                  top: 10, left: 10, right: 10),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: TextFormField(
                                            controller: cEndTime,
                                            onTap: () async {
                                              await _selectTime(context, "end");
                                            },
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: 'Select End Time',
                                              contentPadding: EdgeInsets.only(
                                                  top: 10, left: 10, right: 10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 1,
                                ),
                          add
                              ? Padding(
                                  padding: EdgeInsets.all(10),
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();

                                      _saveSetting();
                                    },
                                    child: Container(
                                      height: 40,
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              40,
                                      child: Center(
                                        child: timing == null
                                            ? Text('Save Time',
                                                style: TextStyle(
                                                    color: AppColors.surface))
                                            : Text('Update Time',
                                                style: TextStyle(
                                                    color: AppColors.surface)),
                                      ),
                                      decoration: BoxDecoration(
                                          color: AppColors.dotColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
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
    init();
  }

  init() async {
    if (show) {
      showOnlyLoaderDialog();
      await apiHelper.getUserProfile(global.user.venderId);
      hideLoader();
    } else if (timing != null) {
      cEndTime.text = timing.close_hour.toString();
      cStartTime.text = timing.open_hour.toString();
      Day = timing.days;
      DayNo = weekDays.indexWhere((element) => element == Day) + 1;
    }

    isloading = false;

    setState(() {});
  }

  Future _deleteServiceConfirmationDialog(serviceId, _index) async {
    try {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                'Delete Time Slot',
              ),
              content: Text('Are You Sure to Delete This Slot'),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context).lbl_no),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context).lbl_yes),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _deleteTimeSlot(serviceId, _index);
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

  _deleteTimeSlot(int serviceId, int _index) async {
    bool isConnected = await br.checkConnectivity();
    if (isConnected) {
      showOnlyLoaderDialog();
      await apiHelper.deleteTimeSlot(serviceId).then((result) {
        if (result) {
          hideLoader();
          global.user.weekly_time.removeAt(_index);

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

  _saveSetting() async {
    try {
      if (Day != null &&
          cStartTime.text.isNotEmpty &&
          cEndTime.text.isNotEmpty) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          if (timing == null) {
            showOnlyLoaderDialog();
            await apiHelper
                .saveTime(DayNo, Day, cStartTime.text, cEndTime.text)
                .then((value) {
              if (value) {
                hideLoader();
                showSnackBar(
                    key: _scaffoldKey, snackBarMessage: 'Added Successfully!');
              } else {
                hideLoader();
                showSnackBar(
                    key: _scaffoldKey, snackBarMessage: 'Time Not Added!');
              }
            });
          } else {
            showOnlyLoaderDialog();
            await apiHelper
                .editTime(DayNo, Day, cStartTime.text, cEndTime.text,
                    timing.time_slot_id)
                .then((value) {
              if (value) {
                hideLoader();
                showSnackBar(
                    key: _scaffoldKey,
                    snackBarMessage: 'Updated Successfully!');
              } else {
                hideLoader();
                showSnackBar(
                    key: _scaffoldKey, snackBarMessage: 'Time Not Updated!');
              }
            });
          }
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (Day == null) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Select Day!');
      } else if (cStartTime.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: 'Select Starting Time!');
      } else if (cEndTime.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Select End Time!');
      }
    } catch (e) {}
  }

  Widget _shimmer2() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              height: 70,
              width: (MediaQuery.of(context).size.width) - 30,
              child: Card(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              height: 70,
              width: (MediaQuery.of(context).size.width) - 30,
              child: Card(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              height: 70,
              width: (MediaQuery.of(context).size.width) - 30,
              child: Card(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              height: 70,
              width: (MediaQuery.of(context).size.width) - 30,
              child: Card(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              height: 70,
              width: (MediaQuery.of(context).size.width) - 30,
              child: Card(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              height: 70,
              width: (MediaQuery.of(context).size.width) - 30,
              child: Card(),
            )
          ],
        ));
  }

  Future<dynamic> _selectTime(BuildContext context, todo) async {
    TimeOfDay selected =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selected != null) {
      if (todo == "start") {
        cStartTime.text = "";
        cStartTime.text += selected.hourOfPeriod.toString() + ":";
        if (selected.minute.toString() == "0") {
          cStartTime.text += "00 ";
        } else {
          cStartTime.text += selected.minute.toString() + " ";
        }
        cStartTime.text += selected.period.name;
      } else {
        cEndTime.text = "";
        cEndTime.text += selected.hourOfPeriod.toString() + ":";
        if (selected.minute.toString() == "0") {
          cEndTime.text += "00 ";
        } else {
          cEndTime.text += selected.minute.toString() + " ";
        }
        cEndTime.text += selected.period.name;
      }
    }
  }
}
