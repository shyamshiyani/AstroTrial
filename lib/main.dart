import 'package:flutter/material.dart';
import 'package:galaxy_planets_animator/Providers/explore_info_provider.dart';
import 'package:galaxy_planets_animator/Views/pages/Intro_Screen.dart';
import 'package:galaxy_planets_animator/Views/pages/Splash_Screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Providers/Theme_Povider.dart';
import 'Views/pages/Home_Screen.dart';

late bool saveIntroScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  saveIntroScreen = pref.getBool("SkipIntroPage") ?? false;
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ExploreInfoProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
      ),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          theme: themeNotifier.themeData,
          debugShowCheckedModeBanner: false,
          initialRoute: (saveIntroScreen) ? "SplashScreen" : "IntroScreen",
          routes: {
            '/': (context) => const HomeScreen(),
            'SplashScreen': (context) => const SplashScreen(),
            'IntroScreen': (context) => const IntroScreen(),
          },
        );
      },
    );
  }
}
