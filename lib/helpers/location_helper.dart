import 'package:app/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:app/consts/app_consts.dart';

mixin LocationHelper {
  final Location _location = Location();

  Future<bool> checkLocationPermission() async {
    PermissionStatus permissionGranted = await _location.hasPermission();
    switch (permissionGranted) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.grantedLimited:
      case PermissionStatus.denied:
      case PermissionStatus.deniedForever:
        var result = await _location.requestPermission();
        return result == PermissionStatus.granted;
    }
  }

  Future<LocationData> getLocation() async => await _location.getLocation();

  Future<void> saveUserLocation() async {
    var authC = Get.find<AuthController>();
    var status = await checkLocationPermission();
    if (status) {
      var location = await getLocation();
      LatLng target = LatLng(
        location.latitude ??
            authC.user_?.lat?.toDouble() ??
            AppConsts.defaultLat,
        location.longitude ??
            authC.user_?.lon?.toDouble() ??
            AppConsts.defaultLon,
      );
    }
  }
}
