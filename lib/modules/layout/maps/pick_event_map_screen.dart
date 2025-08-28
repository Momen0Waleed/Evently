import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../manager/app_provider.dart';

class PickEventMapScreen extends StatefulWidget {
  const PickEventMapScreen({super.key});

  @override
  State<PickEventMapScreen> createState() => _PickEventMapScreenState();
}

class _PickEventMapScreenState extends State<PickEventMapScreen> {
  late AppProvider appProvider;
  @override
  void initState() {
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getLocation();
    // appProvider.setLocationListener();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    return Consumer<AppProvider>(
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
              onTap: (location){
                provider.setEventLocation(location);
                Navigator.of(context).pop();
              },
              initialCameraPosition: provider.cameraPosition,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(color: EventlyColors.blue),
              child: Center(
                child: Text(
                  local.select_loc,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: EventlyColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
