import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/commonWidgets/common_back_button.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/constants/app_strings_bengali.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/exploreAndPlay/widgets/bengali_word_circle.dart';
import 'package:spelling_bee/features/exploreAndPlay/widgets/explore_screen_button.dart';
import 'package:spelling_bee/features/exploreAndPlay/widgets/learning_game_category_section.dart';

class ExploreAndPlayNumberScreen extends StatefulWidget {
  const ExploreAndPlayNumberScreen({super.key});

  @override
  State<ExploreAndPlayNumberScreen> createState() => _ExploreAndPlayNumberScreenState();
}

class _ExploreAndPlayNumberScreenState extends State<ExploreAndPlayNumberScreen> {
  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      body: Material(
        color: AppColors.alphabetSafeArea,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: ScreenUtils().screenHeight(context) * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/alphabet/number_bg.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                        ScreenUtils().screenWidth(context) * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonBackButton(
                          bgColor: AppColors.alphabetFunContainer4,
                        ),
                        SizedBox(
                            height: ScreenUtils().screenHeight(context) * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BengaliWordCircle(
                                letter: AppStringsBengali.numberOne),
                            SizedBox(
                                width:
                                ScreenUtils().screenWidth(context) * 0.04),
                            BengaliWordCircle(
                                letter: AppStringsBengali.numberTwo),
                            SizedBox(
                                width:
                                ScreenUtils().screenWidth(context) * 0.04),
                            BengaliWordCircle(
                                letter: AppStringsBengali.numberThree),
                          ],
                        ),
                        SizedBox(
                            height: ScreenUtils().screenHeight(context) * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BengaliWordCircle(
                                letter: AppStringsBengali.numberFour),
                            SizedBox(
                                width:
                                ScreenUtils().screenWidth(context) * 0.04),
                            BengaliWordCircle(
                                letter: AppStringsBengali.numberFive),
                            SizedBox(
                                width:
                                ScreenUtils().screenWidth(context) * 0.04),
                            BengaliWordCircle(
                                letter: AppStringsBengali.numberSix),
                          ],
                        ),
                        SizedBox(height: 30), // optional bottom spacing
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtils().screenHeight(context) * 0.25,
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/alphabet/alphabet_down_bg.png",
                        width: ScreenUtils().screenWidth(context),
                        fit: BoxFit.cover,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(AppDimensions.screenPadding),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                ScreenUtils().screenHeight(context) * 0.04,
                              ),
                              Text(
                                "Fun with Numbers!",
                                style: TextStyle(
                                    fontFamily: "comic_neue",
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.colorBlack),
                              ),
                              Text(
                                "Choose Your Game",
                                style: TextStyle(
                                    fontFamily: "comic_neue",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.colorBlack),
                              ),
                              SizedBox(
                                height:
                                ScreenUtils().screenHeight(context) * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  LearningGameCategorySection(
                                    avatorColor: AppColors.numberGame1
                                        .withOpacity(0.65),
                                    gameName: 'Count & Tap',
                                    gameDescription:
                                    'Count the items and tap the correct number',
                                    image:
                                    'assets/images/alphabet/count_top.png',
                                  ),
                                  LearningGameCategorySection(
                                      avatorColor: AppColors
                                          .numberGame2
                                          .withOpacity(0.79),
                                      gameName: 'Trace the Number',
                                      gameDescription:
                                      'Trace numbers with your finger and hear their names',
                                      image:
                                      'assets/images/alphabet/trace_number.png')
                                ],
                              ),
                              SizedBox(
                                height:
                                ScreenUtils().screenHeight(context) * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  LearningGameCategorySection(
                                      avatorColor: AppColors
                                          .numberGame3
                                          .withOpacity(0.64),
                                      gameName: 'Number Order',
                                      gameDescription:
                                      'Put numbers in the correct order',
                                      image:
                                      'assets/images/alphabet/number_order.png'),
                                  LearningGameCategorySection(
                                      avatorColor: AppColors
                                          .numberGame4
                                          .withOpacity(0.70),
                                      gameName: 'Match Numbers',
                                      gameDescription:
                                      'Match the number to the group of items',
                                      image:
                                      'assets/images/alphabet/match_number.png')
                                ],
                              ),
                              SizedBox(
                                height:
                                ScreenUtils().screenHeight(context) * 0.09,
                              ),
                              ExploreScreenButton()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
