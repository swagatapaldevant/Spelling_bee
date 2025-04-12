import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

import '../../../core/utils/commonWidgets/common_button.dart';
import '../../../core/utils/commonWidgets/custom_textField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtils().screenHeight(context),
        width: ScreenUtils().screenWidth(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xffc66d32),
              Color(0xfffed402),
            ],
            tileMode: TileMode.mirror,
          ),
        ),

        child: SafeArea(
          child: Stack(
            children: [
              
              Positioned(
                top: 0,
                right: 20,
                child: Image.asset("assets/images/login_bee.png", fit: BoxFit.contain,
                //height: ScreenUtils().screenHeight(context)*0.4,
                  width: ScreenUtils().screenWidth(context)*0.7,
                ),
              ),


              Positioned(
                bottom: 0,
                child: Container(
                  height: ScreenUtils().screenHeight(context)*0.55,
                  width: ScreenUtils().screenWidth(context),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                      topRight: Radius.circular(ScreenUtils().screenWidth(context)*0.1),
                      topLeft: Radius.circular(ScreenUtils().screenWidth(context)*0.1),
                    )
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(ScreenUtils().screenWidth(context)*0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sign in to continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: AppColors.colorBlack,
                            fontFamily: "comic_neue",
                          ),),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.04,),

                        CustomTextField(controller: phoneController, hintText: 'Mobile number/email', prefixIcon: Icons.phone,),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                        CustomTextField(controller: passwordController, hintText: 'Password', prefixIcon: Icons.lock,suffixIcon: Icons.visibility,),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.04,),
                         CommonButton(
                            onTap: (){
                              Navigator.pushNamed(context, "/BottomNavBar");
                            },
                            fontSize: 16,
                            height: ScreenUtils().screenHeight(context)*0.05,
                            width: ScreenUtils().screenWidth(context)*0.7,
                            buttonColor: AppColors.welcomeButtonColor,
                            buttonName: 'Sign in', buttonTextColor: AppColors.white,
                            gradientColor1: Color(0xffc66d32),
                            gradientColor2: Color(0xfffed402),
                           icon: Icons.arrow_forward,

                          ),

                        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.forgotPasswordColor,
                              fontFamily: "comic_neue",
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),

                        InkWell(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, "/SignupScreen");
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Dont have an account yet?',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.forgotPasswordColor,
                                fontFamily: "ABeeZee",
                              ),
                              children: const <TextSpan>[
                                TextSpan(
                                    text: ' Sign up now', style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColors.dailyStreakColor,
                                  fontFamily: "comic_neue",
                                )),

                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              )
          
            ],
          ),
        ),
      ),
    );
  }
}
