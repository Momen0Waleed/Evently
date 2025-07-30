import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/modules/authentication/widgets/register_button_widget.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});
  static const String routeName = "/Forget-Password";

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: EventlyColors.black, size: 30),
        ),
        title: Text(
          "Forget Password",
          style: textTheme.bodyLarge!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(ImagesName.forgetPassImage, fit: BoxFit.cover),
            ),
            SizedBox(height: 25),
            RegisterButtonWidget(
              bgColor: EventlyColors.blue,
              child: Text(
                "Reset Password",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: EventlyColors.white),
                textAlign: TextAlign.center,
              ),
              buttonAction: () {},
            ),
          ],
        ),
      ),
    );
  }
}
