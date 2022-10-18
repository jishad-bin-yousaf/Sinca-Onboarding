import 'package:animated_onboarding/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_onboarding/components/fading_sliding_widget.dart';
import 'package:animated_onboarding/dataPaths.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Positioned.fill(
          // child: Image.asset(
          //   welcomepageLogoIMG,
          //   fit: BoxFit.fill,
          // ),
          child: Container(color: Color.fromARGB(255, 143, 11, 11)),
        ),
        Positioned(
          top: height * 0.2,
          child: Column(
            children: <Widget>[
              ScaleTransition(
                scale: _animationController.drive(
                  Tween<double>(begin: 0.3, end: 1.0).chain(
                    CurveTween(
                      curve: Interval(0.0, 0.2, curve: Curves.elasticInOut),
                    ),
                  ),
                ),
                child: FadeTransition(
                  opacity: _animationController.drive(
                    Tween<double>(begin: 0.0, end: 1.0).chain(
                      CurveTween(
                        curve: Interval(0.2, 0.4, curve: Curves.decelerate),
                      ),
                    ),
                  ),
                  child: ScaleTransition(
                    scale: _animationController.drive(
                      Tween<double>(begin: 1.3, end: 1.0).chain(
                        CurveTween(
                          curve: Interval(0.2, 0.4, curve: Curves.elasticInOut),
                        ),
                      ),
                    ),
                    child: Container(
                      width: width * 0.3,
                      height: width * 0.3,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.08),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/SincAlogo.png',
                          fit: BoxFit.fill,
                          scale: 0.9,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              FadingSlidingWidget(
                animationController: _animationController,
                interval: const Interval(0.5, 0.9),
                child: Text(
                  'SincA',
                  style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: width * 0.08,
                    fontFamily: 'ProductbSans',
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.2,
              ),
              Container(
                width: width * 0.9,
                child: FadingSlidingWidget(
                  animationController: _animationController,
                  interval: const Interval(0.7, 1.0),
                  child: Text(
                    welcomepagetxt,
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: width * 0.056,
                      fontFamily: 'ProductSans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
