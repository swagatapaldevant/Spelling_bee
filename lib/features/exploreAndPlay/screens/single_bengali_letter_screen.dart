import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import '../../../core/utils/commonWidgets/common_back_button.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/helper/screen_utils.dart';
import '../model/match_letter_quiz_model.dart';

class BengaliLetterDetailScreen extends StatefulWidget {
  final int initialIndex;

  const BengaliLetterDetailScreen({super.key, required this.initialIndex});

  @override
  State<BengaliLetterDetailScreen> createState() => _BengaliLetterDetailScreenState();
}

class _BengaliLetterDetailScreenState extends State<BengaliLetterDetailScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void goToNext() {
    if (currentIndex < letterQuestions.length - 1) {
      setState(() => currentIndex++);
    }
  }

  void goToPrevious() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    final currentLetter = letterQuestions[currentIndex].letter;

    return Scaffold(
      backgroundColor: AppColors.parentConcernBg,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(AppDimensions.screenPadding),
          child: Column(
            children: [
              Row(
                children: [
                  CommonBackButton(),
                  SizedBox(width: ScreenUtils().screenWidth(context)*0.03,),
                  Text(
                    'Tap the Bengali Letters!',
                    style: TextStyle(
                      fontFamily: "comic_neue",
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, size: 40, color: Colors.blueAccent),
                      onPressed: goToPrevious,
                    ),
                    Container(
                      width: ScreenUtils().screenWidth(context)*0.5,
                      height: ScreenUtils().screenHeight(context)*0.2,
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
                          ]
                      ),
                      child: Center(
                        child: Text(currentLetter, style: TextStyle(
                            fontSize: 80,
                            color: AppColors.colorBlack,
                            fontWeight: FontWeight.w600
                        ),),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 40, color: Colors.blueAccent),
                      onPressed: goToNext,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Tap the arrows to learn more letters!",
                style: TextStyle(
                  fontFamily: "comic_neue",
                  fontSize: 20,
                  color: Colors.black87,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
