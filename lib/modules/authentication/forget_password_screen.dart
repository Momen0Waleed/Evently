import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/authentication/widgets/register_button_widget.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: EventlyColors.blue, size: 30),
        ),
        title: Text(
          local.forget_password,
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
                local.reset_password,
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
