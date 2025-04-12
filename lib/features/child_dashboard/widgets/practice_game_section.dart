import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class PracticeGameSection extends StatefulWidget {
  const PracticeGameSection({super.key});

  @override
  State<PracticeGameSection> createState() => _PracticeGameSectionState();
}

class _PracticeGameSectionState extends State<PracticeGameSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PracticeGameWidget(imageLink: 'assets/images/level_1.png', level: 'level-1',),
        PracticeGameWidget(imageLink: 'assets/images/level_2.png', level: 'level-2',),
        PracticeGameWidget(imageLink: 'assets/images/level_3.png', level: 'level-3',)

      ],
    );
  }


}

class PracticeGameWidget extends StatelessWidget {
  final String imageLink;
  final String level;
  const PracticeGameWidget({super.key, required this.imageLink, required this.level});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Image.asset(imageLink,
          height: ScreenUtils().screenHeight(context)*0.12,
          width: ScreenUtils().screenWidth(context)*0.25,
        ),
        Text(level, style: TextStyle(
            fontFamily: "Kavoon",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.dailyStreakColor
        ),)
      ],
    );
  }
}

