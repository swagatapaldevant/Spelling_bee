import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

import '../../../core/utils/commonWidgets/common_button.dart';
import '../../../core/utils/commonWidgets/custom_textField.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedGender;
  String? selectedAge;

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFC66D32), // Top-left orange
              Color(0xFFFED402), // Bottom-right yellow
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: AppDimensions.screenPadding,
                  right: AppDimensions.screenPadding,
                  top: ScreenUtils().screenHeight(context) * 0.1,
                  bottom: AppDimensions.screenPadding,
                ),
                child: Container(
                  width: double.infinity,
                  padding:  EdgeInsets.symmetric(
                    horizontal: AppDimensions.screenPadding,
                    vertical: ScreenUtils().screenHeight(context) * 0.04,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Sign-Up",
                        style: TextStyle(
                          fontFamily: "comic_neue",
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: AppColors.progressBarTextColor,
                        ),
                      ),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),
                      CustomTextField(controller: nameController, hintText: 'Enter your name', prefixIcon: Icons.person,),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                      CustomTextField(controller: phController, hintText: 'Enter your Mobile number', prefixIcon: Icons.phone,),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                      CustomTextField(controller: passwordController, hintText: 'Enter your password', prefixIcon: Icons.lock,),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),

                      Text(
                        "Gender ",
                        style: TextStyle(
                          fontFamily: "comic_neue",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.colorBlack.withOpacity(0.65),
                        ),
                      ),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                      _buildGenderOption("Boy"),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                      _buildGenderOption("Girl"),

                      SizedBox(height: ScreenUtils().screenHeight(context)*0.025,),

                      Text(
                        "Age ",
                        style: TextStyle(
                          fontFamily: "comic_neue",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.colorBlack.withOpacity(0.65),
                        ),
                      ),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                      _buildAgeOption("4-6 years"),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                      _buildAgeOption("7-9 years"),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                      _buildAgeOption("10-14 years"),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.04,),

                      Center(
                        child: CommonButton(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, "/ParentConcernScreen");
                          },
                          fontSize: 16,
                          height: ScreenUtils().screenHeight(context)*0.05,
                          width: ScreenUtils().screenWidth(context)*0.6,
                          buttonColor: AppColors.welcomeButtonColor,
                          buttonName: 'Create Account', buttonTextColor: AppColors.white,
                          gradientColor1: Color(0xffc66d32),
                          gradientColor2: Color(0xfffed402),

                        ),
                      ),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, "/LoginScreen");
                        },
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.forgotPasswordColor,
                                fontFamily: "comic_neue",
                              ),
                              children: const <TextSpan>[
                                TextSpan(
                                    text: 'Log in here', style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColors.dailyStreakColor,
                                  fontFamily: "comic_neue",
                                )),

                              ],
                            ),
                          ),
                        ),
                      ),



                    ],
                  ),
                ),
              ),

              Positioned(
                right: 0,
                top: 0,
                child: Image.asset(
                  "assets/images/signup_cn.png",
                  height: ScreenUtils().screenHeight(context) * 0.2,
                  width: ScreenUtils().screenWidth(context) * 0.4,
                  fit: BoxFit.contain,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    final bool isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(4),
              color: isSelected ? Colors.black : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorBlack.withOpacity(0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: isSelected
                ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            )
                : null,
          ),
           SizedBox(width: ScreenUtils().screenWidth(context)*0.04),
          Text(
            gender,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: "comic_neue",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeOption(String age) {
    final bool isSelected = selectedAge== age;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAge = age;
        });
      },
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(4),
              color: isSelected ? Colors.black : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorBlack.withOpacity(0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: isSelected
                ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            )
                : null,
          ),
          SizedBox(width: ScreenUtils().screenWidth(context)*0.04),
          Text(
            age,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: "comic_neue",
            ),
          ),
        ],
      ),
    );
  }


}
