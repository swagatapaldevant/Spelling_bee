import 'package:flutter/material.dart';

import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/helper/screen_utils.dart';

class LearningStatusSection extends StatefulWidget {
  const LearningStatusSection({super.key});

  @override
  State<LearningStatusSection> createState() => _LearningStatusSectionState();
}

class _LearningStatusSectionState extends State<LearningStatusSection> {
  double progress = 0.6;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/images/learning_status_cn.png",
          height: ScreenUtils().screenHeight(context) * 0.2,
          width: ScreenUtils().screenWidth(context) * 0.3,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)),
          height: ScreenUtils().screenHeight(context) * 0.2,
          width: ScreenUtils().screenWidth(context) * 0.6,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/learning_status_bg.png",
                  height:
                  ScreenUtils().screenHeight(context) * 0.2,
                  width:
                  ScreenUtils().screenWidth(context) * 0.6,
                ),
                Positioned(
                  top: ScreenUtils().screenHeight(context)*0.04,
                  left: ScreenUtils().screenHeight(context)*0.03,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Learning Status",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            fontFamily: "comic_neue",
                            color: AppColors.colorBlack),
                      ),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

                      Text(
                        "Letters   12/50",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            fontFamily: "comic_neue",
                            color: AppColors.progressBarTextColor),
                      ),
                      SizedBox(
                        width: ScreenUtils().screenWidth(
                            context)*0.3, // Fixed width for the progress bar
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(10),
                          value: progress,
                          minHeight:
                          10, // Height of the progress bar
                          valueColor:
                          AlwaysStoppedAnimation<Color>(
                              AppColors.progressBarColor), // Fill color
                          backgroundColor: Colors
                              .grey[300], // Background color
                        ),
                      ),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

                      Text(
                        "Games   3/10",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            fontFamily: "comic_neue",
                            color: AppColors.progressBarTextColor),
                      ),
                      SizedBox(
                        width: ScreenUtils().screenWidth(
                            context)*0.3, // Fixed width for the progress bar
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(10),
                          value: progress,
                          minHeight:
                          10, // Height of the progress bar
                          valueColor:
                          AlwaysStoppedAnimation<Color>(
                              AppColors.progressBarColor), // Fill color
                          backgroundColor: Colors
                              .grey[300], // Background color
                        ),
                      ),
                      SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

                      Text(
                        "Total Time Spent: 45 min",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            fontFamily: "comic_neue",
                            color: AppColors.progressBarTextColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
