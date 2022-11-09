import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/ReviewsModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewScreen extends BaseRoute {
  ReviewScreen({a, o}) : super(a: a, o: o, r: 'ReviewScreen');
  @override
  _ReviewScreenState createState() => new _ReviewScreenState();
}

class _ReviewScreenState extends BaseRouteState {
  bool isForExpertReview = true;
  List<Review> reviews = [];
  bool shopValue = false;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String onlineStatus;
  bool isloading = true;

  _ReviewScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return sc(
      WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: !isloading
              ? SingleChildScrollView(
                  child: Container(
                    color: AppColors.background,
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
                              Icon(Icons.menu)
                            ],
                          ),
                        ),
                        SizedBox(height: Dimens.space_xxxxlarge),
                        // Container(
                        //   height: 100,
                        //   width: MediaQuery.of(context).size.width,
                        //   child: Stack(
                        //     children: [
                        //       Container(
                        //         width: MediaQuery.of(context).size.width,
                        //         child: ColorFiltered(
                        //           colorFilter: ColorFilter.mode(
                        //             Theme.of(context).primaryColor,
                        //             BlendMode.screen,
                        //           ),
                        //           child: Image.asset(
                        //             'assets/banner.jpg',
                        //             fit: BoxFit.cover,
                        //           ),
                        //         ),
                        //       ),
                        //       GestureDetector(
                        //         onTap: () {
                        //           Navigator.of(context).pop();
                        //         },
                        //         child: Padding(
                        //           padding: Platform.isAndroid ? EdgeInsets.only(bottom: 15, left: 10, top: 10) : EdgeInsets.only(bottom: 15, left: 10, top: 20),
                        //           child: Row(
                        //             children: [
                        //               Icon(
                        //                 Icons.keyboard_arrow_left_outlined,
                        //                 color: Colors.black,
                        //               ),
                        //               Text(
                        //                 AppLocalizations.of(context).lbl_back,
                        //                 style: TextStyle(color: Colors.black, fontSize: 17.5),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Container(
                            decoration: BoxDecoration(
                              color: AppColors.background,
                            ),
                            // margin: EdgeInsets.only(top: 80),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 30, bottom: 10),
                                  child: Text(
                                      AppLocalizations.of(context).lbl_reviews,
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimens.space_xlarge)),
                                ),
                                ListView.builder(
                                    itemCount: reviews.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return reviews[index] != null
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 3,
                                                  top: 3),
                                              child: Container(
                                                  padding: EdgeInsets.all(
                                                      Dimens.space_large),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.surface,
                                                      borderRadius: BorderRadius
                                                          .circular(Dimens
                                                              .space_normal)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            reviews[index].userImage !=
                                                                        '' &&
                                                                    reviews[index]
                                                                            .userImage !=
                                                                        null
                                                                ? CachedNetworkImage(
                                                                    imageUrl: global
                                                                            .baseUrlForImage +
                                                                        "users/" +
                                                                        reviews[index]
                                                                            .userImage,
                                                                    imageBuilder: (context, imageProvider) => CircleAvatar(
                                                                        radius:
                                                                            25,
                                                                        backgroundImage:
                                                                            imageProvider),
                                                                    placeholder: (context,
                                                                            url) =>
                                                                        Center(
                                                                            child:
                                                                                CircularProgressIndicator()),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        CircleAvatar(
                                                                      radius:
                                                                          25,
                                                                      child: Icon(
                                                                          Icons
                                                                              .person),
                                                                    ),
                                                                  )
                                                                : CircleAvatar(
                                                                    radius: 26,
                                                                    backgroundColor:
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          25,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      child: Icon(
                                                                          Icons
                                                                              .person),
                                                                    ),
                                                                  ),
                                                            Padding(
                                                              padding: global
                                                                      .isRTL
                                                                  ? EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              15)
                                                                  : EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              15),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      '${reviews[index].username}'),
                                                                  Row(
                                                                    children: [
                                                                      RatingBar
                                                                          .builder(
                                                                        initialRating:
                                                                            reviews[0].ratingCount,
                                                                        minRating:
                                                                            0,
                                                                        direction:
                                                                            Axis.horizontal,
                                                                        allowHalfRating:
                                                                            true,
                                                                        itemCount:
                                                                            5,
                                                                        itemSize:
                                                                            12,
                                                                        itemPadding:
                                                                            EdgeInsets.symmetric(horizontal: 0),
                                                                        itemBuilder:
                                                                            (context, _) =>
                                                                                Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.amber,
                                                                        ),
                                                                        ignoreGestures:
                                                                            true,
                                                                        updateOnDrag:
                                                                            false,
                                                                        onRatingUpdate:
                                                                            (rating) {},
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 3),
                                                                        child:
                                                                            Text(
                                                                          '${reviews[index].ratingCount}',
                                                                          style: Theme.of(context)
                                                                              .primaryTextTheme
                                                                              .subtitle1,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  reviews[index]
                                                                              .comment !=
                                                                          null
                                                                      ? isForExpertReview
                                                                          ? Text(
                                                                              '${reviews[index].comment}',
                                                                              style: Theme.of(context).primaryTextTheme.subtitle1,
                                                                            )
                                                                          : Text(
                                                                              '${reviews[index].comment}',
                                                                              style: Theme.of(context).primaryTextTheme.subtitle1,
                                                                            )
                                                                      : SizedBox()
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: global.isRTL
                                                              ? EdgeInsets.only(
                                                                  right: 15)
                                                              : EdgeInsets.only(
                                                                  left: 15),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  reviews[index]
                                                                              .createdTime !=
                                                                          null
                                                                      ? reviews[index]
                                                                              .createdTime
                                                                              .split('T')[
                                                                          0]
                                                                      : '',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .primaryTextTheme
                                                                      .subtitle1),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            )
                                          : SizedBox();
                                    }),
                              ],
                            )),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
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
    try {
      getReviews();
      if (global.user.online_status != null) {
        if (global.user.online_status == "ON") {
          shopValue = true;
        } else {
          shopValue = false;
        }
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      isloading = false;
    });
    super.initState();
  }

  getReviews() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.getReviews(reviews).then((value) {
          reviews = value;

          hideLoader();
          setState(() {});
        });
      } else
        showNetworkErrorSnackBar(_scaffoldKey);
    } catch (e) {
      print(
          "Exception - serviceListScreen.dart - saveService():" + e.toString());
    }
  }
}
