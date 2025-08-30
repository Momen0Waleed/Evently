import 'package:evently/core/routes/page_routes_name.dart';
import 'package:evently/core/utils/firebase_authentication_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/authentication/widgets/register_button_widget.dart';
import 'package:evently/modules/authentication/widgets/text_field_widget.dart';
import 'package:evently/modules/manager/settings_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors/evently_colors.dart';
import '../../core/constants/images/images_name.dart';
import '../onboarding/widgets/language_switch.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

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

    var local = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: provider.isDark()
            ? EventlyColors.dark
            : EventlyColors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: EventlyColors.blue, size: 30),
        ),
        title: Text(local.register),
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
                      color: provider.isDark()
                          ? Colors.transparent
                          : EventlyColors.white,
                      title: local.name,
                      textColor: provider.isDark()
                          ? EventlyColors.white
                          : EventlyColors.gray,
                      borderColor: provider.isDark()
                          ? EventlyColors.blue
                          : EventlyColors.gray,
                      prefixIcon: Icon(
                        Icons.person_rounded,
                        color: provider.isDark()
                            ? EventlyColors.white
                            : EventlyColors.gray,
                      ),
                      validator: validateName,
                      controller: nameController,
                    ),
                    TextFieldWidget(
                      color: provider.isDark()
                          ? Colors.transparent
                          : EventlyColors.white,
                      title: local.email,
                      textColor: provider.isDark()
                          ? EventlyColors.white
                          : EventlyColors.gray,
                      borderColor: provider.isDark()
                          ? EventlyColors.blue
                          : EventlyColors.gray,
                      prefixIcon: Icon(
                        Icons.mail_rounded,
                        color: provider.isDark()
                            ? EventlyColors.white
                            : EventlyColors.gray,
                      ),
                      validator: validateEmail,
                      controller: mailController,
                    ),
                    TextFieldWidget(
                      color: provider.isDark()
                          ? Colors.transparent
                          : EventlyColors.white,
                      title: local.password,
                      textColor: provider.isDark()
                          ? EventlyColors.white
                          : EventlyColors.gray,
                      borderColor: provider.isDark()
                          ? EventlyColors.blue
                          : EventlyColors.gray,
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: provider.isDark()
                            ? EventlyColors.white
                            : EventlyColors.gray,
                      ),
                      isPassword: true,
                      validator: validatePassword,
                      controller: passwordController,
                    ),
                    TextFieldWidget(
                      color: provider.isDark()
                          ? Colors.transparent
                          : EventlyColors.white,
                      title: local.re_password,
                      textColor: provider.isDark()
                          ? EventlyColors.white
                          : EventlyColors.gray,
                      borderColor: provider.isDark()
                          ? EventlyColors.blue
                          : EventlyColors.gray,
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: provider.isDark()
                            ? EventlyColors.white
                            : EventlyColors.gray,
                      ),
                      isPassword: true,
                      validator: validateConfirmPassword,
                      controller: confirmPasswordController,
                    ),
                    RegisterButtonWidget(
                      bgColor: EventlyColors.blue,
                      child: Text(
                        local.create_acc,
                        style: textTheme.titleMedium!.copyWith(
                          color: EventlyColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      buttonAction: () {
                        setState(() async {
                          if (_formKey.currentState!.validate()) {
                            // Navigator.of(
                            //   context,
                            // ).pushReplacementNamed(PageRoutesName.layout);
                            EasyLoading.show();
                            FirebaseAuthenticationUtils.createUserWithEmailAndPassword(
                              emailAddress: mailController.text,
                              password: passwordController.text,
                            ).then((value) async {
                            await FirebaseAuth.instance.currentUser!.updateDisplayName(nameController.text);
                            await FirebaseAuth.instance.currentUser!.reload();
                              if (value) {
                            EasyLoading.dismiss();
                                Navigator.pop(context);
                              }
                            });

                          }
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          local.already_have_acc,
                          style: textTheme.bodyLarge!.copyWith(
                            color: provider.isDark()
                                ? EventlyColors.white
                                : EventlyColors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushNamed(PageRoutesName.login);
                          },
                          child: Text(
                            local.login,
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
                  provider.changeLanguage(isLanguageEN ? "en" : "ar");
                  // _formKey.currentState?.validate();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _formKey.currentState?.validate();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.name_req;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "${AppLocalizations.of(context)!.email} ${AppLocalizations.of(context)!.email_is_required}";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.enter_valid_email;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "${AppLocalizations.of(context)!.password} ${AppLocalizations.of(context)!.pass_is_required}";
    }
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
    );
    if (!passwordRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.password_instructions;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pls_confirm_ur_password;
    }
    if (value != passwordController.text) {
      return AppLocalizations.of(context)!.password_not_match;
    }
    return null;
  }
}
