import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

import '../../core/utils/commonWidgets/common_button.dart';
import '../../core/utils/commonWidgets/custom_button.dart';

class WellcomeScreen extends StatefulWidget {
  const WellcomeScreen({super.key});

  @override
  State<WellcomeScreen> createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/welcome.png",
            height: ScreenUtils().screenHeight(context),
            width: ScreenUtils().screenWidth(context),
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Welcome To Spelling Bee", style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                  color: AppColors.colorBlack,
                  fontFamily: "Kavoon"
                ),),

                SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

                Text("Spell, play, and learn—because \n spelling is fun!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 21,
                    color: AppColors.welcomeText,
                    fontFamily: "ABeeZee"
                ),),

                SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),
                Image.asset("assets/images/welcome_cartoon.png",
                  height: ScreenUtils().screenHeight(context)*0.4,
                  width: ScreenUtils().screenWidth(context)*5,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.02 ,),
                CommonButton(
                  onTap: (){
                    Navigator.pushNamed(context, "/LoginScreen");
                  },
                  fontSize: 16,
                  height: ScreenUtils().screenHeight(context)*0.05,
                  width: ScreenUtils().screenWidth(context)*0.7,
                  buttonColor: AppColors.welcomeButtonColor,
                  buttonName: 'Get Started', buttonTextColor: AppColors.white,
                  gradientColor1: Color(0xffc66d32),
                  gradientColor2: Color(0xfffed402),
                ),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.02 ,),
                CommonButton(
                  onTap: (){
                    Navigator.pushNamed(context, "/OverviewScreen");
                  },
                  fontSize: 16,
                  height: ScreenUtils().screenHeight(context)*0.05,
                  width: ScreenUtils().screenWidth(context)*0.7,
                  buttonColor: AppColors.welcomeButtonColor,
                  buttonName: 'Overview', buttonTextColor: AppColors.white,
                  gradientColor1: Color(0xff0074D9),
                  gradientColor2: Color(0xff003D73).withOpacity(0.45),
                )



              ],
            ),
          )
        ],
      ),
    );
  }
}
