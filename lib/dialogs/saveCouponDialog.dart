import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/screens/couponListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaveCouponDialog extends BaseRoute {
  final String msg;
  SaveCouponDialog({a, o, this.msg}) : super(a: a, o: o, r: 'SaveCouponDialog');
  @override
  _SaveCouponDialogState createState() => new _SaveCouponDialogState(this.msg);
}

class _SaveCouponDialogState extends BaseRouteState {
  bool isloading = true;
  String msg = "";
  _SaveCouponDialogState(this.msg) : super();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 0, right: 0),
      content: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 28,
              child: Icon(
                Icons.check,
                size: 40,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: [
                    Text(
                      msg == null
                          ?
                          //AppLocalizations.of(context).txt_successfully_add_your_new_coupon
                          "Coupon Added Successfully!"
                          : "Coupon Updated Successfully!",
                      style: Theme.of(context).primaryTextTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.only(top: 15, bottom: 15))),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CouponListScreen(
                                a: widget.analytics,
                                o: widget.observer,
                                screenId: 1,
                                caller: "updated",
                              )));
                    },
                    child: Text(
                      AppLocalizations.of(context).lbl_ok,
                    )),
              ),
            )
          ],
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
  }
}
