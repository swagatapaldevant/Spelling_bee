import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/achievements/widgets/achievement_screen_header.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  final int totalCoins = 3400;

  final int totalLevels = 24;

  final List<double> weeklyTime = [
    4,
    5,
    3.5,
    6,
    5,
    10,
    9,
  ];
  // In minutes
  final List<String> weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  List<double> weekValue = List.filled(7, 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animateBars();
  }

  void animateBars() async {
    for (int i = 0; i < weeklyTime.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        weekValue[i] = weeklyTime[i];
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
            child: ListView(
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
                        SizedBox(height: AppDimensions.screenHeight * 0.02),
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: BarChart(
                            BarChartData(
                              maxY: 12,
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
                                        padding:
                                            const EdgeInsets.only(top: 6.0),
                                        child: Text(
                                          weekDays[value.toInt()],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "comic_neue",
                                              color: AppColors.colorBlack),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),
                              gridData: FlGridData(
                                show: false,
                                drawHorizontalLine: true,
                                getDrawingHorizontalLine: (value) => FlLine(
                                  color: Colors.grey.withOpacity(0.2),
                                  strokeWidth: 1,
                                ),
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: const Border(
                                  bottom: BorderSide(color: Colors.black12),
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

                SizedBox(height: 24),
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
}
