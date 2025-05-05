import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/game_category/widgets/shake_animation.dart';

import '../screens/game_level_screen.dart';

class LevelButton extends StatelessWidget {
  //final Level level;
  final bool isRightAligned;
  final VoidCallback onPressed;
  final String levelNumber;
  final String difficultyLevel;

  const LevelButton({
    super.key,
    //required this.level,
    required this.isRightAligned,
    required this.onPressed,
    required this.levelNumber, required this.difficultyLevel
  });

  @override
  Widget build(BuildContext context) {
   // final isLocked = level.isLocked;
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: isRightAligned ? Alignment.topLeft : Alignment.topRight,
              end:
              isRightAligned ? Alignment.bottomRight : Alignment.bottomLeft,
              colors: [
                Color(0xFFC4DBDE),
                Color(0xFF4FC9D9),
                Color(0xFF1BBCD2),
              ]),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(30),
            bottomRight: const Radius.circular(30),
            topRight: isRightAligned ? const Radius.circular(30) : Radius.zero,
            bottomLeft:
            isRightAligned ? Radius.zero : const Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.8),
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            // Background pattern for unlocked levels
           // if (!isLocked) ...[
              Positioned(
                top: 10,
                right: isRightAligned ? null : 10,
                left: isRightAligned ? 10 : null,
                child: Icon(
                  Icons.star,
                  color: Colors.white.withOpacity(0.3),
                  size: 40,
                ),
              ),
           // ],

            // Level image
           // if (!isLocked) ...[
              Positioned(
                top: 10,
                right: isRightAligned ? 10 : null,
                left: isRightAligned ? null : 10,
                child: Image.asset(
                  "assets/images/signup_cn.png",
                  width: 60,
                  height: 60,
                ),
              ),
          //  ],

            // Cloud overlay for locked levels
           // if (isLocked) ...[
           //    Positioned.fill(
           //      child: ClipRRect(
           //        borderRadius: BorderRadius.only(
           //          topLeft: const Radius.circular(30),
           //          bottomRight: const Radius.circular(30),
           //          topRight: isRightAligned
           //              ? const Radius.circular(30)
           //              : Radius.zero,
           //          bottomLeft: isRightAligned
           //              ? Radius.zero
           //              : const Radius.circular(30),
           //        ),
           //        child: Image.asset(
           //          'assets/images/game_category/cloud.png',
           //          fit: BoxFit.cover,
           //          opacity: const AlwaysStoppedAnimation(0.7),
           //        ),
           //      ),
           //    ),
           // ],

            // Main content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      //color: Colors.white.withOpacity(isLocked ? 0.3 : 0.5),
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 2,
                      ),
                    ),
                    child: Text(
                      "Level $levelNumber",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        //color: isLocked ? Colors.grey[800] : Colors.black,
                        color: Colors.black,
                        fontFamily: "comic_neue",
                        shadows:
                        // isLocked
                        //     ? null
                        //     :
                        [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.white.withOpacity(0.8),
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //if (!isLocked) ...[
                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                              (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Icon(
                              // index < level.stars
                              //     ? Icons.star
                              //     :
                              Icons.star_outline,
                              color: Colors.yellow,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
               // ],
              ),
            ),

            Positioned(
              bottom: 0,
              left:isRightAligned?ScreenUtils().screenWidth(context)*0.05:ScreenUtils().screenWidth(context)*0.4,
              child: Container(
                decoration: BoxDecoration(
                    color:difficultyLevel == "easy"? Colors.green:
                    difficultyLevel == "medium"? Colors.orange:
                    Colors.red,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: ScreenUtils().screenWidth(context)*0.03),
                  child: Text(
                    difficultyLevel,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color:AppColors.white,
                      fontFamily: "comic_neue",
                      // shadows:
                      // [
                      //   Shadow(
                      //     blurRadius: 1.0,
                      //     color: Colors.black.withOpacity(0.1),
                      //     offset: Offset(2.0, 2.0),
                      //   ),
                      // ],
                    ),
                  ),
                ),
              ),
            ),


            // Lock icon for locked levels with animation
            // if (isLocked)
            //   Positioned(
            //     top: 10,
            //     right: 10,
            //     child: ShakeAnimation(
            //       child: Icon(
            //         Icons.lock,
            //         color: Colors.white,
            //         size: 30,
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
