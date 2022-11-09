import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/expertModel.dart';
import 'package:app/models/productModel.dart';
import 'package:app/res/colors.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/screens/addProductScreen.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class ProductListScreen extends BaseRoute {
  final int screenId;
  ProductListScreen({a, o, this.screenId}) : super(a: a, o: o, r: 'ProductListScreen');
  @override
  _ProductListScreenState createState() => new _ProductListScreenState(screenId: screenId);
}

class _ProductListScreenState extends BaseRouteState {
  bool _isDataLoaded = false;
  GlobalKey<ScaffoldState> _scaffoldKey;
  List<Product> _productList = [];
  int screenId;
  Expert experts = new Expert();
  _ProductListScreenState({this.screenId}) : super();

  @override
  Widget build(BuildContext context) {
    return sc(
      WillPopScope(
        onWillPop: () {
          screenId == 1
              ? Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationWidget(
                            a: widget.analytics,
                            o: widget.observer,
                          )),
                )
              : Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                  color: AppColors.background,
                  image: DecorationImage(
                      image: AssetImage("assets/partner_background.png")
                  )
              ),
              // margin: EdgeInsets.only(top: 80),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(height: Dimens.space_large),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_large),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back)),
                          Image.asset('assets/partner_logo.png',
                              scale: 7.0),
                          Icon(Icons.menu)
                        ],
                      ),
                    ),
                    SizedBox(height: Dimens.space_normal),
                    Container(
                        margin: EdgeInsets.only(top: 30, bottom: 10),
                        child: Text(
                          AppLocalizations.of(context).lbl_products,
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                            )
                        )),
                    _isDataLoaded
                        ? _productList.length > 0
                            ? Expanded(
                                child: ListView.builder(
                                    itemCount: _productList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        height: 85,
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: Card(
                                            child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 3, right: 3),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                                child: Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
                                                  height: 85,
                                                  width: 80,
                                                  child: _productList[index].product_image == 'N/A'
                                                      ? Image.asset(
                                                          'assets/sample_image.jpg',
                                                          fit: BoxFit.cover,
                                                        )
                                                      : CachedNetworkImage(
                                                          imageUrl: global.baseUrlForImage + _productList[index].product_image,
                                                          imageBuilder: (context, imageProvider) => Container(
                                                            height: 70,
                                                            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: imageProvider)),
                                                          ),
                                                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                                        ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: global.isRTL ? EdgeInsets.only(right: 10.0, top: 7) : EdgeInsets.only(left: 10.0, top: 7),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        '${_productList[index].product_name}',
                                                        style: Theme.of(context).primaryTextTheme.subtitle2,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 1),
                                                      child: Text(
                                                        '${_productList[index].description}',
                                                        style: Theme.of(context).primaryTextTheme.subtitle1,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 5),
                                                      child: Text(
                                                        '${_productList[index].quantity}',
                                                        style: Theme.of(context).primaryTextTheme.subtitle1,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(right: 5),

                                              height: 40,
                                              width: 100,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 70,
                                                    decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor, width: 1)),
                                                    padding: EdgeInsets.only(top: 2, bottom: 2),
                                                    child: Center(
                                                        child: Text(
                                                      '${global.currency.currency_sign} ${_productList[index].price}',
                                                      style: Theme.of(context).primaryTextTheme.subtitle2,
                                                      overflow: TextOverflow.ellipsis,
                                                    )),
                                                  ),
                                                  Container(

                                                    width: 30,
                                                    child: PopupMenuButton(itemBuilder: (BuildContext context) {
                                                      return [
                                                        PopupMenuItem(
                                                          padding: EdgeInsets.all(0),
                                                          child: new ListTile(
                                                            leading: Icon(
                                                              Icons.edit,
                                                              color: Theme.of(context).primaryColor,
                                                            ),
                                                            title: Text(
                                                              AppLocalizations.of(context).lbl_edit,
                                                              style: Theme.of(context).primaryTextTheme.subtitle2,
                                                            ),
                                                            onTap: () {
                                                              Navigator.of(context).pop();
                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                  builder: (context) => AddProductScreen(
                                                                        a: widget.analytics,
                                                                        o: widget.observer,
                                                                        product: _productList[index],
                                                                      )));
                                                            },
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          padding: EdgeInsets.all(0),
                                                          child: new ListTile(
                                                            leading: Icon(Icons.delete, color: Theme.of(context).primaryColor),
                                                            title: Text(AppLocalizations.of(context).lbl_delete, style: Theme.of(context).primaryTextTheme.subtitle2),
                                                            onTap: () {
                                                              Navigator.of(context).pop();
                                                              _deleteProductConfirmationDialog(_productList[index].id, index);
                                                            },
                                                          ),
                                                        ),
                                                      ];
                                                    }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                      );
                                    }),
                              )
                            : Container(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3), child: Text(AppLocalizations.of(context).txt_products_will_shown_here))
                        : Expanded(child: _shimmer()),
                    _isDataLoaded
                        ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.space_xxxxxxlarge,
                        vertical: Dimens.space_large,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddProductScreen(
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                        },
                        child: Container(
                          height: 40,
                          child: Center(
                            child: Text(
                                AppLocalizations.of(context).btn_add_new_product,
                                style: TextStyle(
                                    color: AppColors.surface
                                )),
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.dotColor,
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    )
                        : _shimmer1(),
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
    _init();
  }

  _deleteProduct(int productId, int index) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.deleteProduct(productId).then((result) {
          if (result.status ==  "1") {
            hideLoader();
            _productList.removeAt(index);

            setState(() {});
          }
          else
          {
            hideLoader();
             showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - productListScreen.dart - _deleteProduct():" + e.toString());
    }
  }

  Future _deleteProductConfirmationDialog(productId, index) async {
    try {
      
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context).lbl_delete_product,
              ),
              content: Text(AppLocalizations.of(context).txt_confirmation_message_for_delete_product),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context).lbl_no),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context).lbl_yes),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _deleteProduct(productId, index);
                  },
                )
              ],
            );
          });
    } catch (e) {
      print("Exception - productListScreen.dart - _deleteProductConfirmationDialog():" + e.toString());
    }
  }

  _getProducts() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getProducts(global.user.id).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _productList = result.recordList;
            } else {
              _productList = [];
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - productListScreen.dart - _getProducts():" + e.toString());
    }
  }

  _init() async {
    await _getProducts();

    _isDataLoaded = true;
    setState(() {});
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 85,
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Card(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              child: Card(
                                margin: EdgeInsets.only(bottom: 5, left: 5, top: 5),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              child: Card(margin: EdgeInsets.only(bottom: 5, left: 5, top: 5)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _shimmer1() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Card(),
          )),
    );
  }
}
