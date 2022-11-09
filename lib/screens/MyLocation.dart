import 'dart:async';

import 'package:app/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart';

import '../models/businessLayer/apiHelper.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Marker currentMarker = const Marker(markerId: MarkerId('current'));
  Position myPosition = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  Placemark placemark = Placemark();
  Placemark oldPlaceMark = Placemark();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLocationPermission();
  }

  var googleMapController;
  void setGoogleMap(GoogleMapController googleMapControllerv) {
    googleMapController = googleMapControllerv;
    // notifyListeners();
  }

  bool isenabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Set Location",
          style: TextStyle(color: AppColors.primary),
        ),
      ),
      body: isenabled
          ? GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: {currentMarker},
              initialCameraPosition: CameraPosition(
                target: LatLng(myPosition.latitude, myPosition.longitude),
                zoom: 14.4746,
              ),
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                setGoogleMap(controller);
              },
              onCameraIdle: () {
                print("Called");

                // context.read<SettingController>().getVendorByLocation();
              },
              onCameraMove: (CameraPosition position) {
                myPosition = Position(
                    longitude: position.target.longitude,
                    latitude: position.target.latitude,
                    timestamp: DateTime.now(),
                    accuracy: 21,
                    altitude: 1,
                    heading: 1,
                    speed: 1,
                    speedAccuracy: 1);
                currentMarker = Marker(
                  markerId: const MarkerId('current'),
                  position: LatLng(
                      position.target.latitude, position.target.longitude),
                  flat: true,
                );
                //settingController.notifyListeners();
                setState(() {});
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          bool response = await APIHelper()
              .saveLatLon(myPosition.latitude, myPosition.longitude);
          if (response) {
            //Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Location Saved Successfully")));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Location Not Saved")));
          }
        },
        label: Text('Save Location!'),
        icon: Icon(Icons.location_on_outlined),
      ),
    );
  }

  Future<void> checkLocationPermission() async {
    //
    try {
      PermissionStatus status = await Permission.location.request();
      if (!status.isDenied) {
        await GeolocatorPlatform.instance.requestPermission();

        myPosition = await GeolocatorPlatform.instance.getCurrentPosition();

        print(myPosition.toJson());
        placemark = (await GeocodingPlatform.instance.placemarkFromCoordinates(
                myPosition.latitude, myPosition.longitude))
            .first;
        setState(() {
          isenabled = true;
        });
      }
    } on Exception catch (e) {}
  }
}
