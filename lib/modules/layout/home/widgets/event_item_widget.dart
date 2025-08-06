import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/constants/images/images_name.dart';
import 'package:flutter/material.dart';

class EventItemWidget extends StatefulWidget {
  const EventItemWidget({super.key});

  @override
  State<EventItemWidget> createState() => _EventItemWidgetState();
}

class _EventItemWidgetState extends State<EventItemWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(ImagesName.sportImageDark),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: EventlyColors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "21",
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w900,
                  height: 1
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Nov",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: EventlyColors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: EventlyColors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Meeting for Updating The Development Method ",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        color: EventlyColors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.favorite_border,
                    color: EventlyColors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
