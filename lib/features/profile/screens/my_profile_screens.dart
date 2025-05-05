import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/commonWidgets/common_button.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

import '../widgets/profile_header.dart';
import '../widgets/profile_info_widget.dart';
import '../widgets/profile_option_widget.dart';

class MyProfileScreens extends StatefulWidget {
  const MyProfileScreens({super.key});

  @override
  State<MyProfileScreens> createState() => _MyProfileScreensState();
}

class _MyProfileScreensState extends State<MyProfileScreens> {
  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(
              left:AppDimensions.screenPadding,
              right: AppDimensions.screenPadding,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                ProfileHeader(headerName: "My Profile",),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),
                ProfileInfoWidget(
                  onButtonClicked: (){
                    Navigator.pushNamed(context, "/EditProfileScreen");
                  },
                ),

                SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),
            
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
            
                  child: Column(
                    children: [
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),
                      ProfileOptionWidget(iconPath: "assets/images/profile/star_icon.png", title: "My Stars"),
                      ProfileOptionWidget(iconPath: "assets/images/profile/badges_icon.png", title: "Badges"),
                      ProfileOptionWidget(iconPath: "assets/images/profile/library_icon.png", title: "Word Library"),
                      ProfileOptionWidget(iconPath: "assets/images/profile/practice_icon.png", title: "Practice Zone"),
                      ProfileOptionWidget(iconPath: "assets/images/profile/language_icon.png", title: "Choose Language"),
                      ProfileOptionWidget(iconPath: "assets/images/profile/themes_icon.png", title: "Themes"),
                      ProfileOptionWidget(iconPath: "assets/images/profile/reminders_icon.png", title: "Reminders"),
                      ProfileOptionWidget(iconPath: "assets/images/profile/clear_icon.png", title: "Clear Progress"),
                      ProfileOptionWidget(iconPath: "assets/images/profile/logout_icon.png", title: "Log Out", isVisible: false,),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.04,),
                      Text(
                        "App Version 1.0 — Keep Spelling, Keep Shining! ✨",
                        style: TextStyle(
                          fontFamily: "comic_neue",
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.colorBlack,
                        ),
                      ),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),

                    ],
                  ),
                ),

                SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
