import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';

import '../../../core/utils/commonWidgets/common_button.dart';
import '../../../core/utils/commonWidgets/custom_dropdown.dart';
import '../../../core/utils/commonWidgets/custom_textField.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/helper/screen_utils.dart';
import '../widgets/profile_header.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phController = TextEditingController();

  Map<String, String> genderValue = {"Male":"1","Female":"2","Others":"3"};
  String selectedGender = "";
  String selectedGenderId = "";

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(AppDimensions.screenPadding),
            child: Column(
              children: [
                ProfileHeader(isBackIcon: true, headerName: "Edit Profile",onTap: (){
                  Navigator.pop(context);
                },),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),
                Container(
                  height: ScreenUtils().screenHeight(context) * 0.15,
                  width: ScreenUtils().screenHeight(context) * 0.15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: AppColors.colorBlack.withOpacity(0.25),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Padding(
                      padding: EdgeInsets.all(8.0), // optional spacing inside
                      child: Image.asset(
                        "assets/images/profile_img.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                Text(
                  "OLIVER JACKSON",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "comic_neue",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorBlack),
                ),
                Text(
                  "abc@gmail.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "comic_neue",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.forgotPasswordColor),
                ),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),

                Container(
                  width: ScreenUtils().screenWidth(context),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray3),
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.profileContainerColor,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: AppColors.colorBlack.withOpacity(0.25),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(AppDimensions.screenPadding),
                    child: Column(
                      children: [
                        CustomTextField(controller: nameController, hintText: 'Enter your name', prefixIcon: Icons.person,),
                    SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Enter your email',
                          prefixIcon: Icons.email,),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),

                        CustomTextField(controller:phController , hintText: 'Enter your phone', prefixIcon: Icons.phone,),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),

                        CustomDropDownForTaskCreation(
                          dropdownContainerColor: AppColors.white,
                          data: genderValue,
                          placeHolderText: 'Select your gender',
                          onValueSelected: (String value, String id) {
                            setState(() {
                              selectedGender = value; // Update selected value
                              selectedGenderId = id;

                            });
                          },
                        ),

                        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                        CustomDropDownForTaskCreation(
                          dropdownContainerColor: AppColors.white,
                          data: genderValue,
                          placeHolderText: 'Select your age',
                          onValueSelected: (String value, String id) {
                            setState(() {
                              selectedGender = value; // Update selected value
                              selectedGenderId = id;

                            });
                          },
                        ),
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                        CustomDropDownForTaskCreation(
                          dropdownContainerColor: AppColors.white,
                          data: genderValue,
                          placeHolderText: 'Select your grade',
                          onValueSelected: (String value, String id) {
                            setState(() {
                              selectedGender = value; // Update selected value
                              selectedGenderId = id;

                            });
                          },
                        ),

                        SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),
                        CommonButton(
                          onTap:(){},
                          fontSize: 14,
                          height: ScreenUtils().screenHeight(context) * 0.04,
                          width: ScreenUtils().screenWidth(context) * 0.5,
                          buttonColor: AppColors.welcomeButtonColor,
                          buttonName: 'Update Your Profile ',
                          buttonTextColor: AppColors.white,
                          gradientColor1: Color(0xffc66d32),
                          gradientColor2: Color(0xfffed402),
                          // icon: Icons.play_arrow,
                        ),

                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
