import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:location/location.dart';

class AppProvider extends ChangeNotifier {
  var location = Location();
  String locationMessage = "";

  Future<void> getLocation() async {
    locationMessage = "Checking Location Services.....";
    notifyListeners();
    bool locationPermissionGranted = await _getLocationPermission();
    if (!locationPermissionGranted) {
      locationMessage = "Location Permission Denied";
      notifyListeners();
      return;
    }
    bool locationServiceEnabled = await _loactionServiceEnabled();
    if (!locationServiceEnabled) {
      locationMessage = "Location Service Disabled";
      notifyListeners();
      return;
    }
    EasyLoading.show();
    LocationData locationData = await location.getLocation();
    locationMessage = "You are at ${locationData.latitude}, ${locationData.longitude}";
    EasyLoading.dismiss();
    notifyListeners();

  }

  Future<bool> _getLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _loactionServiceEnabled() async {
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
    }
    return locationServiceEnabled;
  }
}
