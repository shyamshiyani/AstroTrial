import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/explore_info_provider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/splash_screen.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text(
                    'EXPLORE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'SOLAR SYSTEM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton.outlined(
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      Provider.of<ExploreInfoProvider>(context, listen: false)
                          .saveInfoData();
                      pref.setBool(
                          "SkipIntroPage",
                          Provider.of<ExploreInfoProvider>(context,
                                  listen: false)
                              .saveInfo);
                      Navigator.pushNamed(context, '/');
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
