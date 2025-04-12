import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/constants/app_strings_bengali.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class QuestionOptionContainerWidget extends StatefulWidget {
  Function()? onTap;
  final String letter;
   QuestionOptionContainerWidget({super.key, this.onTap, required this.letter});

  @override
  State<QuestionOptionContainerWidget> createState() => _QuestionOptionContainerWidgetState();
}

class _QuestionOptionContainerWidgetState extends State<QuestionOptionContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
            child: Text(widget.letter, style: TextStyle(
              fontSize: 80,
              color: AppColors.colorBlack,
              fontWeight: FontWeight.w600
            ),),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Bounceable(
            onTap: widget.onTap,
            child: Image.asset("assets/images/match_letter/volume.png",
              height: ScreenUtils().screenHeight(context)*0.04,
              width: ScreenUtils().screenWidth(context)*0.1,
              fit: BoxFit.contain,

            ),
          ),
        )
      ],
    );
  }
}
