import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

import '../../../core/utils/commonWidgets/common_button.dart';

class LearningGameCategorySection extends StatefulWidget {
  final Color avatorColor;
  final String gameName;
  final String gameDescription;
  final String image;
  Function()? onTap;
   LearningGameCategorySection({super.key, this.onTap,required this.avatorColor, required this.gameName, required this.gameDescription, required this.image});

  @override
  State<LearningGameCategorySection> createState() =>
      _LearningGameCategorySectionState();
}

class _LearningGameCategorySectionState
    extends State<LearningGameCategorySection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtils().screenWidth(context) * 0.45,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: ScreenUtils().screenHeight(context) * 0.17 ,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.exploreCardBg,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: AppColors.colorBlack.withOpacity(0.25),
                      )
                    ]
                ),
               // backgroundColor: AppColors.colorBlack,
              ),
              Positioned(
                bottom: -10,
                child: CircleAvatar(
                  radius: ScreenUtils().screenHeight(context) * 0.08,
                  backgroundColor: widget.avatorColor,
                  child: Center(
                    child: Image.asset(widget.image,
                    height: ScreenUtils().screenHeight(context) * 0.2,
                      width: ScreenUtils().screenWidth(context)*0.22,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtils().screenHeight(context) * 0.02,
          ),
          Text(
            widget.gameName,
            textAlign: TextAlign.center,

            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: "comic_neue",
                color: AppColors.colorBlack,
                fontSize: 16),
          ),
          Text(
            widget.gameDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: "comic_neue",
                color: AppColors.colorBlack.withOpacity(0.51),
                fontSize: 11),
          ),
          SizedBox(
            height: ScreenUtils().screenHeight(context) * 0.015,
          ),
          CommonButton(
            onTap: widget.onTap,
            fontSize: 16,
            height: ScreenUtils().screenHeight(context) * 0.04,
            width: ScreenUtils().screenWidth(context) * 0.3,
            buttonColor: AppColors.welcomeButtonColor,
            buttonName: 'Play',
            buttonTextColor: AppColors.white,
            gradientColor1: Color(0xffc66d32),
            gradientColor2: Color(0xfffed402),
            icon: Icons.play_arrow,
          ),
        ],
      ),
    );
  }
}
