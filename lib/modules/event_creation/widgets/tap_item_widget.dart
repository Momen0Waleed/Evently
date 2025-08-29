import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/modules/layout/home/models/category_data.dart';
import 'package:evently/modules/manager/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TapItemWidget extends StatelessWidget {
  const TapItemWidget({
    super.key,
    required this.categoryData,
    required this.isSelected,
  });
  final CategoryData categoryData;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected
            ?
        EventlyColors.blue
            :
        Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 1.5,
          color:
          EventlyColors.blue
        ),
      ),
      child: Row(
        children: [
          Icon(
              Icons.menu_book_rounded,
              color: isSelected ?
              (provider.isDark() ? EventlyColors.dark : EventlyColors.white)
                  :EventlyColors.blue

          ),
          SizedBox(width: 8),
          Text(
            categoryData.categoryTitle,
            style: theme.textTheme.bodyLarge!.copyWith(
                color: isSelected ?
                (provider.isDark() ? EventlyColors.dark : EventlyColors.white)
                    :EventlyColors.blue
            ),
          ),
        ],
      ),
    );
  }
}
