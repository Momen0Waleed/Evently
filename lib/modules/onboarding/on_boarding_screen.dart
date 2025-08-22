import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/routes/page_routes_name.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/images/images_name.dart';
import '../../core/constants/services/local_storage_keys.dart';
import '../../core/constants/services/local_storage_services.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

final int _numPages = 3;
final PageController _pageController = PageController(initialPage: 0);
int _currentPage = 0;

List<Widget> _buildPageIndicator(BuildContext context) {
  List<Widget> list = [];
  for (int i = 0; i < _numPages; i++) {
    list.add(
      i == _currentPage
          ? _indicator(true, context)
          : _indicator(false, context),
    );
  }
  return list;
}

Widget _indicator(bool isActive, BuildContext context) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 200),
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    height: 6.0,
    width: isActive ? 24.0 : 10.0,
    decoration: BoxDecoration(
      color: isActive
          ? EventlyColors.blue
          : (Provider.of<SettingsProvider>(context).isDark()
                ? EventlyColors.white
                : EventlyColors.black),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    var dynamicSize = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;

    var local = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: _currentPage != _numPages - 1
          ? FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: () {
                _completeOnboarding();
              },
              child: Text(
                local.skip,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: EventlyColors.blue,
                  fontSize: 20,
                ),
              ),
            )
          : Text(""),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          bottom: 25,
          top: 50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          ImagesName.headerLogo,
                          width: dynamicSize.width * 0.4,
                        ),
                      ),
                      Image.asset(ImagesName.onboarding1),
                      Text(
                        local.find_event,
                        style: theme.titleMedium,
                        softWrap: true,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          local.onBoarding1Description,
                          style: theme.bodyLarge!.copyWith(
                            color: provider.isDark()
                                ? EventlyColors.white
                                : EventlyColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          ImagesName.headerLogo,
                          width: dynamicSize.width * 0.4,
                        ),
                      ),
                      Image.asset(ImagesName.onboarding2),
                      Text(
                        local.effortless,
                        style: theme.titleMedium,
                        softWrap: true,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          local.onBoarding2Description,
                          style: theme.bodyLarge!.copyWith(
                            color: provider.isDark()
                                ? EventlyColors.white
                                : EventlyColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          ImagesName.headerLogo,
                          width: dynamicSize.width * 0.4,
                        ),
                      ),
                      Image.asset(ImagesName.onboarding3),
                      Text(
                        local.connect,
                        style: theme.titleMedium,
                        softWrap: true,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          local.onBoarding3Description,
                          style: theme.bodyLarge!.copyWith(
                            color: provider.isDark()
                                ? EventlyColors.white
                                : EventlyColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _currentPage == 0
                        ? () {
                            Navigator.pop(context);
                          }
                        : () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,

                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1, color: EventlyColors.blue),
                      ),
                      child: Icon(Icons.arrow_back, color: EventlyColors.blue),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(context),
                  ),
                  GestureDetector(
                    onTap: _currentPage == _numPages - 1
                        ? () {
                            _completeOnboarding();
                          }
                        : () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1, color: EventlyColors.blue),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: EventlyColors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _completeOnboarding() async {
    await LocalStorageServices.setBool(
      LocalStorageKeys.onboardingSeenKey,
      true,
    );

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      PageRoutesName.login,
      (route) => false,
    );
  }
}
