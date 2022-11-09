import 'package:app/models/businessLayer/apiHelper.dart';
import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/res/colors.dart';
import 'package:app/screens/appointmentHistoryScreen.dart';
import 'package:app/screens/homeScreen.dart';
import 'package:app/screens/profileScreen.dart';
import 'package:app/screens/requestScreen.dart';
import 'package:app/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:rolling_nav_bar/rolling_nav_bar.dart';

import '../models/businessLayer/base.dart';
import '../screens/serviceListScreen.dart';

class BottomNavigationWidget extends BaseRoute {

  BottomNavigationWidget({a, o}) : super(a: a, o: o, r: 'BottomNavigationWidget');
  @override
  _BottomNavigationWidgetState createState() => new _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;
  _BottomNavigationWidgetState() : super();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Base.count++;
        if(Base.count==2) {
          Base.count=0;
          return exitAppDialog();
        }else
          return null;
      },
      child: sc(
        Scaffold(
            bottomNavigationBar: Container(
              height: 61,
              width: MediaQuery.of(context).size.width,
              color: AppColors.primary,
              child: RollingNavBar.iconData(
                badges: [null,AppointmentHistoryScreen.totalPending!=null &&
                    AppointmentHistoryScreen.totalPending!="0"
                    ?
                Text(AppointmentHistoryScreen.totalPending):null,null,null],
                iconSize: 25,
                iconText: [
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 10, color: AppColors.surface),
                  ),
                  Text(
                    'Request',
                    style: TextStyle(fontSize: 10, color: AppColors.surface),
                  ),
                  Text(
                    "Appointment",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: AppColors.surface),
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 10, color: AppColors.surface),
                  )
                ],
                navBarDecoration: BoxDecoration(
                  color: AppColors.primary
                ),
                iconData: [Icons.home, Icons.support_agent, Icons.calendar_today, Icons.person],
                activeIconColors: [AppColors.primary],
                iconColors: [AppColors.surface],
                animationCurve: Curves.easeOut,
                baseAnimationSpeed: 300,
                animationType: AnimationType.roll,
                indicatorColors: <Color>[AppColors.surface],
                onTap: _onItemTap,
              ),
            ),
            drawer:
            // _selectedIndex == 0
            //     ?
            DrawerWidget(
                    a: widget.analytics,
                    o: widget.observer,
                  ),
                // : null,
            body: _children().elementAt(_selectedIndex)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;
  _onItemTap(int index) {
    _selectedIndex = index;
    Base.count=0;
    setState(() {});
  }

  List<Widget> _children() => [HomeScreen(a: widget.analytics, o: widget.observer),
  RequestScreen(a: widget.analytics, o: widget.observer),AppointmentHistoryScreen(a: widget.analytics, o: widget.observer), ProfileScreen(a: widget.analytics, o: widget.observer)];

  @override
  void initState(){
    super.initState();
    init();

  }
  init()async{
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getAppointmentHistory(APIHelper.vid, "").then((value) {
          AppointmentHistoryScreen.appointmentHistoryList = value;
          var s = AppointmentHistoryScreen.appointmentHistoryList.where((
              element) => element.statustext == 'Pending').toList();

          AppointmentHistoryScreen.totalPending = s.length.toString();
          print('');
        });
        setState(() {});
      }
      else{
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    }
    catch(e){
      print(e.toString());
    }
  }
}
