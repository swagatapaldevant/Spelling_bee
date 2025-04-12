import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class ExploreScreenButton extends StatefulWidget {
  const ExploreScreenButton({super.key});

  @override
  State<ExploreScreenButton> createState() => _ExploreScreenButtonState();
}

class _ExploreScreenButtonState extends State<ExploreScreenButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [

        Container(
          height: ScreenUtils().screenHeight(context)*0.05,
          width: ScreenUtils().screenWidth(context),
          decoration: BoxDecoration(
            color: AppColors.alphabetFunContainer.withOpacity(0.83),
              borderRadius: BorderRadius.circular(11),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: AppColors.colorBlack.withOpacity(0.25),
                )
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/images/alphabet/left-arrow.png",
                height: ScreenUtils().screenHeight(context)*0.03,
                width: ScreenUtils().screenHeight(context)*0.03,
                fit: BoxFit.contain,
              ),
              Text("Level 1 / Beginner", style: TextStyle(
                  fontFamily: "comic_neue",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white
              ),),
              Image.asset("assets/images/alphabet/button_star.png",
                height: ScreenUtils().screenHeight(context)*0.03,
                width: ScreenUtils().screenHeight(context)*0.03,
                fit: BoxFit.contain,
              ),


            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: ScreenUtils().screenHeight(context)*0.025,
          child: Image.asset("assets/images/alphabet/buttom_icon.png",
            height: ScreenUtils().screenHeight(context)*0.1,
            width: ScreenUtils().screenWidth(context)*0.2,
          ),
        ),
      ],
    );
  }
}
