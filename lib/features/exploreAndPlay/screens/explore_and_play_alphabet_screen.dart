import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/constants/app_strings_bengali.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

import '../../../core/utils/commonWidgets/common_back_button.dart';
import '../widgets/bengali_word_circle.dart';
import '../widgets/explore_screen_button.dart';
import '../widgets/learning_game_category_section.dart';

class ExploreAndPlayScreen extends StatefulWidget {
  const ExploreAndPlayScreen({super.key});

  @override
  State<ExploreAndPlayScreen> createState() => _ExploreAndPlayScreenState();
}

class _ExploreAndPlayScreenState extends State<ExploreAndPlayScreen> {
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
                          "assets/images/alphabet/alphabet_top_bg.png"),
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
                                letter: AppStringsBengali.letterBha),
                            SizedBox(
                                width:
                                    ScreenUtils().screenWidth(context) * 0.04),
                            BengaliWordCircle(
                                letter: AppStringsBengali.letterAa),
                            SizedBox(
                                width:
                                    ScreenUtils().screenWidth(context) * 0.04),
                            BengaliWordCircle(
                                letter: AppStringsBengali.letterCha),
                          ],
                        ),
                        SizedBox(
                            height: ScreenUtils().screenHeight(context) * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BengaliWordCircle(
                                letter: AppStringsBengali.letterDda),
                            SizedBox(
                                width:
                                    ScreenUtils().screenWidth(context) * 0.04),
                            BengaliWordCircle(
                                letter: AppStringsBengali.letterHa),
                            SizedBox(
                                width:
                                    ScreenUtils().screenWidth(context) * 0.04),
                            BengaliWordCircle(
                                letter: AppStringsBengali.letterDdha),
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
                                "Alphabet Fun!",
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
                                    onTap:(){
                                      Navigator.pushNamed(context, "/AllBengaliLetterScreen");
                                    },
                                    avatorColor: AppColors.alphabetFunContainer1
                                        .withOpacity(0.72),
                                    gameName: 'Match the Letter',
                                    gameDescription:
                                        'Match uppercase with lowercase using drag & drop.',
                                    image:
                                        'assets/images/alphabet/match_letter.png',
                                  ),
                                  LearningGameCategorySection(
                                      avatorColor: AppColors
                                          .alphabetFunContainer2
                                          .withOpacity(0.79),
                                      gameName: 'Listen & Spell',
                                      gameDescription:
                                          'Hear a word and spell it using letter blocks',
                                      image:
                                          'assets/images/alphabet/listen_spell.png')
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
                                          .alphabetFunContainer3
                                          .withOpacity(0.64),
                                      gameName: 'Letter Tracing',
                                      gameDescription:
                                          'Trace uppercase and lowercase letters',
                                      image:
                                          'assets/images/alphabet/letter_tracing.png'),
                                  LearningGameCategorySection(
                                      avatorColor: AppColors
                                          .alphabetFunContainer4
                                          .withOpacity(0.73),
                                      gameName: 'Alphabet Puzzle',
                                      gameDescription:
                                          'Put the letters in the correct order',
                                      image:
                                          'assets/images/alphabet/alphabet_puzzel.png')
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
