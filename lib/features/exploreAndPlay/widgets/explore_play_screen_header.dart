import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/commonWidgets/common_back_button.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class ExplorePlayScreenHeader extends StatelessWidget {
  const ExplorePlayScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtils().screenWidth(context),
      height: ScreenUtils().screenHeight(context) * 0.25,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFF0A6ABE),
            Color(0xFFC6CDD4),
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
            ScreenUtils().screenWidth(context) * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonBackButton(
                  bgColor: AppColors.alphabetFunContainer4,
                ),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                Text(
                  "Spell, Play, and\n Shine! 🌟",
                  style: TextStyle(
                      fontFamily: "comic_neue",
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white),
                ),
              ],
            ),
            Image.asset("assets/images/overview_cn.png",
              height: ScreenUtils().screenHeight(context)*0.2,
              width: ScreenUtils().screenWidth(context)*0.5,
            )
            // SizedBox(
            //     height: ScreenUtils().screenHeight(context) * 0.02),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     BengaliWordCircle(
            //         letter: AppStringsBengali.letterBha),
            //     SizedBox(
            //         width:
            //             ScreenUtils().screenWidth(context) * 0.04),
            //     BengaliWordCircle(
            //         letter: AppStringsBengali.letterAa),
            //     SizedBox(
            //         width:
            //             ScreenUtils().screenWidth(context) * 0.04),
            //     BengaliWordCircle(
            //         letter: AppStringsBengali.letterCha),
            //   ],
            // ),
            // SizedBox(
            //     height: ScreenUtils().screenHeight(context) * 0.02),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     BengaliWordCircle(
            //         letter: AppStringsBengali.letterDda),
            //     SizedBox(
            //         width:
            //             ScreenUtils().screenWidth(context) * 0.04),
            //     BengaliWordCircle(
            //         letter: AppStringsBengali.letterHa),
            //     SizedBox(
            //         width:
            //             ScreenUtils().screenWidth(context) * 0.04),
            //     BengaliWordCircle(
            //         letter: AppStringsBengali.letterDdha),
            //   ],
            // ),
            // SizedBox(height: 30), // optional bottom spacing
          ],
        ),
      ),
    );
  }
}
