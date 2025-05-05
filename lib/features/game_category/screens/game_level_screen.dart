import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/game_category/models/game_list_model.dart';

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
  // late Animation<double> _bounceAnimation;

  final GameCategoryUsecase _gameCategoryUsecase = getIt<GameCategoryUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  bool isLoading = false;
  List<GameLevelModel> gameLevelList = [];

  final List<Level> levels = List.generate(
      20,
      (index) => Level(
            number: index + 1,
            isLocked: index > 4,
            stars: index % 3,
            themeColor: LinearGradient(
              colors: [
                Colors.primaries[index % Colors.primaries.length].shade300,
                Colors
                    .primaries[(index + 3) % Colors.primaries.length].shade600,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
          milliseconds: 10000), // Slower for full-screen movement
      vsync: this,
    )..repeat();
    listOfGameLevel();
    // _bounceAnimation = Tween<double>(begin: -10, end: 10).animate(
    //   CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/alphabet/alphabet_details_bg.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
              ),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: FullScreenCloudPainter(_controller.value),
                    size: Size.infinite,
                  );
                },
              ),
            ),
          ),

          // Content
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

                // Progress indicator
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
                      const Text(
                        '45/90 Stars Collected',
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
                          'Level 5',
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

                // Zigzag level list
                isLoading? CircularProgressIndicator(
                  color: AppColors.white,
                ):
                gameLevelList.isEmpty
                    ? Text(
                        "No levels are added till Now",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          //color: isLocked ? Colors.grey[800] : Colors.black,
                          color: Colors.white,
                          fontFamily: "comic_neue",
                          shadows:
                              [
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
                                  ScreenUtils().screenHeight(context) * 0.03),
                          child: AnimatedListView(
                            itemCount: gameLevelList.length,
                            itemBuilder: (context, index) {
                              final isRightAligned = index % 2 == 0;
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: isRightAligned ? 0 : 40,
                                  right: isRightAligned ? 40 : 0,
                                  bottom: 20,
                                ),
                                child: LevelButton(
                                  levelNumber: gameLevelList[index].levelNumber.toString(),
                                  isRightAligned: isRightAligned,
                                  onPressed: (){

                                    gameLevelList[index].levelNumber.toString() == "1"?
                                    Navigator.pushReplacementNamed(context, '/GamePlayScreen'):
                                    Navigator.pushReplacementNamed(context, '/GamePlayScreenOne')

                                    ;



                                  }, difficultyLevel: gameLevelList[index].difficulty.toString(),
                                ),
                              );
                            },
                            // Custom animation parameters
                            horizontalOffset: 150.0,
                            duration: Duration(milliseconds: 800),
                            curve: Curves.elasticOut,
                            // ListView customization
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.all(20),
                            physics: BouncingScrollPhysics(),
                          )


                          // ListView.builder(
                          //   physics: BouncingScrollPhysics(),
                          //   itemCount: gameLevelList.length,
                          //   itemBuilder: (context, index) {
                          //     final isRightAligned = index % 2 == 0;
                          //     final level = gameLevelList[index];
                          //
                          //     return Padding(
                          //       padding: EdgeInsets.only(
                          //         left: isRightAligned ? 0 : 40,
                          //         right: isRightAligned ? 40 : 0,
                          //         bottom: 20,
                          //       ),
                          //       child: LevelButton(
                          //         isRightAligned: isRightAligned,
                          //         onPressed: () {
                          //           // if (!level.isLocked) {
                          //           //   _playBubbleSound();
                          //           //   // Navigate to level
                          //           // }
                          //         },
                          //         levelNumber: gameLevelList[index]
                          //             .levelNumber
                          //             .toString(),
                          //       ),
                          //     );
                          //   },
                          // ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _playBubbleSound() {
    // Play sound effect
  }

  listOfGameLevel() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {};

    Resource resource = await _gameCategoryUsecase.gameLevelByEachGame(
        requestData: requestData, id: widget.gameDetails.sId.toString());

    if (resource.status == STATUS.SUCCESS) {
      gameLevelList = (resource.data as List)
          .map((x) => GameLevelModel.fromJson(x))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      CommonUtils().flutterSnackBar(
          context: context, mes: resource.message ?? "", messageType: 4);
    }
  }
}

class Level {
  final int number;
  final bool isLocked;
  final int stars;
  final Gradient themeColor;

  Level({
    required this.number,
    required this.isLocked,
    required this.stars,
    required this.themeColor,
  });
}
