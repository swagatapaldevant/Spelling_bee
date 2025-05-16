import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:spelling_bee/core/utils/commonWidgets/common_button.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/game_category/models/game_list_model.dart';
import 'package:spelling_bee/features/game_category/screens/animated_earned_coined_text.dart';

class ActualGamePlayScreen extends StatefulWidget {
  final GameListModel gameDetails;

  const ActualGamePlayScreen({super.key, required this.gameDetails});

  @override
  State<ActualGamePlayScreen> createState() => _ActualGamePlayScreenState();
}

class _ActualGamePlayScreenState extends State<ActualGamePlayScreen>
    with SingleTickerProviderStateMixin {




  int currentQuestionIndex = 0;
  int wrongAttemptCount = 0;
  int correctAnswerCount = 0;
  String? selectedWrongOption;
  Key questionKey = UniqueKey();
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  final FlutterTts flutterTts = FlutterTts();
  late Stopwatch _stopwatch;
   List<Map<String, dynamic>> forestQuizQuestions=[];

  void onOptionSelected(String selected) {
    final currentQuestion = forestQuizQuestions[currentQuestionIndex];
    final correctAnswer =
        currentQuestion['options'][currentQuestion['answerIndex']];

    if (selected == correctAnswer) {
      correctAnswerCount++;
      speakLetter(selected);
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
                'assets/images/animations/earn_money.json',
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

                    if (currentQuestionIndex < forestQuizQuestions.length - 1) {
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
                  buttonName: "Next Animal",
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
                  Future.delayed(composition.duration, () {
                    if (!mounted) return;
                    Navigator.of(dialogContext).pop();
                    setState(() => selectedWrongOption = null);
                    if (wrongAttemptCount >= 4) {
                      if (currentQuestionIndex <
                          forestQuizQuestions.length - 1) {
                        setState(() {
                          currentQuestionIndex++;
                          questionKey = UniqueKey();
                          wrongAttemptCount = 0;
                        });
                      } else {
                        _showEndDialog();
                      }
                    }
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
                    "Please Retry again !!",
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
              "You have given $correctAnswerCount/${forestQuizQuestions.length} correct answer",
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
              repeat: false,
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
    forestQuizQuestions = widget.gameDetails.gameName=="Game 4"?[
      {
        "question": "Which animal roars loudly in the forest?",
        "options": ["সিংহ", "বানর", "হাতি", "হরিণ"],
        "images":
        "https://static.vecteezy.com/system/resources/thumbnails/030/762/991/small/portrait-lion-standing-on-the-rock-with-light-exposure-ai-generative-photo.jpg",
        "answerIndex": 0,
      },
      {
        "question": "Which one is green in color and found in the forest?",
        "options": ["গাছ", "পাথর", "আগুন", "পানি"],
        "images":
        "https://images.pexels.com/photos/53435/tree-oak-landscape-view-53435.jpeg?cs=srgb&dl=pexels-pixabay-53435.jpg&fm=jpg",
        "answerIndex": 0,
      },
      {
        "question": "Which animal jumps from tree to tree?",
        "options": ["হাতি", "বানর", "সাপ", "পাখি"],
        "images":
        "https://t4.ftcdn.net/jpg/05/29/61/37/360_F_529613760_ZN7wI9c62MyPeFC8ioliQ2wrVohVuRey.jpg",
        "answerIndex": 1,
      },
      {
        "question": "Who carries loads and walks slowly in the jungle?",
        "options": ["বাঘ", "সিংহ", "হাতি", "হরিণ"],
        "images":
        "https://media.istockphoto.com/id/1452952557/photo/big-tusker-craig-in-amboseli-kenya-with-a-clouded-sky-in-the-background.jpg?s=612x612&w=0&k=20&c=Hs2YQUox5mIG0NJlyhqNjRklTGvkVmk_UfHs18lYg6E=",
        "answerIndex": 2,
      },
      {
        "question": "Which bird hoots at night and has big eyes?",
        "options": ["টিয়া", "পেঁচা", "কাক", "চড়ুই"],
        "images":
        "https://media.istockphoto.com/id/1323187200/photo/spotted-owlet.jpg?s=612x612&w=0&k=20&c=Y0103wykL7LJBhBNUi2HH3uNlCuRZ3I2xVrZcUgryt4=",
        "answerIndex": 1,
      },
      {
        "question": "Which of the following is not an animal?",
        "options": ["গাছ", "সাপ", "সিংহ", "বানর"],
        "images":
        "https://images.pexels.com/photos/53435/tree-oak-landscape-view-53435.jpeg?cs=srgb&dl=pexels-pixabay-53435.jpg&fm=jpg",
        "answerIndex": 0,
      },
      {
        "question": "What do you call ‘forest’ in Bengali?",
        "options": ["নদী", "শহর", "গ্রাম", "বন"],
        "images":
        "https://images.pexels.com/photos/53435/tree-oak-landscape-view-53435.jpeg?cs=srgb&dl=pexels-pixabay-53435.jpg&fm=jpg",
        "answerIndex": 3,
      },
    ]:
    [
      {
        "question": "Which item is used to cook food in the kitchen?",
        "options": ["বিছানা", "চুলা", "টেবিল", "টিভি"],
        "images":
    "https://5.imimg.com/data5/SELLER/Default/2023/1/NX/ZC/UD/3446735/c1-.jpg",
        "answerIndex": 1,
      },
      {
        "question": "Which one is used to keep food cold?",
        "options": ["ফ্রিজ", "প্লেট", "কাপড়", "ঘড়ি"],
        "images":
        "https://media.istockphoto.com/id/842160124/photo/refrigerator-with-fruits-and-vegetables.jpg?s=612x612&w=0&k=20&c=j0W4TPOevBpp3mS6_X2FHV1uWVl3fcfdGAt2X3l8XzE=",
        "answerIndex": 0,
      },
      {
        "question": "Which of these is used to eat rice?",
        "options": ["চামচ", "বালিশ", "কলম", "চশমা"],
        "images":
        "https://t3.ftcdn.net/jpg/02/75/16/00/360_F_275160059_SkK5HApn4AduORNqJeZnhiN7AuMDGHeZ.jpg",
        "answerIndex": 0,
      },
      {
        "question": "Where do we wash our hands in the kitchen?",
        "options": ["টেবিল", "সিংক", "খাট", "সোপা"],
        "images":
        "https://media.istockphoto.com/id/501599719/photo/washbasin-in-a-kitchen.jpg?s=612x612&w=0&k=20&c=_RsigaWska1w8MToFcKpOrIUyi8KXem82LZxGopRtTc=",
        "answerIndex": 1,
      },
      {
        "question": "Which one is used to cook rice?",
        "options": ["চা কাপ", "চামচ", "রাইস কুকার", "ঘড়ি"],
        "images":
        "https://media.istockphoto.com/id/1218421458/photo/kitchen-equipment-automatic-rice-cooker-gray.jpg?s=612x612&w=0&k=20&c=TSKGqJ5lrQgV6B2tSQ4Usj99lvPk_v1lndrpdoAY7Ac=",
        "answerIndex": 2,
      },
      {
        "question": "Which item do we sit on in the dining room?",
        "options": ["চেয়ার", "চামচ", "কাপড়", "রেফ্রিজারেটর"],
        "images":
        "https://supremefurniture.co.in/cdn/shop/files/Ornate-Red-Black.jpg?v=1706170905",
        "answerIndex": 0,
      },
      {
        "question": "Which of these is not used in cooking?",
        "options": ["চুলা", "বালিশ", "ফ্রাইং প্যান", "হাড়ি"],
        "images":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvmMOKx6fT5oZqEbcsd6RII2JabhXfdEM9rw&s",
        "answerIndex": 1,
      },
    ];
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
    final question = forestQuizQuestions[currentQuestionIndex]['question'];
    final image = forestQuizQuestions[currentQuestionIndex]['images'];
    final options =
        List<String>.from(forestQuizQuestions[currentQuestionIndex]['options']);

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
           widget.gameDetails.gameName == "Game 4"? "assets/images/forest.jpeg":"assets/images/kitchen.jpg",
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
                  _buildQuizBox(question, options, image),
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
      child:  Center(
        child: Text(
          widget.gameDetails.gameName == "Game 4"? "Forest Quiz (Find animal)":"Kitchen Quiz(Find utensils)",
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
            // height: ScreenUtils().screenHeight(context)*0.2,
            width: ScreenUtils().screenWidth(context) * 0.6,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.white, width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(image)),
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
}
