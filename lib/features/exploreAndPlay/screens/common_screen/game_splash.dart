// import 'package:flutter/material.dart';
// import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
//
// import '../../../../core/utils/constants/app_colors.dart';
// import '../../../../core/utils/helper/screen_utils.dart';
//
// class GameSplash extends StatefulWidget {
//   final String content;
//   final int index;
//   const GameSplash({super.key, required this.content, required this.index});
//
//   @override
//   State<GameSplash> createState() => _GameSplashState();
// }
//
// class _GameSplashState extends State<GameSplash> {
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 1), () {
//       widget.index == 1?Navigator.pushReplacementNamed(context,'/AllBengaliVowelScreen'):
//       widget.index == 2? Navigator.pushReplacementNamed(context,'/AllConsonantScreen'):
//       widget.index == 3? Navigator.pushReplacementNamed(context,'/AllNumericScreen'):
//       Navigator.pushReplacementNamed(context,'/AllBengaliVowelScreen');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     AppDimensions.init(context);
//     return Scaffold(
//       backgroundColor: AppColors.parentConcernBg,
//       body: Stack(
//         children: [
//           Image.asset(
//             "assets/images/alphabet/alphabet_details_bg.jpeg",
//             height: ScreenUtils().screenHeight(context),
//             width: ScreenUtils().screenWidth(context),
//             fit: BoxFit.cover,
//           ),
//           Container(
//               height: ScreenUtils().screenHeight(context),
//               width: ScreenUtils().screenWidth(context),
//               //color: AppColors.white.withOpacity(0.5),
//               color: AppColors.colorBlack.withOpacity(0.5),
//               child: SafeArea(
//                   child:Center(
//                     child: Text(
//                       widget.content,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: AppColors.white,
//                         fontFamily: "comic_neue",
//                         fontSize: 30,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//
//               )
//
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:flutter/animation.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class GameSplash extends StatefulWidget {
  final String content;
  final int index;
  const GameSplash({super.key, required this.content, required this.index});

  @override
  State<GameSplash> createState() => _GameSplashState();
}

class _GameSplashState extends State<GameSplash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  List<bool> _letterVisibility = [];
  int _visibleLetters = 0;

  @override
  void initState() {
    super.initState();

    // Initialize letter visibility
    _letterVisibility = List<bool>.filled(widget.content.length, false);

    // Set up animations
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Start animations
    _controller.forward();

    // Animate letters one by one
    _animateLetters();

    // Navigate after delay
    Future.delayed(Duration(seconds: 3), () {
      widget.index == 1? Navigator.pushReplacementNamed(context,'/AllBengaliVowelScreen'):
      widget.index == 2? Navigator.pushReplacementNamed(context,'/AllConsonantScreen'):
      widget.index == 3? Navigator.pushReplacementNamed(context,'/AllNumericScreen'):
      Navigator.pushReplacementNamed(context,'/AllBengaliVowelScreen');
    });
  }

  void _animateLetters() {
    Future.doWhile(() async {
      if (_visibleLetters < widget.content.length) {
        await Future.delayed(Duration(milliseconds: 150));
        setState(() {
          _letterVisibility[_visibleLetters] = true;
          _visibleLetters++;
        });
        return true;
      }
      return false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);

    return Scaffold(
      backgroundColor: AppColors.parentConcernBg,
      body: Stack(
        children: [
          // Background image
          Image.asset(
            "assets/images/alphabet/alphabet_details_bg.jpeg",
            height: ScreenUtils().screenHeight(context),
            width: ScreenUtils().screenWidth(context),
            fit: BoxFit.cover,
          ),

          // Overlay
          Container(
            height: ScreenUtils().screenHeight(context),
            width: ScreenUtils().screenWidth(context),
            color: AppColors.colorBlack.withOpacity(0.5),
            child: SafeArea(
              child: Center(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.content.split('').asMap().entries.map((entry) {
                            int idx = entry.key;
                            String letter = entry.value;

                            return AnimatedOpacity(
                              opacity: _letterVisibility[idx] ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                              child: AnimatedPadding(
                                padding: EdgeInsets.only(
                                  top: _letterVisibility[idx] ? 0 : 20.0,
                                ),
                                duration: Duration(milliseconds: 300),
                                child: Text(
                                  letter,
                                  style: TextStyle(
                                    color: _getLetterColor(idx),
                                    fontFamily: "comic_neue",
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 4.0,
                                        color: Colors.black.withOpacity(0.5), // Dark shadow for contrast
                                        offset: Offset(1.0, 1.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        // Progress indicator (child-friendly)
                        SizedBox(height: 30),
                        SizedBox(
                          width: 200,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                            minHeight: 10,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        // Playful decoration
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildAnimatedIcon(Icons.star, 0),
                            _buildAnimatedIcon(Icons.favorite, 200),
                            _buildAnimatedIcon(Icons.celebration, 400),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Color _getLetterColor(int index) {
    final colors = [
      Colors.yellow.shade300,  // Bright pastel yellow
      Colors.pink.shade300,    // Soft pink
      Colors.cyan.shade300,    // Bright cyan
      Colors.green.shade300,   // Lime green
      Colors.orange.shade300,  // Bright orange
      Colors.purple.shade300,  // Light purple
      Colors.red.shade300,     // Coral red
      Colors.blue.shade300,    // Sky blue
    ];
    return colors[index % colors.length];
  }

  Widget _buildAnimatedIcon(IconData icon, int delay) {
    return AnimatedOpacity(
      opacity: _visibleLetters >= widget.content.length ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _visibleLetters >= widget.content.length
                ? 1.0 + 0.2 * sin(_controller.value * 2 * 3.14)
                : 1.0,
            child: Icon(
              icon,
              color: _getLetterColor(delay ~/ 200),
              size: 40,
            ),
          );
        },
      ),
    );
  }
}