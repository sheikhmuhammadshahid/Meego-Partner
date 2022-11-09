import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/screens/chooseSignUpSignInScreen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends BaseRoute {
  IntroScreen({a, o}) : super(a: a, o: o, r: 'IntroScreen');
  @override
  _IntroScreenState createState() => new _IntroScreenState();
}

class _IntroScreenState extends BaseRouteState {
  _IntroScreenState() : super();
  PageController _pageController;
  int _currentIndex = 0;
  List<String> _imageUrl = [
    'assets/intro_1.png',
    'assets/intro_2.png',
    'assets/intro_3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exitAppDialog();
      },
      child:
      SafeArea(
        top: true,
        bottom: false,
        right: false,
        left: false,
        child: Scaffold(
            body: PageView.builder(
                itemCount: _imageUrl.length,
                controller: _pageController,
                onPageChanged: (index) {
                  _currentIndex = index;
                  setState(() {});
                },
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Image.asset(
                        _imageUrl[index],
                        width: MediaQuery.of(context).size.width,
                        height: double.infinity,
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.high,
                      ),
                      Positioned(
                        bottom: 20.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 1),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.zero),
                          height: 52,
                          width: MediaQuery.of(context).size.width,
                          child: index == 2
                              ? ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ChooseSignUpSignInScreen(
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )),
                              );
                            },
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:
                                MaterialStateProperty.all(
                                    Color(0xFFAF41A5))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Get Started',
                              ),
                            ),
                          )
                              : DotsIndicator(
                            dotsCount: _imageUrl.length,
                            position: _currentIndex.toDouble(),
                            decorator: DotsDecorator(
                              size: const Size.square(9.0),
                              activeSize: const Size(18.0, 9.0),
                              activeColor: Color(0xFFAF41A5),
                              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                })),
      ),
      // Scaffold(
      //     body: Stack(children: [
      //   IntroductionScreen(
      //     dotsDecorator: DotsDecorator(
      //       activeSize: const Size(28, 12),
      //       size: const Size(17, 12),
      //       activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      //       activeColor: Theme.of(context).primaryColor,
      //       color: Theme.of(context).primaryColorLight,
      //     ),
      //     showDoneButton: false,
      //     showNextButton: false,
      //     showSkipButton: false,
      //     pages: [
      //       PageViewModel(
      //         // decoration: PageDecoration(
      //         //   descriptionPadding: EdgeInsets.only(left: 28, right: 28),
      //         //   titleTextStyle: Theme.of(context).primaryTextTheme.headline3,
      //         //   titlePadding: EdgeInsets.only(top: 60, bottom: 10, right: 35, left: 35),
      //         //   contentMargin: EdgeInsets.only(bottom: 35),
      //         //   bodyTextStyle: Theme.of(context).primaryTextTheme.subtitle2,
      //         // ),
      //         image: Container(
      //           // padding: EdgeInsets.only(top: 10),
      //           child: Image.asset(
      //             'assets/intro_1.png',
      //             height: MediaQuery.of(context).size.height,
      //             width: MediaQuery.of(context).size.width,
      //             fit: BoxFit.fill,
      //             filterQuality: FilterQuality.high,
      //           ),
      //         ),
      //         title: '',
      //         body: '',
      //       ),
      //       PageViewModel(
      //         // decoration: PageDecoration(
      //         //   descriptionPadding: EdgeInsets.only(left: 28, right: 28),
      //         //   titleTextStyle: Theme.of(context).primaryTextTheme.headline3,
      //         //   titlePadding: EdgeInsets.only(top: 60, bottom: 10, right: 35, left: 35),
      //         //   contentMargin: EdgeInsets.only(bottom: 35),
      //         //   bodyTextStyle: Theme.of(context).primaryTextTheme.subtitle2,
      //         // ),
      //         image: Container(
      //           padding: EdgeInsets.only(top: 40),
      //           child: Image.asset(
      //             'assets/intro_2.png',
      //             height: MediaQuery.of(context).size.height,
      //             width: MediaQuery.of(context).size.width,
      //             fit: BoxFit.fill,
      //             filterQuality: FilterQuality.high,
      //           ),
      //         ),
      //         title: '',
      //         body: '',
      //         // title: AppLocalizations.of(context).txt_branding_for_your_parlour,
      //         // body: AppLocalizations.of(context).txt_branding_for_your_parlour_detail_text,
      //       ),
      //       PageViewModel(
      //         image: Container(
      //           // padding: EdgeInsets.only(top: 40),
      //           child: Image.asset(
      //             'assets/intro_3.png',
      //             height: MediaQuery.of(context).size.height,
      //             width: MediaQuery.of(context).size.width,
      //             fit: BoxFit.fill,
      //             filterQuality: FilterQuality.high,
      //           ),
      //         ),
      //         title: '',
      //         body: '',
      //         // title: AppLocalizations.of(context).txt_get_customer_feedback,
      //         // body: AppLocalizations.of(context).txt_get_customer_feedback_detail_text,
      //         // decoration: PageDecoration(
      //         //   descriptionPadding: EdgeInsets.only(left: 28, right: 28),
      //         //   titleTextStyle: Theme.of(context).primaryTextTheme.headline3,
      //         //   titlePadding: EdgeInsets.only(top: 60, bottom: 10, right: 35, left: 35),
      //         //   contentMargin: EdgeInsets.only(bottom: 35),
      //         //   bodyTextStyle: Theme.of(context).primaryTextTheme.subtitle2,
      //         //   footerPadding: EdgeInsets.only(top: 20),
      //         // ),
      //         footer: TextButton(
      //           onPressed: () {
      //             Navigator.of(context).push(
      //               MaterialPageRoute(
      //                   builder: (context) => ChooseSignUpSignInScreen(
      //                         a: widget.analytics,
      //                         o: widget.observer,
      //                       )),
      //             );
      //           },
      //           child: Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Text(
      //               AppLocalizations.of(context).btn_get_started,
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ])),
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
