import 'package:flutter/material.dart';

import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/helper/screen_utils.dart';

class ChildDashboardHeaderWidget extends StatelessWidget {
  final String name;
  const ChildDashboardHeaderWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff0074D9),
            Color(0xff0074D9),
            Color(0xffFDFDFD),
          ], // Add your desired colors here
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child:SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(
              left:ScreenUtils().screenWidth(context)*0.06,
              right: ScreenUtils().screenWidth(context)*0.08,
              bottom: ScreenUtils().screenWidth(context)*0.02

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Hello little \n $name", style: TextStyle(
                  fontFamily: "comic_neue",
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white
              ),),

              Image.asset(
                "assets/images/dashboard_profile.png",
                height: ScreenUtils().screenHeight(context)*0.12,
                width: ScreenUtils().screenWidth(context)*0.2,
                fit: BoxFit.cover, // This makes the image cover the entire area of the circle
              ),

            ],
          ),
        ),
      ) ,
    );
  }
}
