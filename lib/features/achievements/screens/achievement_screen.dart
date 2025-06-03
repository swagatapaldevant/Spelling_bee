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
import 'package:spelling_bee/features/achievements/widgets/achievement_screen_header.dart';

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
                      SizedBox(height: AppDimensions.screenHeight * 0.02),

                      _buildStatCard(
                        emoji: "🎯",
                        label: "Levels Unlocked",
                        value: "$totalLevels / 130",
                        color: Colors.lightGreenAccent,
                      ),
                      SizedBox(height: AppDimensions.screenHeight * 0.02),

                      // Coins
                      _buildStatCard(
                        emoji: "🪙",
                        label: "Total Coins Earned",
                        value: "$totalCoins",
                        color: Colors.amberAccent,
                      ),
                      SizedBox(height: AppDimensions.screenHeight * 0.02),
                      Container(
                        width: ScreenUtils().screenWidth(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.gray7, width: 4),
                          //color: AppColors.rewardBg,
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
                              Text("“Daily Treasure Hunt!” 💰",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: "comic_neue",
                                          color: AppColors.colorBlack))
                                  .animate()
                                  .slideY(duration: 400.ms)
                                  .fadeIn(),
                              //SizedBox(height: AppDimensions.screenHeight * 0.02),
                              AspectRatio(
                                aspectRatio: 1.2,
                                child: BarChart(
                                  BarChartData(
                                    maxY: getMaxY(weeklyProgress),
                                    barGroups:
                                        List.generate(weekDays.length, (index) {
                                      return BarChartGroupData(
                                        x: index,
                                        barRods: [
                                          BarChartRodData(
                                            toY: weekValueProgress[index],
                                            width: 25,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(6),
                                                topLeft: Radius.circular(6)),
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFF6FD8),
                                                Color(0xFF3813C2),
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                        ],
                                        barsSpace: 0,
                                      );
                                    }),
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          // reservedSize: 32,
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
                                      drawHorizontalLine: true,
                                      getDrawingHorizontalLine: (value) =>
                                          FlLine(
                                        color: Colors.grey.withOpacity(0.2),
                                        strokeWidth: 1,
                                      ),
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
                                          return BarTooltipItem(
                                            rod.toY.toStringAsFixed(1),
                                            const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: AppDimensions.screenHeight * 0.02),

                      // Bar Chart
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
                              Text("🕒 Weekly Play Time",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: "comic_neue",
                                          color: AppColors.colorBlack))
                                  .animate()
                                  .slideY(duration: 400.ms)
                                  .fadeIn(),
                              //SizedBox(height: AppDimensions.screenHeight * 0.02),
                              AspectRatio(
                                aspectRatio: 1.2,
                                child: BarChart(
                                  BarChartData(
                                    maxY: getMaxY(weeklyTime),
                                    barGroups:
                                        List.generate(weekDays.length, (index) {
                                      return BarChartGroupData(
                                        x: index,
                                        barRods: [
                                          BarChartRodData(
                                            toY: weekValue[index],
                                            width: 25,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(6),
                                                topLeft: Radius.circular(6)),
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
                                        barsSpace: 0,
                                      );
                                    }),
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          // reservedSize: 32,
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
                                      drawHorizontalLine: true,
                                      getDrawingHorizontalLine: (value) =>
                                          FlLine(
                                        color: Colors.grey.withOpacity(0.2),
                                        strokeWidth: 1,
                                      ),
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
                                          return BarTooltipItem(
                                            rod.toY.toStringAsFixed(1),
                                            const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //.animate().fadeIn().slideY(begin: 0.3, duration: 600.ms),

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
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Text(emoji, style: TextStyle(fontSize: 36)),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: "comic_neue",
                        color: AppColors.colorBlack)),
                Text(value,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: "comic_neue",
                        color: AppColors.colorBlack)),
              ],
            ),
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
      for (var item in resultList) {
        weeklyTime.add(item.totalTimePlayed?.toDouble() ?? 0.0);
        weeklyProgress.add((item.totalCoinsEarned ?? 0.0).toDouble());
        weekDays.add((item.day.toString() ?? ""));
      }
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
}
