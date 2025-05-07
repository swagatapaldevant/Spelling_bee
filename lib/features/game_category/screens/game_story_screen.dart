import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/commonWidgets/common_button.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/game_category/models/game_list_model.dart';

class GameStoryScreen extends StatefulWidget {
  final GameListModel gameDetails;
  const GameStoryScreen({super.key, required this.gameDetails});

  @override
  State<GameStoryScreen> createState() => _GameStoryScreenState();
}

class _GameStoryScreenState extends State<GameStoryScreen> {
  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                height: ScreenUtils().screenHeight(context),
                width: ScreenUtils().screenWidth(context),
                'assets/images/forest.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Padding(
                padding:  EdgeInsets.all(AppDimensions.screenPadding),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "🌟 Timi's Magical Word Quest 🌟",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "comic_neue",
                        color: AppColors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: ScreenUtils().screenWidth(context)*0.03),
                    Text(
                      "Join Timi the Tiger on a magical journey to discover hidden letters, solve fun puzzles, and save the enchanted forest!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "comic_neue",
                        color: AppColors.white.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: ScreenUtils().screenHeight(context)*0.05,),
                    Image.asset("assets/images/boy.png",
                    height: ScreenUtils().screenHeight(context)*0.4,
                      width: ScreenUtils().screenWidth(context)*0.4,
                    ),
                    SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                    CommonButton(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, '/GameLevelScreen', arguments: widget.gameDetails);
                      },
                        height: ScreenUtils().screenHeight(context)*0.05,
                        width: ScreenUtils().screenWidth(context),
                        buttonColor: AppColors().colorDarkBlue,
                        buttonName: "LET'S PLAY ",
                        buttonTextColor: AppColors.white.withOpacity(0.9),
                        gradientColor1: AppColors().colorDarkBlue,
                        gradientColor2: AppColors.colorSkyBlue300)
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
