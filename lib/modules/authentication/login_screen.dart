import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/core/constants/services/local_storage_keys.dart';
import 'package:evently/core/constants/services/local_storage_services.dart';
import 'package:evently/core/constants/services/snackbar_service.dart';
import 'package:evently/core/routes/page_routes_name.dart';
import 'package:evently/core/utils/firebase_authentication_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/authentication/widgets/register_button_widget.dart';
import 'package:evently/modules/authentication/widgets/text_field_widget.dart';
import 'package:evently/modules/manager/settings_provider.dart' show SettingsProvider;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart' show Provider;

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
    var local = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          // bottom: 25,
          top: 50,
        ),
        child: SingleChildScrollView(
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
                      // height: dynamicSize.height * 0.225,
                      margin: EdgeInsets.symmetric(vertical: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFieldWidget(
                            color: provider.isDark()
                                ? Colors.transparent
                                : EventlyColors.white,
                            textColor: provider.isDark()
                                ? EventlyColors.white
                                : EventlyColors.gray,
                            borderColor: provider.isDark()
                                ? EventlyColors.blue
                                : EventlyColors.gray,
          
                            title: local.email,
                            prefixIcon: Icon(
                              Icons.mail_rounded,
                              color: provider.isDark()
                                  ? EventlyColors.white
                                  : EventlyColors.gray,
                            ),
                            controller: mailController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "${AppLocalizations.of(context)!.email} ${AppLocalizations.of(context)!.email_is_required}";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10,),
                          TextFieldWidget(
                            color: provider.isDark()
                                ? Colors.transparent
                                : EventlyColors.white,
                            textColor: provider.isDark()
                                ? EventlyColors.white
                                : EventlyColors.gray,
                            borderColor: provider.isDark()
                                ? EventlyColors.blue
                                : EventlyColors.gray,
          
                            title: local.password,
                            prefixIcon: Icon(
                              Icons.lock_rounded,
                              color: provider.isDark()
                                  ? EventlyColors.white
                                  : EventlyColors.gray,
                            ),
                            isPassword: true,
                            controller: passwordController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "${AppLocalizations.of(context)!.password} ${AppLocalizations.of(context)!.pass_is_required}";
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(PageRoutesName.forgetPassword);
                              },
                              child: Text(
                                local.forget_password,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RegisterButtonWidget(
                            bgColor: EventlyColors.blue,
                            child: Text(
                              local.login,
                              style: theme.titleMedium!.copyWith(
                                color: EventlyColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            // buttonAction: () {
                            //   setState(() {
                            //     if (_formKey.currentState!.validate()) {
                            //       EasyLoading.show();
                            //       FirebaseAuthenticationUtils.signInWithEmailAndPassword(
                            //         emailAddress: mailController.text,
                            //         password: passwordController.text,
                            //       ).then(((value) async{
                            //         EasyLoading.dismiss();
                            //
                            //         final uid = FirebaseAuth.instance.currentUser!.uid;
                            //         final userDoc = await FirebaseFirestore.instance.collection("users").doc(uid).get();
                            //
                            //         if (!userDoc.exists) {
                            //           await FirebaseFirestore.instance.collection("users").doc(uid).set({
                            //             "email": FirebaseAuth.instance.currentUser!.email,
                            //             "createdAt": FieldValue.serverTimestamp(),
                            //           });
                            //         }
                            //
                            //         Navigator.of(
                            //           context,
                            //         ).pushReplacementNamed(PageRoutesName.layout);
                            //       }));
                            //     }
                            //   });
                            // },
                              buttonAction: () {
                                if (_formKey.currentState!.validate()) {
                                  EasyLoading.show();

                                  FirebaseAuthenticationUtils.signInWithEmailAndPassword(
                                    emailAddress: mailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ).then((success) async {
                                    EasyLoading.dismiss();

                                    if (!success) return; // 🔑 Do not continue if login failed

                                    final uid = FirebaseAuth.instance.currentUser!.uid;
                                    final userDoc = await FirebaseFirestore.instance.collection("users").doc(uid).get();

                                    if (!userDoc.exists) {
                                      await FirebaseFirestore.instance.collection("users").doc(uid).set({
                                        "email": FirebaseAuth.instance.currentUser!.email,
                                        "createdAt": FieldValue.serverTimestamp(),
                                      });
                                    }

                                    Navigator.of(context).pushReplacementNamed(PageRoutesName.layout);
                                  });
                                }
                              }


                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                local.dont_have_acc,
                                style: theme.bodyLarge!.copyWith(
                                  color: provider.isDark()
                                      ? EventlyColors.white
                                      : EventlyColors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pushNamed(PageRoutesName.register);
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                ),
                                child: Text(
                                  local.create_acc,
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
                              Text(" ${local.or} ", style: theme.bodyLarge!.copyWith(
                                color: provider.isDark() ? EventlyColors.white : EventlyColors.black
                              )),
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
                            bgColor: provider.isDark()
                                ? Colors.transparent
                                : EventlyColors.white,
          
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(ImagesName.googleIcon, height: 30),
                                SizedBox(width: 10),
                                Text(
                                  local.login_with_google,
                                  style: theme.titleSmall,
                                ),
                              ],
                            ),
                            buttonAction: () async {
                              final success = await FirebaseAuthenticationUtils.signInWithGoogle();
                              if (success) {
                                final uid = FirebaseAuth.instance.currentUser!.uid;
                                final userDoc = await FirebaseFirestore.instance.collection("users").doc(uid).get();

                                if (!userDoc.exists) {
                                  await FirebaseFirestore.instance.collection("users").doc(uid).set({
                                    "email": FirebaseAuth.instance.currentUser!.email,
                                    "createdAt": FieldValue.serverTimestamp(),
                                  });
                                }

                                Navigator.of(context).pushReplacementNamed(PageRoutesName.layout);
                              }
                              },
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
                  onLanguageChanged: (bool value) async {
                    setState(() {
                      isLanguageEN = value;
                    });
                    provider.changeLanguage(isLanguageEN ? "en" : "ar");
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _formKey.currentState?.validate();
                    });
                    await LocalStorageServices.setString(
                      LocalStorageKeys.languageKey,
                      value ? "en" : "ar",
                    );
                    },
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
