import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';

import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shimmer/shimmer.dart';
import 'package:tab_container/tab_container.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends BaseRoute {
  SupportScreen({a, o}) : super(a: a, o: o, r: 'HelpAndSupportScreen');
  @override
  _SupportScreenState createState() => new _SupportScreenState();
}

class _SupportScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;

  bool _isDataLoaded = false;
  _SupportScreenState() : super();
  TabContainerController _controller;
  TextTheme textTheme;

  List<CreditCardData> data = [];
  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return sc(
      WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                  child: Container(
                    height: MediaQuery.of(context).size.height - 181,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                Image.asset('assets/partner_logo.png',
                                    scale: 7.0),
                                Text(' ')
                              ],
                            ),
                          ),
                          SizedBox(height: Dimens.space_xxlarge),
                          Container(
                              margin: EdgeInsets.only(top: 30, bottom: 10),
                              child: Text('Support',
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0))),
                          _isDataLoaded
                              ? data.isNotEmpty
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      child: AspectRatio(
                                        aspectRatio: 10 / 8,
                                        child: TabContainer(
                                          radius: 20,
                                          tabEdge: TabEdge.top,
                                          tabCurve: Curves.bounceIn,
                                          transitionBuilder:
                                              (child, animation) {
                                            animation = CurvedAnimation(
                                                curve: Curves.easeIn,
                                                parent: animation);
                                            return SlideTransition(
                                              position: Tween(
                                                begin: const Offset(0.2, 0.0),
                                                end: const Offset(0.0, 0.0),
                                              ).animate(animation),
                                              child: FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              ),
                                            );
                                          },
                                          colors: const <Color>[
                                            AppColors.dotColor,
                                            AppColors.dotColor,
                                            AppColors.dotColor,
                                          ],
                                          selectedTextStyle: textTheme.bodyText2
                                              ?.copyWith(fontSize: 15.0),
                                          unselectedTextStyle: textTheme
                                              .bodyText2
                                              ?.copyWith(fontSize: 13.0),
                                          children: _getChildren1(),
                                          tabs: _getTabs1(),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Text('No Support data Found'),
                                    )
                              : _shimmer()
                        ],
                      ),
                    ),
                  ),
                ))),
      ),
    );
  }

  List<Widget> _getChildren1() {
    List<CreditCard> lst = [];
    for (int i = 0; i < data.length; i++) {
      if (i == 0)
        lst.add(CreditCard(data: data[0], toShow: 'call'));
      else if (i == 1)
        lst.add(CreditCard(data: data[1], toShow: 'whatsapp'));
      else
        lst.add(CreditCard(data: data[2], toShow: 'email'));
    }
    return lst;
  }

  List<String> _getTabs1() {
    List<String> cards = ['Call', 'WhatsApp', 'Email'];

    return cards;
  }

  getFaqs() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getSupportData().then((result) {
          if (result != null) {
            data = result;
          } else {
            data = [];
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - helpAndSupportScreen.dart - _getFaqs():" + e.toString());
    }
  }

  init() async {
    try {
      await getFaqs();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - helpAndSupportScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    _controller = TabContainerController(length: 3);
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
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 60,
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card());
            }),
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  final Color color;

  final CreditCardData data;
  final String toShow;
  const CreditCard({
    Key key,
    this.toShow,
    this.color,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: data.data.length,
            itemBuilder: (context, int index) {
              return data.data[index] != ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        toShow == 'call'
                            ? IconButton(
                                onPressed: () async {
                                  await _contact(context, data.data[index]);
                                },
                                icon: Icon(Icons.call))
                            : toShow == 'whatsapp'
                                ? IconButton(
                                    onPressed: () async {
                                      await _contact(context, data.data[index]);
                                    },
                                    icon: Icon(Icons.whatsapp))
                                : IconButton(
                                    onPressed: () async {
                                      await _contact(context, data.data[index]);
                                    },
                                    icon: Icon(Icons.email)),
                        TextButton(
                            onLongPress: () {
                              Clipboard.setData(
                                  ClipboardData(text: data.data[index]));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: new Text("Copied to Clipboard"),
                                duration: Duration(milliseconds: 1000),
                              ));
                            },
                            onPressed: () async {
                              await _contact(context, data.data[index]);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text(data.data[index])))
                      ],
                    )
                  : SizedBox();
            }));
  }

  _contact(context, data) async {
    if (toShow == 'whatsapp') {
      if (Platform.isAndroid) {
        var v = 'whatsapp://send?phone=${data.toString()}&text=' '';
        var k = await canLaunchUrl(Uri.parse(v));
        if (k) {
          launch(v);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: new Text("Whatsapp not installed")));
        }
      } else if (Platform.isIOS) {
        var url = "https://wa.me/${data.toString()}?text=${Uri.parse("")}";
        if (await canLaunch(url)) {
          await launch(url, forceSafariVC: false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: new Text("Whatsapp not installed")));
        }
      }
    } else if (toShow == 'call') {
      var url = "tel:$data";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("Dialer can't open")));
      }
    } else {
      var url = "mailto:$data";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("Email App not installed")));
      }
    }
  }
}

class CreditCardData {
  int index;

  List<int> id = [];
  List<String> data = [];

  CreditCardData(this.index);
}
