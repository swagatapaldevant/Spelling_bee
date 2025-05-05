import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class GameCategoryHeader extends StatelessWidget {
  const GameCategoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Pick a Spelling \nAdventure!",
        textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 27,
            color: AppColors.colorBlack,
            fontFamily: "comic_neue"
          ),
        ),
        
        Image.asset("assets/images/game_category/game_category_cn.png",
          height: ScreenUtils().screenHeight(context)*0.15,
          width: ScreenUtils().screenWidth(context)*0.3,
          fit: BoxFit.contain,
          ),
      ],
    );
  }
}
