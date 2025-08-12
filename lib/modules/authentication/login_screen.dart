import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/core/routes/page_routes_name.dart';
import 'package:evently/modules/authentication/widgets/register_button_widget.dart';
import 'package:evently/modules/authentication/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../onboarding/widgets/language_switch.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLanguageEN = true;
  final _formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var dynamicSize = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          bottom: 25,
          top: 50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImagesName.splashLogo, width: dynamicSize.width * 0.4),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: dynamicSize.height * 0.22,
                    margin: EdgeInsets.symmetric(vertical: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFieldWidget(
                          title: 'Email',
                          prefixIcon: Icon(Icons.mail_rounded),
                          controller: mailController,
                        ),
                        TextFieldWidget(
                          title: 'Password',
                          prefixIcon: Icon(Icons.lock_rounded),
                          isPassword: true,
                          controller: passwordController,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(PageRoutesName.forgetPassword);

                            },
                            child: Text(
                              "Forget Password?",
                              style: theme.bodyLarge!.copyWith(
                                color: EventlyColors.blue,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                                // decorationThickness: 1,
                                decorationColor: EventlyColors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: dynamicSize.height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RegisterButtonWidget(
                          bgColor: EventlyColors.blue,
                          child: Text(
                            "Login",
                            style: theme.titleMedium!.copyWith(
                              color: EventlyColors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          buttonAction: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context).pushReplacementNamed(PageRoutesName.layout);
                              }
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t Have Account ?",
                              style: theme.bodyLarge,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(PageRoutesName.register);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                              ),
                              child: Text(
                                "Create Account",
                                style: theme.bodyLarge!.copyWith(
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
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                height: 3,
                                color: EventlyColors.blue,
                                indent: 10,
                                endIndent: 10,
                              ),
                            ),
                            Text(" Or ", style: theme.bodyLarge),
                            Expanded(
                              child: Divider(
                                height: 3,
                                color: EventlyColors.blue,
                                indent: 10,
                                endIndent: 10,
                              ),
                            ),
                          ],
                        ),

                        /// Google Login Button
                        RegisterButtonWidget(
                          bgColor: EventlyColors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(ImagesName.googleIcon, height: 30),
                              SizedBox(width: 10),
                              Text(
                                "Login With Google",
                                style: theme.titleSmall,
                              ),
                            ],
                          ),
                          buttonAction: () {},
                        ),
                      ],
                    ),
                  ),
                ],
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
