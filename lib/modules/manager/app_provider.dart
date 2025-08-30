import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../core/utils/firebase_firestore.dart';

class AppProvider extends ChangeNotifier {
  var location = Location();
  late GoogleMapController googleMapController;
  LatLng? eventLocation;

  Set<Marker> markers = {};

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
    bool locationServiceEnabled = await _locationServiceEnabled();
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

  Future<bool> _locationServiceEnabled() async {
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
    }
    return locationServiceEnabled;
  }

  void changeLocationOnMap(LocationData locationData) {
    CameraPosition newPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: cameraPosition.zoom,
    );
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
    markers = {...markers.where((m) => m.markerId.value != "user_location")};
    cameraPosition = newPosition;
    notifyListeners();
  }

  void setLocationListener() {
    location.changeSettings(accuracy: LocationAccuracy.high, interval: 3000);
    location.onLocationChanged.listen((locationData) {
      changeLocationOnMap(locationData);
    });
  }

  void setEventLocation(LatLng newEventLoc) {
    eventLocation = newEventLoc;
    notifyListeners();
  }

  void listenToAllEvents({String catId = "All"}) {
    FirebaseFirestoreUtils.readEventData(catId: catId).listen((snapshot) {
      Set<Marker> newMarkers = {};

      for (var doc in snapshot.docs) {
        final event = doc.data();
        if (event.lat != null && event.long != null) {
          newMarkers.add(
            Marker(
              markerId: MarkerId(event.eventID ?? doc.id),
              position: LatLng(event.lat!, event.long!),
              infoWindow: InfoWindow(
                title: event.eventTitle,
              ),
            ),
          );
        }
      }

      // keep user location marker if exists
      final userMarker = markers.firstWhere(
        (m) => m.markerId.value == "user_location",
        orElse: () => const Marker(markerId: MarkerId("dummy")),
      );

      if (userMarker.markerId.value != "dummy") {
        newMarkers.add(userMarker);
      }

      markers = newMarkers;
      notifyListeners();
    });
  }
}
