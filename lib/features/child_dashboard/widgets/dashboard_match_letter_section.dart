import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_string.dart';
import 'package:spelling_bee/core/utils/constants/app_strings_bengali.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

import '../../../core/utils/constants/app_colors.dart';

class DashboardMatchLetterSection extends StatefulWidget {
  const DashboardMatchLetterSection({super.key});

  @override
  State<DashboardMatchLetterSection> createState() => _DashboardMatchLetterSectionState();
}

class _DashboardMatchLetterSectionState extends State<DashboardMatchLetterSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils().screenHeight(context)*0.25,
      width: ScreenUtils().screenWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: AppColors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/dashboard_match_letter_bg.png"),
          fit: BoxFit.contain,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorBlack.withOpacity(0.25), // Shadow color
            blurRadius: 4, // Blur radius
            offset: Offset(0, 4), // Horizontal and vertical offset
            spreadRadius: 0, // How much the shadow will spread
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(AppStringsBengali.letterA,style: TextStyle(
              fontFamily: "comic_neue",
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.colorBlack
          ), ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MatchLetterContainer(containerName: AppStringsBengali.wordAjagar,),
              MatchLetterContainer(containerName: AppStringsBengali.wordBoi,),

            ],
          ),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

          Text("Click a word",style: TextStyle(
              fontFamily: "comic_neue",
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.colorBlack
          ), ),

          SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Image.asset("assets/images/match_letter_cn.png",
               height: ScreenUtils().screenHeight(context)*0.04,
               width: ScreenUtils().screenHeight(context)*0.04,
               fit: BoxFit.contain,
             ),
              Text("Want more fun ? Tap here!",style: TextStyle(
                  fontFamily: "comic_neue",
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.colorBlack
              ), ),
               Image.asset("assets/images/tap.png",
               height: ScreenUtils().screenHeight(context)*0.04,
               width: ScreenUtils().screenHeight(context)*0.04,
                 fit: BoxFit.contain,
               ),
            ],
          ),


        ],
      ),
    );

  }
}


class MatchLetterContainer extends StatelessWidget {
  final String containerName;
  const MatchLetterContainer({super.key, required this.containerName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: AppColors.containerColor.withOpacity(0.54),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorBlack.withOpacity(0.25), // Shadow color
            blurRadius: 4, // Blur radius
            offset: Offset(0, 4), // Horizontal and vertical offset
            spreadRadius: 0, // How much the shadow will spread
          ),
        ],
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(
            horizontal: ScreenUtils().screenWidth(context)*0.04,
            vertical: ScreenUtils().screenWidth(context)*0.01

        ),
        child: Text(containerName,style: TextStyle(
            fontFamily: "comic_neue",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.white
        ), ),
      ),
    );
  }
}
