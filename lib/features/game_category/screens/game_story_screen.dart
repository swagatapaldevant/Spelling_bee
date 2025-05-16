// import 'package:flutter/material.dart';
// import 'package:spelling_bee/core/utils/commonWidgets/common_button.dart';
// import 'package:spelling_bee/core/utils/constants/app_colors.dart';
// import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
// import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
// import 'package:spelling_bee/features/game_category/models/game_list_model.dart';
//
// class GameStoryScreen extends StatefulWidget {
//   final GameListModel gameDetails;
//   const GameStoryScreen({super.key, required this.gameDetails});
//
//   @override
//   State<GameStoryScreen> createState() => _GameStoryScreenState();
// }
//
// class _GameStoryScreenState extends State<GameStoryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     AppDimensions.init(context);
//     return Scaffold(
//         body: Stack(
//       children: [
//         Positioned.fill(
//           child: Image.asset(
//             height: ScreenUtils().screenHeight(context),
//             width: ScreenUtils().screenWidth(context),
//             widget.gameDetails.gameName == "Game 4"? 'assets/images/forest.jpeg':'assets/images/kitchen.jpg',
//             fit: BoxFit.cover,
//           ),
//         ),
//         SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(AppDimensions.screenPadding),
//             child: Container(
//               height: ScreenUtils().screenHeight(context)*0.4,
//               decoration: BoxDecoration(
//                 color: AppColors.gray3.withOpacity(0.7)
//               ),
//               child: Column(
//                 //mainAxisAlignment: MainAxisAlignment.center,
//                 //crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "🌟 Timi's Magical Word Quest 🌟",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: "comic_neue",
//                       color: AppColors.colorBlack.withOpacity(0.9),
//                     ),
//                   ),
//                   SizedBox(height: ScreenUtils().screenWidth(context) * 0.03),
//                   Text(
//                     "Join Timi the Tiger on a magical adventure through the enchanted forest! Discover fascinating animals, explore the wonders of nature, and help Timi protect the forest's magic.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: "comic_neue",
//                       color: AppColors.colorBlack.withOpacity(0.7),
//                     ),
//                   ),
//                   SizedBox(
//                     height: ScreenUtils().screenHeight(context) * 0.05,
//                   ),
//                   // Image.asset(
//                   //   "assets/images/boy.png",
//                   //   height: ScreenUtils().screenHeight(context) * 0.4,
//                   //   width: ScreenUtils().screenWidth(context) * 0.4,
//                   // ),
//                   SizedBox(
//                     height: ScreenUtils().screenHeight(context) * 0.01,
//                   ),
//                   CommonButton(
//                       onTap: () {
//                         Navigator.pushReplacementNamed(
//                             context, '/GameLevelScreen',
//                             arguments: widget.gameDetails);
//                       },
//                       height: ScreenUtils().screenHeight(context) * 0.05,
//                       width: ScreenUtils().screenWidth(context),
//                       buttonColor: AppColors().colorDarkBlue,
//                       buttonName: "LET'S PLAY ",
//                       buttonTextColor: AppColors.white.withOpacity(0.9),
//                       gradientColor1: AppColors().colorDarkBlue,
//                       gradientColor2: AppColors.colorSkyBlue300)
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/commonWidgets/common_button.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:spelling_bee/features/game_category/models/game_list_model.dart';

class GameStoryScreen extends StatefulWidget {
  final GameListModel gameDetails;
  const GameStoryScreen({super.key, required this.gameDetails});

  @override
  State<GameStoryScreen> createState() => _GameStoryScreenState();
}

class _GameStoryScreenState extends State<GameStoryScreen> {
  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    final screenHeight = ScreenUtils().screenHeight(context);
    final screenWidth = ScreenUtils().screenWidth(context);
    final backgroundImage = widget.gameDetails.gameName == "Game 4"
        ? 'assets/images/forest.jpeg'
        : 'assets/images/kitchen.jpg';

    return Scaffold(
      body: Stack(
        children: [
          // Full-screen background image
          Positioned.fill(
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay to ensure text readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Foreground content with safe area
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.screenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.gameDetails.gameName == "Game 4"?  "🌟 Timi's Magical Word Quest 🌟":"🌟 Timi's Kitchen 🌟",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: "comic_neue",
                            color: AppColors.colorBlack,
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.03),
                        Text(
                          widget.gameDetails.gameName == "Game 4"?
                          "Join Timi the Tiger on a magical adventure through the enchanted forest! Discover fascinating animals, explore the wonders of nature, and help Timi protect the forest's magic.":
                          "Join Timi the Tiger in a tasty kitchen quest to find secret ingredients and cook up magical recipes!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "comic_neue",
                            color: AppColors.colorBlack.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        CommonButton(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/GameLevelScreen',
                              arguments: widget.gameDetails,
                            );
                          },
                          height: screenHeight * 0.05,
                          width: screenWidth,
                          buttonColor: AppColors().colorDarkBlue,
                          buttonName: "LET'S PLAY ",
                          buttonTextColor: AppColors.white.withOpacity(0.9),
                          gradientColor1: AppColors().colorDarkBlue,
                          gradientColor2: AppColors.colorSkyBlue300,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
