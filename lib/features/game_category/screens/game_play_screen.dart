import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:spelling_bee/core/network/apiHelper/api_endpoint.dart';
import 'package:spelling_bee/core/network/apiHelper/locator.dart';
import 'package:spelling_bee/core/network/apiHelper/resource.dart';
import 'package:spelling_bee/core/network/apiHelper/status.dart';
import 'package:spelling_bee/core/services/localStorage/shared_pref.dart';
import 'package:spelling_bee/core/utils/commonWidgets/common_button.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/common_utils.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/game_category/data/game_category_usecase.dart';
import 'package:spelling_bee/features/game_category/models/game_list_model.dart';
import 'package:spelling_bee/features/game_category/models/game_question_model.dart';
import 'package:spelling_bee/features/game_category/screens/animated_earned_coined_text.dart';

class ActualGamePlayScreen extends StatefulWidget {
  final GameListModel gameDetails;
  final String levelId;
  final int gamePoint;

  const ActualGamePlayScreen(
      {super.key,
      required this.gameDetails,
      required this.levelId,
      required this.gamePoint});

  @override
  State<ActualGamePlayScreen> createState() => _ActualGamePlayScreenState();
}

class _ActualGamePlayScreenState extends State<ActualGamePlayScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  int currentQuestionIndex = 0;
  int wrongAttemptCount = 0;
  int correctAnswerCount = 0;
  int wrongAnswerCount = 0;
  String? selectedWrongOption;
  Key questionKey = UniqueKey();
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  final FlutterTts flutterTts = FlutterTts();
  late Stopwatch _stopwatch;
  final GameCategoryUsecase _gameCategoryUsecase = getIt<GameCategoryUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  List<QuestionDetailsModel> gameQuestionList = [];
  int secondCount = 0;

  void onOptionSelected(String selected) {
    final correctAnswer =
        gameQuestionList[currentQuestionIndex].correctAnswer ?? "";

    if (selected == correctAnswer) {
      correctAnswerCount++;
      speakLetter("WellDone, You choose write option $selected");
      //speakLetter(selected);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) => Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/images/animations/welldone.json',
                repeat: true,
                onLoaded: (composition) {
                  // Future.delayed(composition.duration, () async {
                  //   if (!mounted) return;
                  //   Navigator.of(dialogContext).pop();
                  //
                  //   if (currentQuestionIndex < forestQuizQuestions.length - 1) {
                  //     setState(() {
                  //       currentQuestionIndex++;
                  //       questionKey = UniqueKey();
                  //       wrongAttemptCount = 0;
                  //       selectedWrongOption = null;
                  //     });
                  //   } else {
                  //     _showEndDialog();
                  //   }
                  // });
                },
              ),
              AnimatedEarnedCoinsText(),
              SizedBox(
                height: ScreenUtils().screenHeight(context) * 0.05,
              ),
              CommonButton(
                  onTap: () {
                    if (!mounted) return;
                    Navigator.of(dialogContext).pop();

                    if (currentQuestionIndex < gameQuestionList.length - 1) {
                      setState(() {
                        currentQuestionIndex++;
                        questionKey = UniqueKey();
                        wrongAttemptCount = 0;
                        selectedWrongOption = null;
                      });
                    } else {
                      _showEndDialog();
                    }
                  },
                  height: ScreenUtils().screenHeight(context) * 0.04,
                  width: ScreenUtils().screenWidth(context) * 0.5,
                  buttonColor: AppColors().colorDarkBlue,
                  buttonName: "Next",
                  fontSize: 16,
                  borderRadius: 10,
                  buttonTextColor: AppColors.white.withOpacity(0.9),
                  gradientColor1: AppColors().colorDarkBlue,
                  gradientColor2: AppColors.colorSkyBlue300)
            ],
          ),
        ),
      );
    } else {
      speakLetter("Good Try, $selected is not correct option");
      wrongAttemptCount++;
      setState(() => selectedWrongOption = selected);

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) => Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/images/animations/try_again.json',
                height: ScreenUtils().screenHeight(context) * 0.3,
                width: ScreenUtils().screenWidth(context) * 0.6,
                repeat: false,
                onLoaded: (composition) {
                  //composition.duration
                  Future.delayed(Duration(seconds: 4), () {
                    if (!mounted) return;
                    Navigator.of(dialogContext).pop();
                    setState(() => selectedWrongOption = null);
                    // if (wrongAttemptCount >= 4) {
                    if (currentQuestionIndex < gameQuestionList.length - 1) {
                      setState(() {
                        currentQuestionIndex++;
                        questionKey = UniqueKey();
                        wrongAttemptCount = 0;
                      });
                    } else {
                      _showEndDialog();
                    }
                    // }
                  });
                },
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.colorTomato,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Text(
                    "Good Try !!",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.white,
                      fontFamily: "comic_neue",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _showEndDialog() {
    _stopwatch.stop();
    final elapsedTime = _stopwatch.elapsed;
    final minutes = elapsedTime.inMinutes;
    final seconds = elapsedTime.inSeconds % 60;
    final formattedTime = '$minutes min $seconds sec';
    secondCount = int.parse(elapsedTime.inSeconds.toString());
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
                fontWeight: FontWeight.w600,
                fontFamily: 'comic_neue',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              "Time Taken: $formattedTime",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'comic_neue',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "You have given $correctAnswerCount/${gameQuestionList.length} correct answer",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'comic_neue',
              ),
              textAlign: TextAlign.center,
            ),
            Lottie.asset(
              'assets/images/animations/trophy.json',
              height: ScreenUtils().screenHeight(context) * 0.2,
              width: ScreenUtils().screenWidth(context) * 0.4,
              repeat: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonButton(
                    onTap: () {
                      Navigator.of(endDialogContext).pop();
                      setState(() {
                        currentQuestionIndex = 0;
                        wrongAttemptCount = 0;
                        selectedWrongOption = null;
                        correctAnswerCount = 0;
                        questionKey = UniqueKey();
                        gameQuestionList.shuffle();
                        _stopwatch.reset();
                        _stopwatch.start();
                      });
                    },
                    height: ScreenUtils().screenHeight(context) * 0.06,
                    width: ScreenUtils().screenWidth(context) * 0.25,
                    buttonColor: AppColors().colorDarkBlue,
                    buttonName: "Replay ",
                    fontSize: 15,
                    borderRadius: 12,
                    buttonTextColor: AppColors.white.withOpacity(0.9),
                    gradientColor1: AppColors.colorSkyBlue300,
                    gradientColor2: AppColors().colorDarkBlue),
                CommonButton(
                    onTap: () {
                      _stopwatch.reset();
                      _stopwatch.start();
                      gameSubmitApi(endDialogContext);
                      Navigator.of(endDialogContext).pop();
                      Navigator.of(context)
                          .pushReplacementNamed('/GameLevelScreen');
                    },
                    height: ScreenUtils().screenHeight(context) * 0.06,
                    width: ScreenUtils().screenWidth(context) * 0.4,
                    buttonColor: AppColors().colorDarkBlue,
                    buttonName: "Proceed to next Level",
                    buttonTextColor: AppColors.white.withOpacity(0.9),
                    fontSize: 15,
                    borderRadius: 12,
                    gradientColor1: AppColors().colorDarkBlue,
                    gradientColor2: AppColors.colorSkyBlue300)
              ],
            ),
            SizedBox(
              height: ScreenUtils().screenHeight(context) * 0.05,
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    gameContentDetails();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut, // playful bounce
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
      ),
    );

    // Delay the animation slightly to make it pop
    Future.delayed(const Duration(milliseconds: 200), () {
      _controller.forward();
    });

    _stopwatch = Stopwatch()..start();
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            ApiEndPoint.domain + widget.gameDetails.backgroundImage.toString(),
            width: ScreenUtils().screenWidth(context),
            height: ScreenUtils().screenHeight(context),
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),
                  _buildTitleBox(),
                  SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),
                  if (gameQuestionList.length > currentQuestionIndex)
                    _buildQuizBox(
                        gameQuestionList[currentQuestionIndex]
                            .question
                            .toString(),
                        gameQuestionList[currentQuestionIndex].answer ?? [],
                        gameQuestionList[currentQuestionIndex]
                            .image
                            .toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBox() {
    return Container(
      height: ScreenUtils().screenHeight(context) * 0.06,
      width: ScreenUtils().screenWidth(context) * 0.85,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.3),
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              color: AppColors.colorBlack.withOpacity(0.53))
        ],
      ),
      child: Center(
        child: Text(
          widget.gameDetails.storyTitle.toString(),
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              fontFamily: "comic_neue",
              color: AppColors.white),
        ),
      ),
    );
  }

  Widget _buildQuizBox(String question, List<String> options, String image) {
    return Container(
      height: ScreenUtils().screenHeight(context) * 0.65,
      width: ScreenUtils().screenWidth(context) * 0.85,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.3),
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              color: AppColors.colorBlack.withOpacity(0.53))
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                question,
                key: questionKey,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    fontFamily: "comic_neue",
                    color: AppColors.white),
              ),
            ),
          ),
          SizedBox(height: ScreenUtils().screenHeight(context) * 0.02),
          Container(
            height: ScreenUtils().screenHeight(context) * 0.2,
            width: ScreenUtils().screenWidth(context) * 0.6,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.white, width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(ApiEndPoint.domain + image)),
          ),
          SizedBox(height: ScreenUtils().screenHeight(context) * 0.02),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: options.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: ScreenUtils().screenWidth(context) * 0.05,
                crossAxisSpacing: ScreenUtils().screenWidth(context) * 0.05,
                childAspectRatio: 2,
              ),
              itemBuilder: (context, index) {
                final option = options[index];
                final isWrong = selectedWrongOption == option;
                return Bounceable(
                  onTap: () => onOptionSelected(option),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isWrong
                          ? AppColors.colorTomato
                          : AppColors.optionContainer,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Text(
                      option,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: "comic_neue"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> gameContentDetails() async {
    setState(() => isLoading = true);

    Map<String, dynamic> requestData = {};
    Resource resource = await _gameCategoryUsecase.gameQuestionAnswer(
      requestData: requestData,
      gameId: widget.gameDetails.sId.toString(),
      levelId: widget.levelId,
    );

    if (resource.status == STATUS.SUCCESS) {
      gameQuestionList = (resource.data as List)
          .map((x) => QuestionDetailsModel.fromJson(x))
          .toList();

      gameQuestionList.shuffle();

    } else {
      CommonUtils().flutterSnackBar(
        context: context,
        mes: resource.message ?? "",
        messageType: 4,
      );
    }

    setState(() => isLoading = false);
  }

  gameSubmitApi(BuildContext endDialogContext) async {
    setState(() {
      isLoading = true;
    });
    String? userId = await _pref.getChildId();

    Map<String, dynamic> requestData = {
      "user_id": userId,
      "game_id": widget.gameDetails.sId,
      "level_id": widget.levelId,
      "time_taken": secondCount,
      "corrected_answer": correctAnswerCount.toString(),
      "collected_points":
          (widget.gamePoint / int.parse(gameQuestionList.length.toString())) *
              correctAnswerCount
    };

    Resource resource =
        await _gameCategoryUsecase.gameSubmit(requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      //Navigator.of(endDialogContext).pop();
      // Navigator.of(context)
      //     .pushReplacementNamed('/GameLevelScreen');
      // gameQuestionList = (resource.data as List)
      //     .map((x) => QuestionDetailsModel.fromJson(x))
      //     .toList();
    } else {
      CommonUtils().flutterSnackBar(
        context: context,
        mes: resource.message ?? "",
        messageType: 4,
      );
    }

    setState(() => isLoading = false);
  }
}
