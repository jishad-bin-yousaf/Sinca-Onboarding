import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animated_onboarding/model/onboard_page_item.dart';
import 'package:animated_onboarding/components/fading_sliding_widget.dart';
import 'package:animated_onboarding/screens/onboard/welcome_page.dart';
import 'package:animated_onboarding/screens/onboard/onboard_page.dart';
import 'package:animated_onboarding/screens/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../dataPaths.dart';

class Onboard extends StatefulWidget {
  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> with SingleTickerProviderStateMixin {
  List<OnboardPageItem> onboardPageItems = [
    OnboardPageItem(
      lottieAsset: page2_lottieAsset,
      text: page2txt,
      animationDuration: Duration(milliseconds: 1100),
    ),
    OnboardPageItem(
      lottieAsset: page3_lottieAsset,
      text: page3txt,
      animationDuration: const Duration(milliseconds: 1100),
    ),
    OnboardPageItem(
      lottieAsset: page4_lottieAsset,
      text: page4txt,
      animationDuration: Duration(milliseconds: 1100),
    ),
  ];

  late PageController _pageController;

  List<Widget> onboardItems = [];
  late double _activeIndex;
  bool onboardPage = false;
  bool lastpage = true;
  late AnimationController _animationController;

  @override
  void initState() {
    initializePages(); //initialize pages to be shown
    _pageController = PageController();
    _pageController.addListener(() {
      _activeIndex = _pageController.page!;
      print("Active Index: $_activeIndex");
      if (_activeIndex >= 0.5 && onboardPage == false) {
        setState(() {
          onboardPage = true;
        });
      } else if (_activeIndex < 0.5) {
        setState(() {
          onboardPage = false;
        });
      }
    });

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..forward();
    super.initState();
  }

  initializePages() {
    onboardItems.add(WelcomePage()); // welcome page
    onboardPageItems.forEach((onboardPageItem) {
      //adding onboard pages
      onboardItems.add(OnboardPage(
        onboardPageItem: onboardPageItem,
      ));
    });
  }

  var currentpage = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      /////////////////////
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  currentpage = index;

                  if (index == 3) {
                    lastpage = false;
                  } else {
                    lastpage = true;
                  }
                });
              },
              controller: _pageController,
              children: onboardItems,
            ),
          ),
          Positioned(
            bottom: height * 0.15,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: onboardItems.length,
              effect: WormEffect(
                dotWidth: width * 0.03,
                dotHeight: width * 0.03,
                dotColor: onboardPage
                    ? const Color(0x11000000)
                    : const Color(0x566FFFFFF),
                activeDotColor: onboardPage
                    ? Color.fromARGB(255, 208, 49, 49)
                    : Color.fromARGB(255, 72, 2, 2),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: lastpage
                ? GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return Mainscreen();
                      //   },
                      // ));
                      print("Next button clicked");
                      _pageController.jumpToPage(currentpage + 1);
                    },
                    child: FadingSlidingWidget(
                      animationController: _animationController,
                      child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          alignment: Alignment.center,
                          width: width * 0.8,
                          height: height * 0.075,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.1),
                            ),
                            gradient: LinearGradient(
                              colors: onboardPage
                                  ? [
                                      Color.fromARGB(255, 255, 0, 0),
                                      Color.fromARGB(255, 120, 12, 12),
                                    ]
                                  : [
                                      const Color(0xFFFFFFFF),
                                      const Color(0xFFFFFFFF),
                                    ],
                            ),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: onboardPage
                                  ? const Color(0xFFFFFFFF)
                                  : const Color.fromARGB(255, 216, 32, 32),
                              fontSize: width * 0.05,
                              fontFamily: 'ProductSans',
                            ),
                          )),
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('showMainScreen', true);

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Mainscreen(),
                      ));

                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return Mainscreen();
                      //   },
                      // ));
                    },
                    child: FadingSlidingWidget(
                      animationController: _animationController,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        alignment: Alignment.center,
                        width: width * 0.8,
                        height: height * 0.075,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                          ),
                          gradient: LinearGradient(
                            colors: onboardPage
                                ? [
                                    Color.fromARGB(255, 255, 0, 0),
                                    Color.fromARGB(255, 120, 12, 12),
                                  ]
                                : [
                                    const Color(0xFFFFFFFF),
                                    const Color(0xFFFFFFFF),
                                  ],
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: onboardPage
                                ? const Color(0xFFFFFFFF)
                                : const Color.fromARGB(255, 216, 32, 32),
                            fontSize: width * 0.05,
                            fontFamily: 'ProductSans',
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          Positioned(
            top: 70,
            right: 30,
            child: lastpage
                ? GestureDetector(
                    onTap: () {
                      _pageController.jumpToPage(3);

                      //    _pageController.jumpToPage(currentpage + 1);
                    },
                    child: FadingSlidingWidget(
                      animationController: _animationController,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        alignment: Alignment.center,
                        width: width * 0.13,
                        height: height * 0.035,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                          ),
                          gradient: LinearGradient(
                            colors: onboardPage
                                ? [
                                    Color.fromARGB(255, 255, 0, 0),
                                    Color.fromARGB(255, 120, 12, 12),
                                  ]
                                : [
                                    const Color(0xFFFFFFFF),
                                    const Color(0xFFFFFFFF),
                                  ],
                          ),
                        ),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: onboardPage
                                ? const Color(0xFFFFFFFF)
                                : const Color.fromARGB(255, 216, 32, 32),
                            fontSize: width * 0.04,
                            fontFamily: 'ProductSans',
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ),
          Positioned(
            top: height * 0.1,
            left: width * 0.09,
            child: onboardPage
                ? GestureDetector(
                    onTap: () {
                      // _pageController.jumpToPage(3);

                      _pageController.jumpToPage(currentpage - 1);
                    },
                    child: FadingSlidingWidget(
                      animationController: _animationController,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Color.fromARGB(255, 162, 9, 9),
                      ),
                      // child: Text(
                      //   '<',
                      //   style: TextStyle(
                      //     color: const Color.fromARGB(255, 216, 32, 32),
                      //     fontSize: width * 0.04,
                      //     fontFamily: 'ProductSans',
                      //   ),
                      // ),
                    ),
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
