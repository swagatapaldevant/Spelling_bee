import 'package:flutter/material.dart';

import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/helper/screen_utils.dart';

class LearningCategoryContainer extends StatefulWidget {
  final String containerName;
  final String imagePath;
  const LearningCategoryContainer({super.key, required this.containerName, required this.imagePath});

  @override
  State<LearningCategoryContainer> createState() => _LearningCategoryContainerState();
}

class _LearningCategoryContainerState extends State<LearningCategoryContainer> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: ScreenUtils().screenWidth(context)*0.42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            Color(0xffE26B1E),
            Color(0xff7C3B10),
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            //horizontal: ScreenUtils().screenWidth(context)*0.06,
        vertical: ScreenUtils().screenWidth(context)*0.03
        ),
        child: Column(
          children: [
            Text(widget.containerName, style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: "Kavoon",
                color: AppColors.white,
                fontSize: 14
            ),),
            SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
            Image.asset(widget.imagePath,
              height: ScreenUtils().screenHeight(context)*0.1,
              width: ScreenUtils().screenWidth(context)*0.2,
            )
          ],
        ),
      ),

    );
  }
}
