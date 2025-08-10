import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/modules/layout/home/models/category_data.dart';
import 'package:flutter/material.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: isSelected ? EventlyColors.blue : EventlyColors.white,
        border: Border.all(
          width: 1.5,
          color: isSelected ? EventlyColors.white : EventlyColors.blue,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.menu_book_rounded,
            color: isSelected ? EventlyColors.white : EventlyColors.blue,
          ),
          SizedBox(width: 8),
          Text(
            categoryData.categoryTitle,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: isSelected ? EventlyColors.white : EventlyColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
