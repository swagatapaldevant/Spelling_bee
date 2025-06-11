import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class AchievementSection extends StatefulWidget {
  final int dailyCount;
  final int monthlyCount;
  final int weeklyCount;
  const AchievementSection({super.key, required this.dailyCount, required this.monthlyCount, required this.weeklyCount});

  @override
  State<AchievementSection> createState() => _AchievementSectionState();
}

class _AchievementSectionState extends State<AchievementSection> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.dailyCount);
    print(widget.monthlyCount);
    print(widget.weeklyCount);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/achievement_bg.png", fit: BoxFit.cover,),
        Positioned(
            top: 10,
            left: 20,
            child: AchievementStrikeCard(value:widget.dailyCount, name: 'Daily',)),
        Positioned(
          top: 10,
            left: 145,
            child: AchievementStrikeCard(value:widget.weeklyCount, name: 'Weekly',)),
        Positioned(
            bottom: 10,
            left: 80,
            child: AchievementStrikeCard(value:widget.monthlyCount, name: 'Monthly',)),
        Positioned(
          right: 0,
          child: Image.asset("assets/images/achievement_cn.png",
          height: ScreenUtils().screenHeight(context)*0.2,
            width: ScreenUtils().screenWidth(context)*0.4, fit: BoxFit.cover,
          ),
        ),

        // Positioned(
        //   bottom: 15,
        //   left: 10,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: AppColors.white,
        //       borderRadius: BorderRadius.circular(20),
        //       boxShadow: [
        //         BoxShadow(
        //           color: AppColors.colorBlack.withOpacity(0.25), // Shadow color
        //           blurRadius: 4, // Blur radius
        //           offset: Offset(0, 4), // Horizontal and vertical offset
        //           spreadRadius: 0, // How much the shadow will spread
        //         ),
        //       ],
        //     ),
        //     child: Padding(
        //       padding:  EdgeInsets.all(8.0),
        //       child: Text("Tap Here !", textAlign: TextAlign.center, style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 12,
        //           fontFamily:"comic_neue" ,
        //           color: AppColors.colorBlack
        //       ),),
        //     ),
        //   ),
        // )

      ],
    );
  }
}

class AchievementStrikeCard extends StatelessWidget {
  final int value;
  final String name;
  const AchievementStrikeCard({super.key, required this.value, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: ScreenUtils().screenHeight(context)*0.08,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColors.colorBlack,
                  width: 3
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/star.png",
                height: ScreenUtils().screenHeight(context)*0.035,
                width: ScreenUtils().screenHeight(context)*0.07,
                fit: BoxFit.contain,
              ),
              Text(value.toString(), style: TextStyle(
                  fontFamily: "comic_neue",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorBlack
              ),)
            ],
          ),

        ),
        Text(name, style: TextStyle(
            fontFamily: "comic_neue",
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppColors.colorBlack
        ),)
      ],
    );
  }
}
