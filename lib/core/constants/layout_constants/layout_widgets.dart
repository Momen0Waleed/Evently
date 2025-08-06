import 'package:evently/modules/layout/favourites/favourite_view.dart';
import 'package:evently/modules/layout/home/home_view.dart';
import 'package:evently/modules/layout/maps/maps_view.dart';
import 'package:evently/modules/layout/profile/profile_view.dart';
import 'package:flutter/cupertino.dart';

abstract class LayoutWidgets{
  static List<Widget> screens = [
    HomeView(),
    MapsView(),
    Container(), // useless
    FavouriteView(),
    ProfileView(),
  ];
}