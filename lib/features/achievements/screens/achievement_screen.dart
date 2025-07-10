import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:spelling_bee/core/network/apiHelper/locator.dart';
import 'package:spelling_bee/core/network/apiHelper/resource.dart';
import 'package:spelling_bee/core/network/apiHelper/status.dart';
import 'package:spelling_bee/core/services/localStorage/shared_pref.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/common_utils.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/achievements/data/achievement.usecase.dart';
import 'package:spelling_bee/features/achievements/models/achievement_result_model.dart';
import 'package:spelling_bee/features/achievements/models/top_three_user_model.dart';
import 'package:spelling_bee/features/achievements/widgets/achievement_screen_header.dart';
import 'package:spelling_bee/features/achievements/widgets/leaderboard_section.dart';
import 'package:spelling_bee/features/child_dashboard/widgets/achievement_section.dart';
import 'package:spelling_bee/features/child_dashboard/widgets/child_dashboard_header.dart';
import 'package:spelling_bee/features/child_dashboard/widgets/learning_status_section.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  String totalCoins = "";
  String totalLevels = "";
  bool isLoading = false;
  final AchievementUsecase _achievementUsecase = getIt<AchievementUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  List<AchievementResultModel> resultList = [];
  List<double> weeklyTime = [];
  List<double> weeklyProgress = [];
  final List<String> weekDays = [];
  List<double> weekValue = List.filled(7, 0);
  List<double> weekValueProgress = List.filled(7, 0);
  int dailyCount = 0;
  int weeklyCount = 0;
  int monthlyCount = 0;
  double totalTimeByWeek = 0.0;
  List<TopThreeUserModel> topThreeUserList  = [];
  int currentUserRank = 0;
  var firstUser ;
  var secondUser ;
  var thirdUser;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    achievementData();
  }

  void animateBars() async {
    for (int i = 0; i < weeklyTime.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        weekValue[i] = weeklyTime[i];
        weekValueProgress[i] = weeklyProgress[i];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      backgroundColor: AppColors.parentConcernBg,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/alphabet/alphabet_details_bg.jpeg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.white.withOpacity(0.4),
                  AppColors.white.withOpacity(0.7),
                  AppColors.white,
                ],
              ),
            ),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.darkBlue,
                    ),
                  )
                : ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      SizedBox(height: AppDimensions.screenHeight * 0.02),

                      AchievementScreenHeader(),
                      ChildDashboardHeader(
                        headerName: 'Top three rankers',
                      ),
                      LeaderboardSection(
                        firstRankName: firstUser?.name ?? "N/A",
                        firstRankCoin:firstUser?.totalCoins ?? 0,
                        secondRankName: secondUser?.name ?? "N/A",
                        secondRankCoin: secondUser?.totalCoins ?? 0,
                        thirdRankName: thirdUser?.name ?? "N/A",
                        thirdRankCoin: thirdUser?.totalCoins ?? 0,),

                      currentUserRank>3?
                      Container(
                        width: AppDimensions.screenWidth,
                        decoration: BoxDecoration(
                          color: AppColors.alphabetSafeArea,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 10),
                            child: Column(
                              spacing: 5,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Your Rank is ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        fontFamily: "comic_neue",
                                        color: AppColors.white),
                                    children:  <TextSpan>[
                                      TextSpan(
                                          text: '$currentUserRank ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: "comic_neue",
                                            color: AppColors.white),),

                                    ],
                                  ),
                                ),

                                RichText(
                                  text: TextSpan(
                                    text: 'You need to earn ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        fontFamily: "comic_neue",
                                        color: AppColors.white),
                                    children:  <TextSpan>[
                                      TextSpan(
                                        text: '${thirdUser?.totalCoins - currentUserRank} ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: "comic_neue",
                                            color: AppColors.white),),
                                      TextSpan(
                                        text: 'more coins to achieve the rankers position',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            fontFamily: "comic_neue",
                                            color: AppColors.white),),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ): SizedBox.shrink(),
                      //SizedBox(height: AppDimensions.screenHeight * 0.02),
                      //SizedBox(height: AppDimensions.screenHeight * 0.02),
                      // ChildDashboardHeader(
                      //   headerName: 'Achievements',
                      // ),
                      SizedBox(
                        height: ScreenUtils().screenHeight(context) * 0.02,
                      ),
                      AchievementSection(dailyCount: dailyCount, monthlyCount: monthlyCount, weeklyCount: weeklyCount,),
                      SizedBox(
                        height: ScreenUtils().screenHeight(context) * 0.02,
                      ),
                      LearningStatusSection(
                        totalLevel: int.parse(totalLevels),
                        totalUnlockedLevel: 10,
                        totalTime: totalTimeByWeek,
                      ),
                      SizedBox(
                        height: ScreenUtils().screenHeight(context) * 0.02,
                      ),
                      Container(
                        width: ScreenUtils().screenWidth(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.gray7, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gray7.withOpacity(0.25),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              ScreenUtils().screenWidth(context) * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Weekly Overview",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: "comic_neue",
                                              color: AppColors.colorBlack))
                                      .animate()
                                      .slideY(duration: 400.ms)
                                      .fadeIn(),
                                  SizedBox(
                                      height:
                                          AppDimensions.screenHeight * 0.01),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildStatCard(
                                        emoji: "🎯",
                                        label: "Levels Unlocked",
                                        value: "10 / $totalLevels",
                                        color: Colors.lightGreenAccent,
                                      ),
                                      _buildStatCard(
                                        emoji: "🪙",
                                        label: "Coins Earned",
                                        value: "$totalCoins",
                                        color: Colors.amberAccent,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              AspectRatio(
                                aspectRatio: 1.4,
                                child: BarChart(
                                  BarChartData(
                                    maxY: getMaxY(
                                        [...weekValueProgress, ...weekValue]),
                                    barGroups:
                                        List.generate(weekDays.length, (index) {
                                      return BarChartGroupData(
                                        x: index,
                                        barsSpace: 0,
                                        barRods: [
                                          // Daily Treasure Hunt
                                          BarChartRodData(
                                            toY: weekValueProgress[index],
                                            width: 15,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              topLeft: Radius.circular(5),
                                            ),
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFF6FD8),
                                                Color(0xFF3813C2)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          // Weekly Play Time
                                          BarChartRodData(
                                            toY: weekValue[index],
                                            width: 15,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              topLeft: Radius.circular(5),
                                            ),
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColors.alphabetSafeArea,
                                                AppColors.colorSkyBlue500
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, _) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0),
                                              child: Text(
                                                weekDays[value.toInt()],
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "comic_neue",
                                                    color:
                                                        AppColors.colorBlack),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      topTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                      leftTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                      rightTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                    ),
                                    gridData: FlGridData(
                                      show: false,
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: const Border(
                                        bottom:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                    barTouchData: BarTouchData(
                                      enabled: true,
                                      touchTooltipData: BarTouchTooltipData(
                                        getTooltipItem:
                                            (group, groupIndex, rod, rodIndex) {
                                          final isTreasureHunt = rodIndex == 0;
                                          final label = isTreasureHunt
                                              ? "Earning"
                                              : "Play Time";
                                          final type = isTreasureHunt
                                              ? "Coins"
                                              : "Minutes";
                                          return BarTooltipItem(
                                            "$label: ${rod.toY.toStringAsFixed(1)} $type",
                                            const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "comic_neue"),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: AppDimensions.screenHeight * 0.015),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 8,
                                        backgroundColor:Color(0xFFFF6FD8)

                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Daily earned coin",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "comic_neue",
                                            color: AppColors.colorBlack),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 8,
                                        backgroundColor:  AppColors.alphabetSafeArea,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Daily playing time",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "comic_neue",
                                            color: AppColors.colorBlack),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: AppDimensions.screenHeight * 0.02),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String emoji,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.gray7, blurRadius: 4)],
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        children: [
          Text(emoji, style: TextStyle(fontSize: 20)),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: "comic_neue",
                      color: AppColors.colorBlack)),
              Text(value,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      fontFamily: "comic_neue",
                      color: AppColors.colorBlack)),
            ],
          ),
        ],
      ),
    ).animate().slideX(begin: -0.5).fadeIn(duration: 400.ms);
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
      resultList = (resource.data['result'] as List)
          .map((x) => AchievementResultModel.fromJson(x))
          .toList();
      totalCoins = resource.data["totalCoinsEarnedAllTime"].toString();
      totalLevels = resource.data["totalLevelsInGame"].toString();
      dailyCount = int.parse(resource.data["totalCoinsToday"].toString());
      weeklyCount  = int.parse(resource.data["totalCoinsThisWeek"].toString());
      monthlyCount = int.parse(resource.data["totalCoinsThisMonth"].toString());
      for (var item in resultList) {
        weeklyTime.add((item.totalTimePlayed?.toDouble())! / 60 ?? 0.0);
        weeklyProgress.add((item.totalCoinsEarned ?? 0.0).toDouble());
        weekDays.add((item.day.toString() ?? ""));
        totalTimeByWeek  = totalTimeByWeek+ (item.totalTimePlayed?.toDouble())!;
      }
      totalTimeByWeek = totalTimeByWeek/60;
      totalTimeByWeek = double.parse(totalTimeByWeek.toStringAsFixed(2));

      topThreeUserList = (resource.data['top3Users'] as List)
          .map((x) => TopThreeUserModel.fromJson(x))
          .toList();
      currentUserRank = int.parse(resource.data["userRank"].toString());
      findTopThreeUsers(topThreeUserList);

      animateBars();
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

  double getMaxY(List<double> allValues) {
    if (allValues.isEmpty) return 10;
    double maxVal = allValues.reduce((a, b) => a > b ? a : b);
    return (maxVal * 1.2).ceilToDouble(); // add 20% padding
  }

  void findTopThreeUsers(List<TopThreeUserModel> topThreeUserList) {
    // Sort by totalCoins in descending order
    topThreeUserList.sort((a, b) => (b.totalCoins ?? 0).compareTo(a.totalCoins ?? 0));

    // Access top 3 users safely
     firstUser = topThreeUserList.isNotEmpty ? topThreeUserList[0] : null;
     secondUser = topThreeUserList.length > 1 ? topThreeUserList[1] : null;
     thirdUser = topThreeUserList.length > 2 ? topThreeUserList[2] : null;

    // Print top 3 users and their coin counts
    print('🥇 First: ${firstUser?.name ?? "N/A"} with ${firstUser?.totalCoins ?? 0} coins');
    print('🥈 Second: ${secondUser?.name ?? "N/A"} with ${secondUser?.totalCoins ?? 0} coins');
    print('🥉 Third: ${thirdUser?.name ?? "N/A"} with ${thirdUser?.totalCoins ?? 0} coins');
  }
}
