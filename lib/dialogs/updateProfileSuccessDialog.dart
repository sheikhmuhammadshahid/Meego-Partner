import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screens/DealsListScreen.dart';
import '../screens/signInScreen.dart';

class UpdateProfileSuccessDialog extends BaseRoute {
  final String msg;
  final String caller;
  UpdateProfileSuccessDialog({a, o, this.caller, this.msg})
      : super(a: a, o: o, r: 'UpdateProfileSuccessDialog');
  @override
  _UpdateProfileSuccessDialogState createState() =>
      new _UpdateProfileSuccessDialogState(this.msg, this.caller);
}

class _UpdateProfileSuccessDialogState extends BaseRouteState {
  bool isloading = true;
  String msg;
  String caller;
  _UpdateProfileSuccessDialogState(this.msg, this.caller) : super();

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
              padding: msg == null
                  ? EdgeInsets.only(top: 15)
                  : EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Container(
                width: msg == null
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      caller == null
                          ? AppLocalizations.of(context)
                              .txt_successfully_changed_your_profile
                          : caller == 'signed up'
                              ? "Thank You for becoming Meego Partner. We're reviewing your information" +
                                  " and your account will be activated once it's approved."
                              : msg,
                      style: msg == null
                          ? Theme.of(context).primaryTextTheme.headline6
                          : TextStyle(fontWeight: FontWeight.normal),
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
                    msg != null
                        ? msg != 'checking'
                            ? caller == 'adddeal'
                                // ignore: unnecessary_statements
                                ? {
                                    Navigator.pop(context),
                                    Navigator.pop(context),
                                    Navigator.pop(context),
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DealListScreen(
                                                  a: widget.analytics,
                                                  o: widget.observer,
                                                )))
                                  }
                                : Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignInScreen(
                                        a: widget.analytics,
                                        o: widget.observer,
                                      ),
                                    ),
                                  )
                            : Navigator.pop(context)
                        : Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BottomNavigationWidget(
                                  a: widget.analytics,
                                  o: widget.observer,
                                )));
                  },
                  child: Text('Ok'),
                ),
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
