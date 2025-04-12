import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class GameOnContainer extends StatefulWidget {
  const GameOnContainer({super.key});

  @override
  State<GameOnContainer> createState() => _GameOnContainerState();
}

class _GameOnContainerState extends State<GameOnContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        image: DecorationImage(
          image: AssetImage("assets/images/game_on_bg.png"),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          width: 8,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: ScreenUtils().screenWidth(context) * 0.04),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Game On, Brain On!",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: AppColors.colorBlack,
                    fontFamily: "comic_neue",
                  ),
                ),

                SizedBox(height: ScreenUtils().screenHeight(context) * 0.02),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(ScreenUtils().screenWidth(context) * 0.07),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtils().screenWidth(context) * 0.015,
                      horizontal: ScreenUtils().screenWidth(context) * 0.04,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Play More",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.colorBlack,
                            fontFamily: "comic_neue",
                          ),
                        ),
                        SizedBox(width: ScreenUtils().screenWidth(context) * 0.05),
                        Image.asset(
                          "assets/images/play_icon.png",
                          height: ScreenUtils().screenHeight(context) * 0.025,
                          width: ScreenUtils().screenWidth(context) * 0.05,
                          fit: BoxFit.contain,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Image.asset(
              "assets/images/game_on_img.png",
              height: ScreenUtils().screenHeight(context) * 0.15,
              width: ScreenUtils().screenWidth(context) * 0.4,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
