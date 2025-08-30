import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/modules/manager/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  late AppProvider appProvider;
  @override
  void initState() {
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    // appProvider.getLocation();

    // live updates from Firestore
    appProvider.listenToAllEvents();

    // get current user location
    appProvider.getLocation();
    // appProvider.setLocationListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appProvider.getLocation();
        },
        backgroundColor: EventlyColors.blue,
        child: Icon(Icons.gps_fixed_rounded, color: EventlyColors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Consumer<AppProvider>(
        builder: (context, provider, child) => Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GoogleMap(
                markers: provider.markers,
                onMapCreated: (mapController) {
                  provider.googleMapController = mapController;
                  // appProvider.setLocationListener();
                },
                initialCameraPosition: provider.cameraPosition,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
