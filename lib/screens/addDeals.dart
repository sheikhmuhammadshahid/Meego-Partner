import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../dialogs/updateProfileSuccessDialog.dart';
import '../models/Deal.dart';
import '../models/createDealModel.dart';

class AddDealScreen extends BaseRoute {
  final Deal deal;
  AddDealScreen({a, o, this.deal}) : super(a: a, o: o, r: 'AddCouponScreen');
  @override
  _AddDealScreenState createState() => new _AddDealScreenState(this.deal);
}

class _AddDealScreenState extends BaseRouteState {
  TextEditingController _dealName = TextEditingController();
  String _dealCategory;
  Deal deal;
  _AddDealScreenState(this.deal);
  TextEditingController _discount = TextEditingController();
  TextEditingController _description = TextEditingController();

  var _fdescription = FocusNode();
  var _fdealName = FocusNode();
  var _fdealCategory = FocusNode();
  List<DropdownMenuItem> items = [];
  var _fdiscount = FocusNode();
  List<Deal> dealscategories = [];
  TextEditingController _cStartDate = TextEditingController();
  TextEditingController _cEndDate = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    var _fStartDate = FocusNode();
    var _fEndDate = FocusNode();
    return sc(
      Scaffold(
          // resizeToAvoidBottomInset: false,
          body: !isLoading
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.background,
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/partner_background.png"))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: Dimens.space_large),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.space_large),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back)),
                                  Image.asset('assets/partner_logo.png',
                                      scale: 7.0),
                                  Text(' ')
                                ],
                              ),
                            ),
                            SizedBox(height: Dimens.space_normal),
                            Container(
                                margin: EdgeInsets.only(
                                  top: 30,
                                  bottom: 10,
                                ),
                                child: Text('Add Deal',
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0))),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 15.0,
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Deal Name',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          onEditingComplete: () {
                                            FocusScope.of(context)
                                                .requestFocus(_fdealCategory);
                                          },
                                          controller: _dealName,
                                          decoration: InputDecoration(
                                            hintText: '20 % off etc..',
                                            contentPadding: EdgeInsets.only(
                                                top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Deal Category',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      DropdownButtonFormField(
                                        focusNode: _fdealCategory,
                                        items: items.toList(),
                                        hint: Text(
                                          AppLocalizations.of(context)
                                              .hnt_coupon_type,
                                          style: Theme.of(context)
                                              .inputDecorationTheme
                                              .hintStyle,
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            _dealCategory = val;
                                          });
                                        },
                                        value: _dealCategory,
                                        isExpanded: true,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Discount ( in % )',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          focusNode: _fdiscount,
                                          controller: _discount,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: '20',
                                            contentPadding: EdgeInsets.only(
                                                top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .lbl_select_start_date,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          focusNode: _fStartDate,
                                          controller: _cStartDate,
                                          onTap: () async {
                                            // _selectStartDate();
                                            await _selectDate(context, "start");
                                          },
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .hnt_select_start_date,
                                            contentPadding: EdgeInsets.only(
                                                top: 10, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .lbl_select__end_date,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          focusNode: _fEndDate,
                                          controller: _cEndDate,
                                          onTap: () async {
                                            await _selectDate(context, "end");
                                          },
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .hnt_select_end_date,
                                            contentPadding: EdgeInsets.only(
                                                top: 10, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Description',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          maxLines: 5,
                                          focusNode: _fdescription,
                                          controller: _description,
                                          //keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'Description',
                                            contentPadding: EdgeInsets.only(
                                                top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(14),
                              child: GestureDetector(
                                onTap: () {
                                  _addDeal();
                                },
                                child: Container(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                        deal != null
                                            ? "Update Deal"
                                            : "Save Deal",
                                        style: TextStyle(
                                            color: AppColors.surface)),
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppColors.dotColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                )
              : SizedBox()),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void init() async {
    await getDealCategories();

    for (var v in dealscategories) {
      items.add(DropdownMenuItem(child: Text(v.name), value: v.name));
    }
    if (deal != null) {
      _cEndDate.text = deal.endDate.split('T')[0];
      _cStartDate.text = deal.startDate.split('T')[0];
      _dealName.text = deal.name;
      _dealCategory = deal.dealCategoryName;
      _description.text =
          deal.description.replaceAll('<p>', '').replaceAll('</p>', '');
      _discount.text = deal.discount.toString();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  _addDeal() async {
    try {
      if (_discount.text.isNotEmpty &&
          _cEndDate.text.isNotEmpty &&
          _cStartDate.text.isNotEmpty &&
          _dealCategory != "" &&
          _description.text.isNotEmpty &&
          _dealName.text.isNotEmpty) {
        if (int.parse(_discount.text) < 100) {
          bool isConnected = await br.checkConnectivity();
          if (isConnected) {
            showOnlyLoaderDialog();

            var v = dealscategories
                .where((element) => element.name == _dealCategory)
                .first;

            CreateDealModel d = CreateDealModel(
                dealCategoryId: v.dealCategoryId,
                name: _dealName.text,
                discount: double.parse(_discount.text),
                startDate: _cStartDate.text,
                endDate: _cEndDate.text,
                vendorId: global.user.venderId,
                description: _description.text);
            String todo;
            if (deal == null) {
              todo = "add";
            } else {
              todo = "update";
              d.dealId = deal.id;
            }
            await apiHelper.AddDeal(d, todo).then((result) {
              if (result != null) {
                hideLoader();
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        UpdateProfileSuccessDialog(
                          a: widget.analytics,
                          o: widget.observer,
                          msg: result,
                          caller: 'adddeal',
                        ));

                //showSnackBar(key: _scaffoldKey, snackBarMessage: result);
              } else {
                hideLoader();
                showSnackBar(
                    key: _scaffoldKey, snackBarMessage: 'Deal Not Added!');
              }
            });
          } else {
            showNetworkErrorSnackBar(_scaffoldKey);
          }
        } else {
          showSnackBar(
              key: _scaffoldKey,
              snackBarMessage: "Discount must be less than 100 ");
        }
      } else if (_dealName.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_name);
      } else if (_dealCategory == null) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Select Deal ');
      } else if (_discount.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: 'Enter discount Amount');
      } else if (_cStartDate.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Select Start Date');
      } else if (_cEndDate.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Select End Date');
      } else if (_description.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Enter Description');
      }
    } catch (e) {
      print("Exception - addCouponScreen.dart - addCoupon():" + e.toString());
    }
  }

  Future getDealCategories() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.getDealsCategory().then((result) {
          if (result.isNotEmpty) {
            dealscategories = result;
          }
          hideLoader();
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - couponListScreen.dart - _getCoupon():" + e.toString());
    }
  }

  DateTime _startdDate;
  DateTime _endDate;
  Future<DateTime> _selectDate(BuildContext context, todo) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        todo == "start"
            ? _cStartDate.text = selectedDate.toString().split(' ')[0]
            : _cEndDate.text = selectedDate.toString().split(' ')[0];
        todo == "start" ? _startdDate = selected : _endDate = selected;
      });
    }
    return selectedDate;
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime dateTime = DateTime.now();
  bool showDate = false;
  bool showTime = false;
  bool showDateTime = false;
// Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }
}
