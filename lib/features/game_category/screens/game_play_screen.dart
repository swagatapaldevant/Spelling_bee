import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:lottie/lottie.dart';
import 'package:spelling_bee/core/utils/commonWidgets/common_button.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/game_category/screens/game_category_screen.dart';

class ActualGamePlayScreen extends StatefulWidget {
  const ActualGamePlayScreen({super.key});

  @override
  State<ActualGamePlayScreen> createState() => _ActualGamePlayScreenState();
}

class _ActualGamePlayScreenState extends State<ActualGamePlayScreen> {
  final List<String> imageList = [
  "https://media.istockphoto.com/id/1446199740/photo/path-through-a-sunlit-forest.jpg?s=612x612&w=0&k=20&c=DuozAED7qfI5E6PcVb4bHtFJ_uM_n1duok56j_liLEA=",
    "https://images.unsplash.com/photo-1542273917363-3b1817f69a2d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGZvcmVzdHxlbnwwfHwwfHx8MA%3D%3D",
    "https://cdn.pixabay.com/photo/2016/03/15/18/12/forest-1258845_640.jpg",
    "https://media.cntraveler.com/photos/5eb18e42fc043ed5d9779733/master/pass/BlackForest-Germany-GettyImages-147180370.jpg",
    "https://media.istockphoto.com/id/1446199740/photo/path-through-a-sunlit-forest.jpg?s=612x612&w=0&k=20&c=DuozAED7qfI5E6PcVb4bHtFJ_uM_n1duok56j_liLEA=",
    "https://images.unsplash.com/photo-1542273917363-3b1817f69a2d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGZvcmVzdHxlbnwwfHwwfHx8MA%3D%3D",
    "https://cdn.pixabay.com/photo/2016/03/15/18/12/forest-1258845_640.jpg",
  ];

  final List<Map<String, dynamic>> forestQuizQuestions = [
  {
      "question": "Which animal roars loudly in the forest?",
      "options": ["সিংহ", "বানর", "হাতি", "হরিণ"],
       "images":"https://static.vecteezy.com/system/resources/thumbnails/030/762/991/small/portrait-lion-standing-on-the-rock-with-light-exposure-ai-generative-photo.jpg",
      "answerIndex": 0,
    },
    {
      "question": "Which one is green in color and found in the forest?",
      "options": ["গাছ", "পাথর", "আগুন", "পানি"],
      "images":"https://images.pexels.com/photos/53435/tree-oak-landscape-view-53435.jpeg?cs=srgb&dl=pexels-pixabay-53435.jpg&fm=jpg",
      "answerIndex": 0,
    },
    {
      "question": "Which animal jumps from tree to tree?",
      "options": ["হাতি", "বানর", "সাপ", "পাখি"],
      "images":"https://t4.ftcdn.net/jpg/05/29/61/37/360_F_529613760_ZN7wI9c62MyPeFC8ioliQ2wrVohVuRey.jpg",
      "answerIndex": 1,
    },
    {
      "question": "Who carries loads and walks slowly in the jungle?",
      "options": ["বাঘ", "সিংহ", "হাতি", "হরিণ"],
      "images":"https://media.istockphoto.com/id/1452952557/photo/big-tusker-craig-in-amboseli-kenya-with-a-clouded-sky-in-the-background.jpg?s=612x612&w=0&k=20&c=Hs2YQUox5mIG0NJlyhqNjRklTGvkVmk_UfHs18lYg6E=",
      "answerIndex": 2,
    },
    {
      "question": "Which bird hoots at night and has big eyes?",
      "options": ["টিয়া", "পেঁচা", "কাক", "চড়ুই"],
      "images":"https://media.istockphoto.com/id/1323187200/photo/spotted-owlet.jpg?s=612x612&w=0&k=20&c=Y0103wykL7LJBhBNUi2HH3uNlCuRZ3I2xVrZcUgryt4=",
      "answerIndex": 1,
    },
    {
      "question": "Which of the following is not an animal?",
      "options": ["গাছ", "সাপ", "সিংহ", "বানর"],
      "images":"https://images.pexels.com/photos/53435/tree-oak-landscape-view-53435.jpeg?cs=srgb&dl=pexels-pixabay-53435.jpg&fm=jpg",
      "answerIndex": 0,
    },
    {
      "question": "What do you call ‘forest’ in Bengali?",
      "options": ["নদী", "শহর", "গ্রাম", "বন"],
      "images":"https://images.pexels.com/photos/53435/tree-oak-landscape-view-53435.jpeg?cs=srgb&dl=pexels-pixabay-53435.jpg&fm=jpg",
      "answerIndex": 3,
    },
  ];

  int currentQuestionIndex = 0;
  int wrongAttemptCount = 0;
  int correctAnswerCount = 0;
  String? selectedWrongOption;
  Key questionKey = UniqueKey();

  void onOptionSelected(String selected) {
    final currentQuestion = forestQuizQuestions[currentQuestionIndex];
    final correctAnswer = currentQuestion['options'][currentQuestion['answerIndex']];

    if (selected == correctAnswer) {
      correctAnswerCount++;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) => Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: Lottie.asset(
              'assets/images/animations/coin.json',
              repeat: false,
              onLoaded: (composition) {
                Future.delayed(composition.duration, () async {
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
                });
              },
            ),
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
                height: ScreenUtils().screenHeight(context) * 0.4,
                repeat: false,
                onLoaded: (composition) {
                  Future.delayed(composition.duration, () {
                    if (!mounted) return;
                    Navigator.of(dialogContext).pop();
                    setState(() => selectedWrongOption = null);
                    if (wrongAttemptCount >= 4) {
                      if (currentQuestionIndex < forestQuizQuestions.length - 1) {
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
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Please Retry again !!",
                    style: TextStyle(
                      fontSize: 24,
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
                    onTap: (){
                      Navigator.of(endDialogContext).pop();
                      setState(() {
                        currentQuestionIndex = 0;
                        wrongAttemptCount = 0;
                        selectedWrongOption = null;
                        correctAnswerCount = 0;
                        questionKey = UniqueKey();
                      });
                      },
                    height: ScreenUtils().screenHeight(context)*0.04,
                    width: ScreenUtils().screenWidth(context)*0.3,
                    buttonColor: AppColors().colorDarkBlue,
                    buttonName: "Replay ",
                    fontSize: 16,
                    borderRadius: 12,
                    buttonTextColor: AppColors.white.withOpacity(0.9),
                    gradientColor1:AppColors.colorSkyBlue300,
                    gradientColor2: AppColors().colorDarkBlue),

                CommonButton(
                    onTap: (){
                      Navigator.of(endDialogContext).pop();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => GameCategoryScreen()),
                            (route) => false,
                      );

                    },
                    height: ScreenUtils().screenHeight(context)*0.04,
                    width: ScreenUtils().screenWidth(context)*0.3,
                    buttonColor: AppColors().colorDarkBlue,
                    buttonName: "Submit ",
                    buttonTextColor: AppColors.white.withOpacity(0.9),
                    fontSize: 16,
                    borderRadius: 12,
                    gradientColor1: AppColors().colorDarkBlue,
                    gradientColor2: AppColors.colorSkyBlue300)
              ],
            ),
            SizedBox( height: ScreenUtils().screenHeight(context) * 0.05,)

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    final question = forestQuizQuestions[currentQuestionIndex]['question'];
    final image = forestQuizQuestions[currentQuestionIndex]['images'];
    final options = List<String>.from(forestQuizQuestions[currentQuestionIndex]['options']);

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/forest.jpeg",
            width: ScreenUtils().screenWidth(context),
            height: ScreenUtils().screenHeight(context),
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.03),
                  _buildTitleBox(),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.03),
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
        borderRadius: const BorderRadius.only(topRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
        boxShadow: [BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: AppColors.colorBlack.withOpacity(0.53))],
      ),
      child: const Center(
        child: Text(
          "Forest Quiz (Find animal)",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, fontFamily: "comic_neue", color: AppColors.white),
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
        borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        boxShadow: [BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: AppColors.colorBlack.withOpacity(0.53))],
      ),
      child: Column(
        children: [
           SizedBox(height: ScreenUtils().screenHeight(context)*0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                question,
                key: questionKey,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "comic_neue",
                color: AppColors.white
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.02),
          Container(
           // height: ScreenUtils().screenHeight(context)*0.2,
            width: ScreenUtils().screenWidth(context)*0.6,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.white, width: 2),
                borderRadius: BorderRadius.circular(10)
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(image)),
          ),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.02),
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
                      color: isWrong ? AppColors.colorTomato : AppColors.optionContainer,
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
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: "comic_neue"),
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
