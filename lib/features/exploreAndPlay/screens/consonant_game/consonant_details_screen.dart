import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../../core/network/apiHelper/locator.dart';
import '../../../../core/services/localStorage/shared_pref.dart';
import '../../../../core/utils/commonWidgets/common_back_button.dart';
import '../../../../core/utils/commonWidgets/common_button.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';
import '../vowel_game/vowel_details_screen.dart';

class ConsonantDetailsScreen extends StatefulWidget {
  final int initialIndex;
  final List<String> letterList;
  const ConsonantDetailsScreen({super.key, required this.initialIndex, required this.letterList});

  @override
  State<ConsonantDetailsScreen> createState() => _ConsonantDetailsScreenState();
}

class _ConsonantDetailsScreenState extends State<ConsonantDetailsScreen> {
  late int currentIndex;
  final SharedPref _pref = getIt<SharedPref>();
  String languageName = "";

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    flutterTts.setLanguage("bn-IN"); // Bengali-Bangladesh
    flutterTts.setSpeechRate(0.4);   // Slower for better clarity
    flutterTts.setPitch(1.0);
    localData();
  }

  void goToNext() {
    if (currentIndex < widget.letterList.length - 1) {
      setState(() => currentIndex++);
    }
  }

  void goToPrevious() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }

  final FlutterTts flutterTts = FlutterTts();


  void speakLetter(String letter) async {
    final pronunciation = letter;
    await flutterTts.stop();
    await flutterTts.speak(pronunciation);
  }

  void localData() async{
    String? language = await _pref.getCurrentLanguageName();
    setState(() {
      languageName = language.toString();
    });

  }


  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    final currentLetter = widget.letterList[currentIndex];
    // letterQuestions[currentIndex].letter;
    return Scaffold(
      backgroundColor: AppColors.parentConcernBg,
      body: Stack(
        children: [
        Image.asset(
        "assets/images/alphabet/alphabet_details_bg.jpeg",
        height: ScreenUtils().screenHeight(context),
        width: ScreenUtils().screenWidth(context),
        fit: BoxFit.cover,
      ),
        Material(
          //color: AppColors.white.withOpacity(0.5),
          color: AppColors.colorBlack.withOpacity(0.5),
          child:SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.screenPadding),
              child: Column(
                children: [
                  Row(children: [
                    CommonBackButton(),
                    SizedBox(
                      width: ScreenUtils().screenWidth(context) * 0.03,
                    ),
                    Text(
                      'Tap the $languageName Alphabet!',
                      style: TextStyle(
                        fontFamily: "comic_neue",
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: ScreenUtils().screenHeight(context) * 0.03,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: ScreenUtils().screenWidth(context) * 0.7,
                        height: ScreenUtils().screenHeight(context) * 0.3,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFE8B388),
                                Color(0xFFF8E98E),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                color: AppColors.colorBlack.withOpacity(0.25),
                              )
                            ]),
                        child: Center(
                          child: Text(
                            currentLetter,
                            style: TextStyle(
                                fontSize: 100,
                                color: AppColors.colorBlack,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Bounceable(
                          onTap: ()=> speakLetter(currentLetter),
                          child: Image.asset(
                            "assets/images/match_letter/volume.png",
                            height: ScreenUtils().screenHeight(context) * 0.06,
                            width: ScreenUtils().screenWidth(context) * 0.2,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtils().screenHeight(context) * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.optionContainer,
                        child: Text(
                          (currentIndex + 1).toString(),
                          style: TextStyle(
                              fontFamily: "comic_neue",
                              fontSize: 20,
                              color: AppColors.colorBlack,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(width: ScreenUtils().screenWidth(context)*0.02,),
                      Text(
                        "/",
                        style: TextStyle(
                            fontFamily: "comic_neue",
                            fontSize: 30,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: ScreenUtils().screenWidth(context)*0.02,),
                      CircleAvatar(
                        backgroundColor: AppColors.optionContainer,
                        child: Text(
                          widget.letterList.length.toString(),
                          style: TextStyle(
                              fontFamily: "comic_neue",
                              fontSize: 20,
                              color: AppColors.colorBlack,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     text: (currentIndex+1).toString(),
                  //     style: TextStyle(
                  //         fontFamily: "comic_neue",
                  //         fontSize: 20,
                  //         color:AppColors.colorSkyBlue500,
                  //         fontWeight: FontWeight.w500
                  //     ),
                  //     children: <TextSpan>[
                  //       TextSpan(text:" / ${widget.letterList.length}", style: const TextStyle(
                  //           fontFamily: "comic_neue",
                  //           fontSize: 20,
                  //           color: AppColors.welcomeButtonColor,
                  //           fontWeight: FontWeight.w700
                  //       )),
                  //
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: ScreenUtils().screenHeight(context) * 0.02,
                  ),
                  const Text(
                    "Tap the arrows to learn more letters!",
                    style: TextStyle(
                        fontFamily: "comic_neue",
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtils().screenHeight(context) * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BackIconWidget(
                        onTap: goToPrevious,
                        icon: Icons.arrow_back_ios,
                      ),
                      BackIconWidget(
                        onTap: goToNext,
                        icon: Icons.arrow_forward_ios,
                      ),
                    ],
                  ),


                  SizedBox(
                    height: ScreenUtils().screenHeight(context) * 0.1,
                  ),

                  Visibility(
                    visible: currentIndex+1 == widget.letterList.length ? true:false,
                    child: CommonButton(
                      onTap: () {
                        Navigator.pushNamed(context, '/MatchLetterVowelGame',
                            arguments: widget.letterList
                        );
                      },
                      fontSize: 18,
                      height: ScreenUtils().screenHeight(context) * 0.06,
                      width: ScreenUtils().screenWidth(context) * 0.8,
                      buttonColor: AppColors.welcomeButtonColor,
                      buttonName: 'Let\'s Play Game',
                      buttonTextColor: AppColors.white,
                      gradientColor1: Color(0xffc66d32),
                      gradientColor2: Color(0xfffed402),
                      icon: Icons.play_arrow,
                    ),
                  ),


                ],
              ),
            ),
          ),
        )
        ],
      )




    );
  }
}
