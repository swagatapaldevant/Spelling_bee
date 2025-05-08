import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';

class AnimatedEarnedCoinsText extends StatefulWidget {
  const AnimatedEarnedCoinsText({super.key});

  @override
  _AnimatedEarnedCoinsTextState createState() => _AnimatedEarnedCoinsTextState();
}

class _AnimatedEarnedCoinsTextState extends State<AnimatedEarnedCoinsText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeIn)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.colorBlack,
borderRadius: BorderRadius.only(
  topRight: Radius.circular(10),
  bottomLeft: Radius.circular(10),
)
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(
                horizontal:ScreenUtils().screenWidth(context)*0.05,
                vertical: ScreenUtils().screenWidth(context)*0.02
            ),
            child: Text(
              "Earned 5 Coins",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: "comic_neue",
                color: AppColors.colorGreen,
                shadows: [
                  Shadow(
                    blurRadius: 4.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
