import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/couponModel.dart';
import 'package:app/models/serviceModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/screens/serviceListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCouponScreen extends BaseRoute {
  final Coupon coupon;
  AddCouponScreen({a, o, this.coupon})
      : super(a: a, o: o, r: 'AddCouponScreen');
  @override
  _AddCouponScreenState createState() => new _AddCouponScreenState(this.coupon);
}

class _AddCouponScreenState extends BaseRouteState {
  Coupon _coupon = new Coupon();
  TextEditingController _cStartDate = new TextEditingController();
  TextEditingController _cEndDate = new TextEditingController();
  TextEditingController _cUsesRestriction = new TextEditingController();
  TextEditingController _cCouponName = new TextEditingController();
  TextEditingController _cCouponCode = new TextEditingController();
  TextEditingController _cCouponDescription = new TextEditingController();
  TextEditingController _cAmount = new TextEditingController(); //offer price
  TextEditingController _cCartValue =
      new TextEditingController(); //Min service amount

  var _fStartDate = new FocusNode();
  GlobalKey<ScaffoldState> _scaffoldKey;
  var _fEndDate = new FocusNode();
  var _fCouponCode = new FocusNode();
  var _fCouponDescription = new FocusNode();
  var _fAmount = new FocusNode();
  var _fCartValue = new FocusNode();
  var _fUsesRestriction = new FocusNode();
  var _fCouponType = new FocusNode();

  DateTime _startdDate;
  DateTime _endDate;
  var couponType;
  Coupon coupon = Coupon();
  _AddCouponScreenState(this.coupon) : super();

  @override
  Widget build(BuildContext context) {
    return sc(
      Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
              decoration: BoxDecoration(
                  color: AppColors.background,
                  image: DecorationImage(
                      image: AssetImage("assets/partner_background.png"))),
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
                    SizedBox(height: Dimens.space_normal),
                    Container(
                        margin: EdgeInsets.only(
                          top: 30,
                          bottom: 10,
                        ),
                        child: Text(
                            coupon == null
                                ? AppLocalizations.of(context).lbl_Add_coupon
                                : "Edit Coupon",
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
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context).lbl_coupon_name,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(_fCouponCode);
                                  },
                                  controller: _cCouponName,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .hnt_coupon_name,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, left: 10, right: 10),
                                  ),
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context).lbl_coupon_number,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextFormField(
                                  focusNode: _fCouponCode,
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(_fCouponDescription);
                                  },
                                  controller: _cCouponCode,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .hnt_coupon_number,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, left: 10, right: 10),
                                  ),
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .lbl_coupon_description,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  focusNode: _fCouponDescription,
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(_fAmount);
                                  },
                                  controller: _cCouponDescription,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .hnt_description,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, left: 10, right: 10),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .lbl_select_coupon_type,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                ),
                              ),
                              DropdownButtonFormField(
                                items: <String>[
                                  AppLocalizations.of(context).lbl_percentage,
                                  AppLocalizations.of(context).lbl_price,
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2),
                                  );
                                }).toList(),
                                hint: Text(
                                  AppLocalizations.of(context).hnt_coupon_type,
                                  style: Theme.of(context)
                                      .inputDecorationTheme
                                      .hintStyle,
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    couponType = val;
                                  });
                                },
                                value: coupon == null
                                    ? couponType
                                    : coupon.type != null
                                        ? coupon.type.trim()
                                        : couponType,
                                isExpanded: true,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  AppLocalizations.of(context).lbl_offer_price,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextFormField(
                                  focusNode: _fAmount,
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(_fCartValue);
                                  },
                                  controller: _cAmount,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .hnt_offer_price,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, left: 10, right: 10),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .lbl_min_service_amount,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextFormField(
                                  focusNode: _fCartValue,
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(_fUsesRestriction);
                                  },
                                  controller: _cCartValue,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText:
                                        '${global.currency.currency_sign}' +
                                            AppLocalizations.of(context)
                                                .hnt_min_service_amount,
                                    contentPadding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .lbl_select_usesRestriction,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextFormField(
                                  focusNode: _fUsesRestriction,
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(_fCouponType);
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: _cUsesRestriction,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .hnt_usesRestriction,
                                    contentPadding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
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
                                  focusNode: _fStartDate,
                                  controller: _cStartDate,
                                  onTap: () async {
                                    // _selectStartDate();
                                    await _selectDate(context, "start");
                                  },
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
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
                                    hintText: AppLocalizations.of(context)
                                        .hnt_select_end_date,
                                    contentPadding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
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
                          _addCoupon();
                        },
                        child: Container(
                          height: 40,
                          child: Center(
                            child: Text(
                                coupon == null ? "Save Coupon" : "Edit Coupon",
                                style: TextStyle(color: AppColors.surface)),
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.dotColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
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
    if (coupon != null) {
      _cAmount.text = coupon.discount;
      _cEndDate.text = coupon.EndDate.split('T')[0];
      couponType = coupon.type;
      _coupon.id = coupon.id;
      _cCartValue.text = coupon.amount;
      _cCouponCode.text = coupon.Code;
      _cCouponDescription.text = coupon.Description;
      _cStartDate.text = coupon.StartDate.split('T')[0];
      _cCouponName.text = coupon.Name;
      _cUsesRestriction.text = coupon.usageLimit.toString();
    }
    setState(() {});
  }

  _addCoupon() async {
    // try {
    //   _coupon.VendorId = global.user.venderId;
    //   _coupon.Name = _cCouponName.text.trim();

    //   _coupon.Code = _cCouponCode.text.trim();
    //   _coupon.discount = _cAmount.text.trim();
    //   _coupon.Description = _cCouponDescription.text.trim();
    //   if (_cCartValue.text != "") {
    //     _coupon.amount = _cCartValue.text.trim();
    //   }
    //   _coupon.StartDate = _cStartDate.text;
    //   _coupon.EndDate = _cEndDate.text;
    //   if (_cUsesRestriction.text != "") {
    //     _coupon.usageLimit = int.parse(_cUsesRestriction.text.trim());
    //   }

    //   _coupon.type = couponType;

    //   if (_coupon.Name.isNotEmpty &&
    //       _coupon.amount.isNotEmpty &&
    //       _coupon.discount != null &&
    //       _coupon.Code.isNotEmpty &&
    //       _coupon.type != null &&
    //       _coupon.Description.isNotEmpty &&
    //       _coupon.usageLimit != null &&
    //       _coupon.StartDate != null &&
    //       _coupon.EndDate != null) {
    //     bool isConnected = await br.checkConnectivity();
    //     if (isConnected) {
    //       showOnlyLoaderDialog();

    //       if (coupon != null) {
    //         await apiHelper.UpdateCoupon(_coupon).then((result) {
    //           if (result != null) {
    //             hideLoader();

    //             // showDialog(
    //             //     context: context,
    //             //     builder: (BuildContext context) => SaveCouponDialog(
    //             //           a: widget.analytics,
    //             //           o: widget.observer,
    //             //           msg: "Updated",
    //             //         ));
    //             Service.toCheckCouponId = result.id;
    //             Navigator.of(context).push(MaterialPageRoute(
    //                 builder: (context) => ServiceListScreen(
    //                       screenId: 4,
    //                       a: widget.analytics,
    //                       o: widget.observer,
    //                       msg: result.id.toString(),
    //                     )));
    //           } else {
    //             hideLoader();
    //             showSnackBar(
    //                 key: _scaffoldKey, snackBarMessage: 'Coupon Not Updated!');
    //           }
    //         });
    //       } else {
    //         await apiHelper.addCoupon(_coupon).then((result) {
    //           if (result != null) {
    //             hideLoader();
    //             showSnackBar(
    //                 key: _scaffoldKey, snackBarMessage: 'Coupon Added!');
    //             Service.toCheckCouponId = result.id;
    //             Navigator.of(context).push(MaterialPageRoute(
    //                 builder: (context) => ServiceListScreen(
    //                       screenId: 4,
    //                       a: widget.analytics,
    //                       o: widget.observer,
    //                       msg: result.id.toString(),
    //                     )));
    //           } else {
    //             hideLoader();
    //             showSnackBar(
    //                 key: _scaffoldKey, snackBarMessage: 'Coupon Not Added!');
    //           }
    //         });
    //       }
    //     } else {
    //       showNetworkErrorSnackBar(_scaffoldKey);
    //     }
    //   } else if (_coupon.Name.isEmpty) {
    //     showSnackBar(
    //         key: _scaffoldKey,
    //         snackBarMessage:
    //             AppLocalizations.of(context).txt_please_enter_name);
    //   } else if (_coupon.Code.isEmpty) {
    //     showSnackBar(
    //         key: _scaffoldKey,
    //         snackBarMessage:
    //             AppLocalizations.of(context).txt_please_enter_coupon_number);
    //   } else if (_coupon.Description.isEmpty) {
    //     showSnackBar(
    //         key: _scaffoldKey,
    //         snackBarMessage:
    //             AppLocalizations.of(context).txt_please_enter_description);
    //   } else if (_coupon.type.isEmpty) {
    //     showSnackBar(
    //         key: _scaffoldKey, snackBarMessage: 'Please Select Category');
    //   } else if (_coupon.discount == null) {
    //     showSnackBar(
    //         key: _scaffoldKey,
    //         snackBarMessage:
    //             AppLocalizations.of(context).txt_pleae_enter_min_service_price);
    //   } else if (_coupon.amount.isEmpty) {
    //     showSnackBar(
    //         key: _scaffoldKey,
    //         snackBarMessage:
    //             AppLocalizations.of(context).txt_please_enter_offer_price);
    //   } else if (_coupon.usageLimit == null) {
    //     showSnackBar(
    //         key: _scaffoldKey,
    //         snackBarMessage:
    //             AppLocalizations.of(context).txt_please_enter_usesRestriction);
    //   }
    //   /*else if (_coupon.type == null) {
    //     showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_select_coupon_type);
    //   }*/
    //   else if (_coupon.StartDate == null) {
    //     showSnackBar(
    //         key: _scaffoldKey,
    //         snackBarMessage:
    //             AppLocalizations.of(context).txt_please_select_start_date);
    //   } else if (_coupon.EndDate == null) {
    //     showSnackBar(
    //         key: _scaffoldKey,
    //         snackBarMessage:
    //             AppLocalizations.of(context).txt_please_select_end_date);
    //   }
    // } catch (e) {
    //   print("Exception - addCouponScreen.dart - addCoupon():" + e.toString());
    // }
  }
/*
  Future _selectStartDate() async {
    try {
      final DateTime picked = await showDatePicker(
        lastDate: DateTime(2022),
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1940),
      );
      if (picked != null && picked != DateTime(2000)) {
        setState(() {
          _startdDate = picked;
          _cStartDate.text = formatDate(_startdDate, [yyyy, '-', mm, '-', dd]);
        });
      }
      FocusScope.of(context).requestFocus(_fStartDate);
    } catch (e) {
      print('Exception - addCouponScreen.dart - _selectStartDate(): ' +
          e.toString());
    }
  }*/

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
