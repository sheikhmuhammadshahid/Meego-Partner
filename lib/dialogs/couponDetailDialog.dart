import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/couponModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CouponDetailDialog extends BaseRoute {
  final Coupon coupondetail;
  CouponDetailDialog(this.coupondetail, {a, o}) : super(a: a, o: o, r: 'CouponDetailDialog');
  @override
  _CouponDetailDialogState createState() => new _CouponDetailDialogState(this.coupondetail);
}

class _CouponDetailDialogState extends BaseRouteState {
  Coupon coupondetail;

  bool _isDataLoaded = false;

  bool isloading = true;

  _CouponDetailDialogState(this.coupondetail) : super();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        _isDataLoaded
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                        decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(05))),
                        child: Text(
                          AppLocalizations.of(context).lbl_ok,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        )),
                  ),
                ],
              )
            : SizedBox()
      ],
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      contentPadding: EdgeInsets.only(top: 25, left: 10, right: 10),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _isDataLoaded
                  ? _widgetList()
                  : [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  init() async {
    try {
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - couponDetailDialog.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  List<Widget> _widgetList() {
    List<Widget> _widgetList = [];
    try {
      _widgetList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Coupon Detail',
            style: Theme.of(context).primaryTextTheme.headline3,
          )
        ],
      ));
      coupondetail.Name != null
          ? _widgetList.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name',
                ),
                Text('${coupondetail.Name}', style: Theme.of(context).primaryTextTheme.subtitle1)
              ],
            ))
          : SizedBox();
      coupondetail.Code != null
          ? _widgetList.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Code',
                ),
                Text('${coupondetail.Code}', style: Theme.of(context).primaryTextTheme.subtitle1)
              ],
            ))
          : SizedBox();

      coupondetail.amount != null
          ? _widgetList.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Amount'),
                Text(
                  '${coupondetail.amount}',
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                )
              ],
            ))
          : SizedBox();
      coupondetail.Description != null
          ? _widgetList.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description',
                ),
                Text('${coupondetail.Description}', style: Theme.of(context).primaryTextTheme.subtitle1)
              ],
            ))
          : SizedBox();
      coupondetail.type != null
          ? _widgetList.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Type',
                ),
                Text('${coupondetail.type}', style: Theme.of(context).primaryTextTheme.subtitle1)
              ],
            ))
          : SizedBox();
      coupondetail.usageLimit != null
          ? _widgetList.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'User Restriction',
                ),
                Text('${coupondetail.usageLimit}', style: Theme.of(context).primaryTextTheme.subtitle1)
              ],
            ))
          : SizedBox();
      coupondetail.StartDate != null
          ? _widgetList.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Start Date',
                ),
                Text('${DateTime.parse(coupondetail.StartDate).day}-${DateTime.parse(coupondetail.StartDate).month}-${DateTime.parse(coupondetail.StartDate).year}', style: Theme.of(context).primaryTextTheme.subtitle1)
              ],
            ))
          : SizedBox();
      coupondetail.EndDate != null
          ? _widgetList.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'End Date ',
                ),
                Text('${DateTime.parse(coupondetail.EndDate).day}-${DateTime.parse(coupondetail.EndDate).month}-${DateTime.parse(coupondetail.EndDate).year}', style: Theme.of(context).primaryTextTheme.subtitle1)
              ],
            ))
          : SizedBox();

      return _widgetList;
    } catch (e) {
      print("Exception - couponDetailDialog.dart - _widgetList():" + e.toString());
      return _widgetList;
    }
  }
}
