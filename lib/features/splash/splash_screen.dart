import 'package:flutter/material.dart';
import 'package:spelling_bee/core/network/apiHelper/locator.dart';
import 'package:spelling_bee/core/services/localStorage/shared_pref.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPref _pref = getIt<SharedPref>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      //setTimerNavigation();
      Navigator.pushReplacementNamed(context, "/WellcomeScreen");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            Image.asset("assets/images/Splash.jpg",
              height: ScreenUtils().screenHeight(context),
              width: ScreenUtils().screenWidth(context),
              fit: BoxFit.cover,
            ),
          Center(
            child: Image.asset("assets/images/splash_text.png",
                height: ScreenUtils().screenHeight(context)*0.2,
                width: ScreenUtils().screenWidth(context)*0.8,
                fit: BoxFit.contain,
              ),
          )
        ],
      )
    );
  }


  void setTimerNavigation() async {
    String token = await _pref.getUserAuthToken();
    bool loginStatus = await _pref.getLoginStatus();
    String userType = await _pref.getUserType();

    try {
      if (token.length > 10 ) {
        Navigator.pushReplacementNamed(context, "/BottomNavBar");
      }
      else {
        Navigator.pushReplacementNamed(
            context, "/WellcomeScreen");
      }

    } catch (ex) {
      Navigator.pushReplacementNamed(context, "/WellcomeScreen");
    }
  }
}
