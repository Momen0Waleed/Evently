import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/routes/page_routes_name.dart';
import 'package:flutter/material.dart';

import '../../core/constants/images/images_name.dart';
import '../../core/constants/services/local_storage_keys.dart';
import '../../core/constants/services/local_storage_services.dart';
import '../../core/constants/strings/main_strings.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

final int _numPages = 3;
final PageController _pageController = PageController(initialPage: 0);
int _currentPage = 0;

List<Widget> _buildPageIndicator() {
  List<Widget> list = [];
  for (int i = 0; i < _numPages; i++) {
    list.add(i == _currentPage ? _indicator(true) : _indicator(false));
  }
  return list;
}

Widget _indicator(bool isActive) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 200),
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    height: 6.0,
    width: isActive ? 24.0 : 10.0,
    decoration: BoxDecoration(
      color: isActive ? EventlyColors.blue : EventlyColors.black,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    var dynamicSize = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;

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
                "Skip",
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagesName.headerLogo,
                        width: dynamicSize.width * 0.4,
                      ),
                      Image.asset(ImagesName.onboarding1),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Find Events That Inspire You",
                          style: theme.titleMedium,
                          softWrap: true,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          MainStrings.onBoarding1Description,
                          style: theme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagesName.headerLogo,
                        width: dynamicSize.width * 0.4,
                      ),
                      Image.asset(ImagesName.onboarding2),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Effortless Event Planning",
                          style: theme.titleMedium,
                          softWrap: true,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          MainStrings.onBoarding2Description,
                          style: theme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagesName.headerLogo,
                        width: dynamicSize.width * 0.4,
                      ),
                      Image.asset(ImagesName.onboarding3),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Connect with Friends & Share Moments",
                          style: theme.titleMedium,
                          softWrap: true,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          MainStrings.onBoarding3Description,
                          style: theme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
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
                        color: EventlyColors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1, color: EventlyColors.blue),
                      ),
                      child: Icon(Icons.arrow_back, color: EventlyColors.blue),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
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
                        color: EventlyColors.white,
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

    Navigator.pushNamedAndRemoveUntil(context, PageRoutesName.login,(route) => false);
  }
}
