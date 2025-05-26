import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:lottie/lottie.dart';
import 'package:spelling_bee/core/network/apiHelper/api_endpoint.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/game_category/models/game_level_track_model.dart';
import 'package:spelling_bee/features/game_category/models/game_list_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/network/apiHelper/locator.dart';
import '../../../core/network/apiHelper/resource.dart';
import '../../../core/network/apiHelper/status.dart';
import '../../../core/services/localStorage/shared_pref.dart';
import '../../../core/utils/commonWidgets/custom_animated_listview.dart';
import '../../../core/utils/helper/common_utils.dart';
import '../data/game_category_usecase.dart';
import '../models/game_level_model.dart';
import '../widgets/cloud_painter.dart';
import '../widgets/level_button.dart';

class GameLevelScreen extends StatefulWidget {
  final GameListModel gameDetails;

  const GameLevelScreen({super.key, required this.gameDetails});

  @override
  State<GameLevelScreen> createState() => _GameLevelScreenState();
}

class _GameLevelScreenState extends State<GameLevelScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final GameCategoryUsecase _gameCategoryUsecase = getIt<GameCategoryUsecase>();
  final SharedPref _pref = getIt<SharedPref>();

  final ScrollController _scrollController = ScrollController();
  bool isAtBottom = false;

  bool isLoading = false;
  List<GameLevelModel> gameLevelList = [];
  List<GameLevelTrackModel> gameTrackingDetails = [];
  String totalCollectedPoints = "";
  int totalPoints = 0;
  List<int> unlockedIndex = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    )..repeat();

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      const threshold = 50.0;

      if ((maxScroll - currentScroll) < threshold && !isAtBottom) {
        setState(() => isAtBottom = true);
      } else if ((maxScroll - currentScroll) >= threshold && isAtBottom) {
        setState(() => isAtBottom = false);
      }
    });

    listOfGameLevel();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              ApiEndPoint.domain +
                  widget.gameDetails.backgroundImage.toString(),
              fit: BoxFit.cover,
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: FullScreenCloudPainter(_controller.value),
                size: Size.infinite,
              );
            },
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtils().screenHeight(context) * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/profile/star_icon.png',
                          width: 30),
                      const SizedBox(width: 10),
                      Text(
                        widget.gameDetails.gameName.toString(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "comic_neue",
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image.asset('assets/images/profile/star_icon.png',
                          width: 30),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(
                        ScreenUtils().screenWidth(context) * 0.05),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 30),
                      const SizedBox(width: 8),
                      Text(
                        '$totalCollectedPoints/$totalPoints Stars Collected',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "comic_neue",
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Colors.yellow, Colors.orange]),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          'Level ${gameTrackingDetails.length}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.dashboardContainerBackgroundColor,
                            fontFamily: "comic_neue",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isLoading
                    ? const CircularProgressIndicator(color: AppColors.white)
                    : gameLevelList.isEmpty
                        ? Text(
                            "No levels are added till Now",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: "comic_neue",
                              shadows: [
                                Shadow(
                                  blurRadius: 5.0,
                                  color: Colors.black.withOpacity(0.8),
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    ScreenUtils().screenHeight(context) * 0.03,
                              ),
                              child: AnimatedListView(
                                controller: _scrollController,
                                itemCount: gameLevelList.length,
                                itemBuilder: (context, index) {
                                  final isRightAligned = index % 2 == 0;
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      left: isRightAligned ? 0 : 40,
                                      right: isRightAligned ? 40 : 0,
                                      bottom: 20,
                                    ),
                                    child: Stack(
                                      children: [
                                        LevelButton(
                                          levelNumber: gameLevelList[index]
                                              .levelNumber
                                              .toString(),
                                          isRightAligned: isRightAligned,
                                          difficultyLevel: gameLevelList[index]
                                              .difficulty
                                              .toString(),
                                          onPressed: () {
                                            String level = gameLevelList[index]
                                                .levelNumber
                                                .toString();
                                            Navigator.pushReplacementNamed(
                                                context, '/GamePlayScreen',
                                                arguments: {
                                                  "gameDetails":
                                                      widget.gameDetails,
                                                  "levelId":
                                                      gameLevelList[index].sId,
                                                  "gamePoint": int.parse(
                                                      gameLevelList[index]
                                                          .point
                                                          .toString())
                                                });
                                          },
                                          point: gameLevelList[index]
                                              .point
                                              .toString(),
                                        ),
                                        _lockContainer(context, isRightAligned,
                                            index == 1 ? false : true)
                                        //_lockContainer(context, isRightAligned, unlockedIndex[index] == index?false:true)
                                      ],
                                    ),
                                  );
                                },
                                horizontalOffset: 150.0,
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.elasticOut,
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.all(20),
                                physics: const BouncingScrollPhysics(),
                              ),
                            ),
                          ),
              ],
            ),
          ),

          /// Lottie Scroll Arrow
          if (gameLevelList.isNotEmpty)
            Positioned(
              bottom: ScreenUtils().screenHeight(context) * 0.13,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  final targetOffset = isAtBottom
                      ? 0.0
                      : _scrollController.position.maxScrollExtent;
                  _scrollController.animateTo(
                    targetOffset,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOut,
                  );
                },
                child: Lottie.asset(
                  isAtBottom
                      ? 'assets/images/animations/up_arrow.json'
                      : 'assets/images/animations/down_arrow.json',
                  height: ScreenUtils().screenHeight(context) * 0.1,
                  width: ScreenUtils().screenWidth(context),
                  repeat: true,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _playBubbleSound() {
    // Add sound play logic here
  }

  Widget _lockContainer(context, bool isRightAligned, bool isVisible) {
    return Visibility(
      visible: isVisible,
      child: Bounceable(
        onTap: () {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message:
                  "Please complete previous level to continue current level",
            ),
          );
        },
        child: Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(30),
                bottomRight: const Radius.circular(30),
                topRight:
                    isRightAligned ? const Radius.circular(30) : Radius.zero,
                bottomLeft:
                    isRightAligned ? Radius.zero : const Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.white.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              // border: Border.all(
              //   color: Colors.white.withOpacity(0.8),
              //   width: 2,
              // )
            ),
            child: Align(
                alignment:
                    isRightAligned ? Alignment.topLeft : Alignment.topRight,
                child: Padding(
                  padding:
                      EdgeInsets.all(ScreenUtils().screenWidth(context) * 0.05),
                  child: Icon(
                    Icons.lock,
                    color: AppColors.white,
                    size: 30,
                  ),
                ))),
      ),
    );
  }

  Future<void> listOfGameLevel() async {
    setState(() => isLoading = true);

    String? userId = await _pref.getChildId();

    Map<String, dynamic> requestData = {};
    Resource resource = await _gameCategoryUsecase.gameLevelByEachGame(
      requestData: requestData,
      id: widget.gameDetails.sId.toString(),
      childId: userId.toString(),
    );

    if (resource.status == STATUS.SUCCESS) {
      gameLevelList = (resource.data['levels'] as List)
          .map((x) => GameLevelModel.fromJson(x))
          .toList();
      gameTrackingDetails = (resource.data['track'] as List)
          .map((x) => GameLevelTrackModel.fromJson(x))
          .toList();
      totalCollectedPoints = resource.data['total_collected_points'].toString();

      for (int i = 0; i < gameLevelList.length; i++) {
        totalPoints =
            totalPoints + int.parse(gameLevelList[i].point.toString());
      }

      // for(int i = 0 ; i<gameLevelList.length;i++)
      //   {
      //     if(gameLevelList[i].sId.toString() == gameTrackingDetails[i].sId.toString())
      //       {
      //         double p1 = int.parse(gameLevelList[i].point.toString()) as double;
      //         double p2 = int.parse(gameTrackingDetails[i].collectedPoints.toString()) as double;
      //         if(((p1/p2)*100)>50)
      //           {
      //             unlockedIndex.add(i);
      //           }
      //
      //       }
      //   }
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
