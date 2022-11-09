import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/faqModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class HelpAndSupportScreen extends BaseRoute {
  HelpAndSupportScreen({a, o}) : super(a: a, o: o, r: 'HelpAndSupportScreen');
  @override
  _HelpAndSupportScreenState createState() => new _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;
  List<Faqs> _faqList = [];
  bool _isDataLoaded = false;
  _HelpAndSupportScreenState() : super();

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
                              child: Text(
                                  AppLocalizations.of(context)
                                      .lbl_help_and_support,
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0))),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context).lbl_faq,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          _isDataLoaded
                              ? _faqList.length > 0
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              181,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: _faqList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Card(
                                              color: AppColors.surface,
                                              margin:
                                                  EdgeInsets.only(bottom: 8),
                                              elevation: 2,
                                              child: ExpansionTile(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        '${_faqList[index].answer}',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .subtitle1,
                                                      ),
                                                    )
                                                  ],
                                                  title: Text(
                                                    '${index + 1}. ${_faqList[index].question}',
                                                  )),
                                            );
                                          }),
                                    )
                                  : Center(
                                      child: Text(AppLocalizations.of(context)
                                          .txt_faq_will_shown_here),
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

  @override
  void dispose() {
    super.dispose();
  }

  getFaqs() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getFaqs().then((result) {
          if (result != null) {
            if (result != false) {
              _faqList = result;
            } else {
              _faqList = [];
            }
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
