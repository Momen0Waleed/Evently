import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/core/constants/layout_constants/layout_widgets.dart';
import 'package:evently/core/routes/page_routes_name.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/manager/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      floatingActionButton: Bounceable(
        onTap: () {
          Navigator.pushNamed(context, PageRoutesName.eventCreation);
        },
        child: CircleAvatar(
          radius: 35,
          backgroundColor: EventlyColors.white,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Provider.of<SettingsProvider>(context).isDark() ?EventlyColors.dark: EventlyColors.blue,
            child: Icon(Icons.add,color: EventlyColors.white,size: 40,),
          ),

        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          showUnselectedLabels: true,
          onTap: (index) {
            if(index != 2) {
              setState(() {
                selectedIndex = index;
              });
            }
            },
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(ImagesName.outlinedHouseIcon)),
              activeIcon: ImageIcon(AssetImage(ImagesName.filledHouseIcon)),
              label: local?.home,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(ImagesName.outlinedMapIcon)),
              activeIcon: ImageIcon(AssetImage(ImagesName.filledMapIcon)),
              label: local?.maps,
            ),
            BottomNavigationBarItem(
              icon:  ImageIcon(AssetImage(ImagesName.nothingIcon)),
              label: " ",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(ImagesName.outlinedLoveIcon)),
              activeIcon: ImageIcon(AssetImage(ImagesName.filledLoveIcon)),
              label: local?.favourite,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(ImagesName.outlinedProfileIcon)),
              activeIcon: ImageIcon(AssetImage(ImagesName.filledProfileIcon)),
              label: local?.profile,
            ),

            ]
      ),
      body: LayoutWidgets.screens[selectedIndex],

    );
  }
  int selectedIndex = 0;
}
