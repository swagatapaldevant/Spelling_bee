import 'package:flutter/material.dart';
import 'package:spelling_bee/core/network/apiHelper/locator.dart';
import 'package:spelling_bee/core/network/apiHelper/resource.dart';
import 'package:spelling_bee/core/network/apiHelper/status.dart';
import 'package:spelling_bee/core/services/localStorage/shared_pref.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/common_utils.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/achievements/data/achievement.usecase.dart';

import 'dashboard_circular_progress_widget.dart';

class ChildDashboardProgressContainer extends StatefulWidget {
  const ChildDashboardProgressContainer({super.key});

  @override
  State<ChildDashboardProgressContainer> createState() => _ChildDashboardProgressContainerState();
}

class _ChildDashboardProgressContainerState extends State<ChildDashboardProgressContainer> {
  String totalCoins = "";
  String totalLevels = "";
  bool isLoading = false;
  final AchievementUsecase _achievementUsecase = getIt<AchievementUsecase>();
  final SharedPref _pref = getIt<SharedPref>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    achievementData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtils().screenWidth(context),
      decoration: BoxDecoration(
        color: AppColors.dashboardContainerBackgroundColor.withOpacity(0.74),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorBlack.withOpacity(0.25), // Shadow color
            blurRadius: 4, // Blur radius
            offset: Offset(0, 4), // Horizontal and vertical offset
            spreadRadius: 0, // How much the shadow will spread
          ),
        ],
      ),
      child: Padding(
        padding:  EdgeInsets.all(ScreenUtils().screenWidth(context)*0.06),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Spell, Play, and Shine! 🌟", style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  fontFamily: "comic_neue",
                  color: AppColors.white
                ),),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtils().screenWidth(context)*0.05),
                    color: AppColors.white
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                       horizontal:  ScreenUtils().screenWidth(context)*0.05,
                      vertical: ScreenUtils().screenWidth(context)*0.01


                    ),
                    child: Row(
                      children: [
                        Text("Total Earning", style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            fontFamily: "comic_neue",
                            color: AppColors.colorBlack
                        ),),

                        SizedBox(width: ScreenUtils().screenWidth(context)*0.02,),

                        Row(
                          children: [

                            Text(totalCoins, style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                fontFamily: "comic_neue",
                                color: AppColors.colorBlack
                            ),),
                            Image.asset("assets/images/star.png",
                              height: ScreenUtils().screenHeight(context)*0.03,
                              width: ScreenUtils().screenHeight(context)*0.04,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                ),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(ScreenUtils().screenWidth(context)*0.05),
                      color: AppColors.white
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:  ScreenUtils().screenWidth(context)*0.05,
                        vertical: ScreenUtils().screenWidth(context)*0.02


                    ),
                    child: Row(
                      children: [
                        Text("Daily Streak", style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            fontFamily: "comic_neue",
                            color: AppColors.colorBlack
                        ),),

                        SizedBox(width: ScreenUtils().screenWidth(context)*0.05,),

                        Text("12/ $totalLevels ", style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            fontFamily: "comic_neue",
                            color: AppColors.dailyStreakColor
                        ),),

                      ],
                    ),
                  ),

                ),


              ],
            ),

            Image.asset("assets/images/dashboard_img.png",
            height: ScreenUtils().screenHeight(context)*0.1,
              width: ScreenUtils().screenWidth(context)*0.3,
            ),
          ],
        ),
      ),


    );
  }

  Future<void> achievementData() async {
    setState(() => isLoading = true);

    String? userId = await _pref.getChildId();
    Map<String, dynamic> requestData = {};
    Resource resource = await _achievementUsecase.achievementData(
      requestData: requestData,
      id: userId.toString(),
    );

    if (resource.status == STATUS.SUCCESS) {

      totalCoins = resource.data["totalCoinsEarnedAllTime"].toString();
      totalLevels = resource.data["totalLevelsInGame"].toString();

      setState(() {
        isLoading = false;
      });
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
