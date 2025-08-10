import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:flutter/material.dart';

class RegisterButtonWidget extends StatelessWidget {
  const RegisterButtonWidget({
    super.key,
    required this.bgColor,
    required this.child,
    this.buttonAction,
  });
  final Widget child;
  final Color bgColor;
  final Function()? buttonAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Container(
        width: double.infinity,
        height: 60,
        // padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: EventlyColors.blue),
        ),
        child: Align(alignment: Alignment.center, child: child),
      ),
    );
  }
}
