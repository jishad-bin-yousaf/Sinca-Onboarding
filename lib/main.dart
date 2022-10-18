import 'package:animated_onboarding/Themes/theme_provider.dart';
import 'package:animated_onboarding/screens/Spalsh.dart';
import 'package:animated_onboarding/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:animated_onboarding/screens/onboard/onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showMainScreen = prefs.getBool('showMainScreen') ?? false;

  runApp(
    MyApp(showMainScreen: showMainScreen),
  );
}

class MyApp extends StatelessWidget {
  final bool showMainScreen;

  const MyApp({
    Key? key,
    required this.showMainScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme(),
      darkTheme: MyThemes.darkTheme(),
      home: showMainScreen ? Mainscreen() : Onboard(),
    );
  }
}
