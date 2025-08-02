import 'package:evently/modules/authentication/widgets/register_button_widget.dart';
import 'package:evently/modules/authentication/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors/evently_colors.dart';
import '../../core/constants/images/images_name.dart';
import '../home/home_screen.dart';
import '../onboarding/widgets/language_switch.dart';
import 'login_screen.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});
  static const String routeName = "/Create-Account";

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool isLanguageEN = true;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var dynamicSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: EventlyColors.black, size: 30),
        ),
        title: Text(
          "Register",
          style: textTheme.bodyLarge!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImagesName.splashLogo, width: dynamicSize.width * 0.4),
            Container(
              height: dynamicSize.height * 0.5,
              margin: EdgeInsets.only(top: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFieldWidget(
                      title: 'Name',
                      prefixIcon: Icon(
                        Icons.person_rounded,
                        color: EventlyColors.gray,

                      ),
                      isPassword: false,
                      isName: true,
                      isLogin: false,
                      controller:nameController,
                    ),
                    TextFieldWidget(
                      title: 'Email',
                      prefixIcon: Icon(
                        Icons.mail_rounded,
                        color: EventlyColors.gray,
                      ),
                      isPassword: false,
                      isName: false,
                      isLogin: false,
                      controller:mailController,
                    ),
                    TextFieldWidget(
                      title: 'Password',
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: EventlyColors.gray,
                      ),
                      isPassword: true,
                      isName: false,
                      isLogin: false,
                      controller: passwordController,
                    ),
                    TextFieldWidget(
                      title: 'Re-Password',
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: EventlyColors.gray,
                      ),
                      isPassword: true,
                      isName: false,
                      isLogin: false,
                      isConfirmPassword: true,
                      controller: confirmPasswordController,
                      originalPasswordController: passwordController,
                    ),
                    RegisterButtonWidget(
                      bgColor: EventlyColors.blue,
                      child: Text(
                        "Create Account",
                        style: textTheme.titleMedium!.copyWith(
                          color: EventlyColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      buttonAction: () {
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed(HomeScreen.routeName);
                          }
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have Account ?",
                          style: textTheme.bodyLarge,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushNamed(LoginScreen.routeName);
                          },
                          child: Text(
                            "Login",
                            style: textTheme.bodyLarge!.copyWith(
                              color: EventlyColors.blue,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                              decorationColor: EventlyColors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: LanguageSwitch(
                onLanguageChanged: (bool value) {
                  setState(() {
                    isLanguageEN = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
