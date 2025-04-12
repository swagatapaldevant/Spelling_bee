import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/constants/app_strings_bengali.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class BengaliWordCircle extends StatelessWidget {
  final String letter;
  const BengaliWordCircle({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils().screenHeight(context)*0.05,
      width: ScreenUtils().screenWidth(context)*0.1,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              color: AppColors.colorBlack,
            )
          ]
      ),
      child: Center(
        child: Text(letter, style: TextStyle(
            color: AppColors.colorBlack,
          fontFamily: "comic_neue",
          fontSize: 16,
          fontWeight: FontWeight.w700
        ),),
      ),
    );
  }
}
