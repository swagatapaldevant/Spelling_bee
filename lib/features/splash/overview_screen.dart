import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/splash/widgets/overview_screen_widget.dart';

import '../../core/utils/commonWidgets/common_back_button.dart';
import '../../core/utils/commonWidgets/common_button.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
        body: Stack(children: [
      Image.asset(
        "assets/images/overview.png",
        height: ScreenUtils().screenHeight(context),
        width: ScreenUtils().screenWidth(context),
        fit: BoxFit.cover,
      ),
      Padding(
        padding: EdgeInsets.all(AppDimensions.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonBackButton(),
            Center(
              child: Image.asset(
                "assets/images/overview_cn.png",
                height: ScreenUtils().screenHeight(context) * 0.2,
                width: ScreenUtils().screenWidth(context) * 0.5,
                //fit: BoxFit.contain,
              ),
            ),
            Text(
              "Learning Spelling Has Never Been This Fun!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "comic_neue",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dailyStreakColor),
            ),
            Text(
              "Welcome to a magical world where kids build their vocabulary while playing, listening, and exploring. With adorable characters and interactive games, spelling becomes a joyful journey rather thana chore.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "comic_neue",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.colorBlack),
            ),
            SizedBox(
              height: ScreenUtils().screenHeight(context) * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OverviewScreenWidget(
                  iconPath: 'assets/images/game-controller.png',
                  iconContainerBgColor: AppColors.gameControllerBg.withOpacity(0.62),
                  containerName: 'Play & Learn',
                  containerDescription:
                      'Tap into spelling games that make learning exciting and interactive!',
                ),
                OverviewScreenWidget(
                  iconPath: 'assets/images/listen.png',
                  iconContainerBgColor:
                      AppColors.listenSpellBg.withOpacity(0.83),
                  containerName: 'Listen & Spell',
                  containerDescription:
                      'Improve listening skills with guided audio activities.',
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtils().screenHeight(context) * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OverviewScreenWidget(
                  iconPath: 'assets/images/setings_overview.png',
                  iconContainerBgColor: AppColors.rewardBg.withOpacity(0.73),
                  containerName: 'Reward & Stars',
                  containerDescription:
                      'Earn stickers, trophies, and stars as you level up your skills.',
                ),
                OverviewScreenWidget(
                  iconPath: 'assets/images/kids.png',
                  iconContainerBgColor: AppColors.progressBarColor,
                  containerName: ' Made for Kids',
                  containerDescription:
                      'Safe, simple, and designed for early learners.',
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtils().screenHeight(context) * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonButton(
                  onTap: () {
                    //Navigator.pushNamed(context, "/OverviewScreen");
                  },
                  fontSize: 16,
                  height: ScreenUtils().screenHeight(context) * 0.05,
                  width: ScreenUtils().screenWidth(context) * 0.44,
                  buttonColor: AppColors.welcomeButtonColor,
                  buttonName: 'Try Demo',
                  buttonTextColor: AppColors.white,
                  gradientColor1: Color(0xffc66d32),
                  gradientColor2: Color(0xfffed402),
                ),
                CommonButton(
                  onTap: () {
                    // Navigator.pushNamed(context, "/OverviewScreen");
                  },
                  fontSize: 16,
                  height: ScreenUtils().screenHeight(context) * 0.05,
                  width: ScreenUtils().screenWidth(context) * 0.44,
                  buttonColor: AppColors.welcomeButtonColor,
                  buttonName: 'Go To Dashboard',
                  buttonTextColor: AppColors.white,
                  gradientColor1: Color(0xff0074D9),
                  gradientColor2: Color(0xff003D73).withOpacity(0.45),
                )
              ],
            )
          ],
        ),
      )
    ]));
  }
}
