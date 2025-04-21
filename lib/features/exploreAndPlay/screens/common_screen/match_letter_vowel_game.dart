import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/commonWidgets/common_dialog.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';
import '../../widgets/question_option_container_widget.dart';

class MatchLetterVowelGame extends StatefulWidget {
  final List<String> vowelList;
  const MatchLetterVowelGame({super.key, required this.vowelList});

  @override
  State<MatchLetterVowelGame> createState() => _MatchLetterVowelGameState();
}

class _MatchLetterVowelGameState extends State<MatchLetterVowelGame> {
  int currentIndex = 0;
  final FlutterTts flutterTts = FlutterTts();
  String? selectedWrongOption;

  @override
  void initState() {
    super.initState();
    initTts();
  }

  void initTts() async {
    await flutterTts.setLanguage("bn-IN");
    await flutterTts.setSpeechRate(0.45);
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.awaitSpeakCompletion(true);
  }

  void speakLetter(String letter) async {
    final pronunciation = letter;
    await flutterTts.speak(pronunciation);
  }

  String get currentLetter => widget.vowelList[currentIndex];

  List<String> generateOptions() {
    List<String> wrongOptions = List.from(widget.vowelList)..remove(currentLetter);
    wrongOptions.shuffle();
    List<String> options = wrongOptions.take(3).toList();
    options.add(currentLetter);
    options.shuffle();
    return options;
  }

  void onOptionSelected(String selected) {
    if (selected == currentLetter) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/images/animations/correct.json',
                height: ScreenUtils().screenHeight(context) * 0.4,
                width: ScreenUtils().screenWidth(context) * 0.6,
                repeat: false,
                onLoaded: (composition) {
                  Future.delayed(composition.duration, () async {
                    if (!mounted) return;

                    Navigator.of(dialogContext).pop(); // Close Lottie dialog

                    if (!mounted) return;

                    if (currentIndex < widget.vowelList.length - 1) {
                      setState(() {
                        currentIndex++;
                        selectedWrongOption = null;
                      });
                    } else {
                      await Future.delayed(Duration(milliseconds: 100));

                      if (!mounted) return;
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (endDialogContext) => AlertDialog(
                          backgroundColor: Colors.lightGreen.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                          actionsPadding: const EdgeInsets.only(bottom: 16, right: 16),
                          title: Row(
                            children: const [
                              Icon(Icons.emoji_events, color: Colors.orange, size: 32),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "Congratulations !!",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontFamily: 'comic_neue',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "You have finished this game 🥳",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'comic_neue',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                          Lottie.asset(
                            'assets/images/animations/trophy.json',
                            height: ScreenUtils().screenHeight(context) * 0.2,
                            width: ScreenUtils().screenWidth(context) * 0.4,
                            repeat: false,
                          )
                            ],
                          ),
                          actions: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                              icon: const Icon(Icons.check_circle_outline),
                              label: const Text(
                                "Done",
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                if (mounted) {
                                  Navigator.of(endDialogContext).pop(); // Close dialog
                                  Navigator.of(context).pop(); // Go back
                                }
                              },
                            ),
                          ],
                        ),
                      );

                    }
                  });
                },
              ),
            ],
          ),
        ),
      );
    } else {
      setState(() => selectedWrongOption = selected);
      Timer(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() => selectedWrongOption = null);
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    final current = currentLetter;
    final options = generateOptions();

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/match_letter/match_letter_bg.png",
            width: ScreenUtils().screenWidth(context),
            height: ScreenUtils().screenHeight(context),
            fit: BoxFit.fill,
          ),
          Center(
            child: Container(
              height: ScreenUtils().screenHeight(context) * 0.88,
              width: ScreenUtils().screenWidth(context) * 0.85,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: AppColors.colorBlack.withOpacity(0.53),
                  )
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.05,),
                      Text(
                        "Match The Letter",
                        style: TextStyle(
                          color: AppColors.colorBlack1,
                          fontFamily: "comic_neue",
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                      QuestionOptionContainerWidget(
                        letter: current,
                        onTap: () => speakLetter(current),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(AppDimensions.screenPadding),
                          child: GridView.builder(
                            itemCount: 4,
                            padding: const EdgeInsets.all(8),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: ScreenUtils().screenWidth(context) * 0.05,
                              crossAxisSpacing: ScreenUtils().screenWidth(context) * 0.05,
                              childAspectRatio: 1.3,
                            ),
                            itemBuilder: (context, index) {
                              String option = options[index];
                              return Bounceable(
                                onTap: () => onOptionSelected(option),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                        color: AppColors.colorBlack.withOpacity(0.25),
                                      )
                                    ],
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedWrongOption == option
                                          ? Colors.redAccent
                                          : AppColors.optionContainer,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                                    alignment: Alignment.center,
                                    child: Text(
                                      option,
                                      style: const TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Image.asset(
                        "assets/images/login_bee.png",
                        height: ScreenUtils().screenHeight(context) * 0.2,
                        width: ScreenUtils().screenWidth(context) * 0.4,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.05,)
                    ],
                  ),
                  // Positioned(
                  //   bottom: ScreenUtils().screenWidth(context) * 0.02,
                  //   //left: 0,
                  //   child: Image.asset(
                  //     "assets/images/login_bee.png",
                  //     height: ScreenUtils().screenHeight(context) * 0.2,
                  //     width: ScreenUtils().screenWidth(context) * 0.4,
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                  // Positioned(
                  //   right: ScreenUtils().screenWidth(context) * 0.02,
                  //   bottom: ScreenUtils().screenWidth(context) * 0.07,
                  //   child: Image.asset(
                  //     "assets/images/match_letter/match_letter_bottom_nature.png",
                  //     height: ScreenUtils().screenHeight(context) * 0.3,
                  //     width: ScreenUtils().screenWidth(context) * 0.5,
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
