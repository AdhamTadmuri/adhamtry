import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class LocationService {
  Location location = new Location();

  Future<LocationData?> getCurrentLocation({bool? hideLoader = true}) async {
    LocationData _locationData;

    if (!await isLocationEnabled()) return null;

    if (!await isPermissionGranted()) return null;

    customLoader();

    _locationData = await location.getLocation();

    if (hideLoader!) BotToast.closeAllLoading();

    return _locationData;
  }

  Future<geo.Placemark?> getLocationInfo(LocationData locationData,
      {bool? showLoader = true}) async {
    if (showLoader!) customLoader();

    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
    BotToast.closeAllLoading();

    if (placemarks.isNotEmpty)
      return placemarks[0];
    else
      return null;
  }

  Future<geo.Placemark?> getCurrentLocationInfo() async {
    return await getLocationInfo(
        await getCurrentLocation() ?? LocationData.fromMap({}));
  }

  Future<bool> isLocationEnabled() async {
    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Get.defaultDialog(
            title: "your location is required ",
            content: Column(
              children: [
                InkWell(
                  child: Text("ok"),
                  onTap: () async {
                    _serviceEnabled = await location.requestService();
                    Get.back();
                  },
                ),
                // InkWell(
                //   child: Text("no"),
                //   onTap: () {
                //     SystemNavigator.pop();
                //   },
                // )
                TextButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: Text("no"))
              ],
            ));
      }
    }
    return _serviceEnabled;
  }

  Future<bool> isPermissionGranted() async {
    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return _permissionGranted == PermissionStatus.granted;
  }
}
