import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
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
}
