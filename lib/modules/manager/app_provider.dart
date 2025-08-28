import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AppProvider extends ChangeNotifier {
  var location = Location();
  late GoogleMapController googleMapController;
  LatLng? eventLocation;

  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(37.42796133580664, -122.085749655962),
    ),
  };

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<void> getLocation() async {
    notifyListeners();
    bool locationPermissionGranted = await _getLocationPermission();
    if (!locationPermissionGranted) {
      notifyListeners();
      return;
    }
    bool locationServiceEnabled = await _loactionServiceEnabled();
    if (!locationServiceEnabled) {
      notifyListeners();
      return;
    }
    EasyLoading.show();
    LocationData locationData = await location.getLocation();
    EasyLoading.dismiss();
    changeLocationOnMap(locationData);
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

  void changeLocationOnMap(LocationData locationData) {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 17,
    );
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
    markers = {
      Marker(
        markerId: MarkerId("2"),
        position: LatLng(
          locationData.latitude ?? 0,
          locationData.longitude ?? 0,
        ),
      ),
    };
    notifyListeners();
  }

  void setLocationListener(){
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 3000,
    );
    location.onLocationChanged.listen((locationData){
      changeLocationOnMap(locationData);
    });
  }

  void setEventLocation(LatLng newEventLoc){
    eventLocation = newEventLoc;
    notifyListeners();
  }

}
