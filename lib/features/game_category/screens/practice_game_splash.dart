import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spelling_bee/features/game_category/models/game_list_model.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/helper/app_dimensions.dart';
import '../../../core/utils/helper/screen_utils.dart';

class PracticeGameSplash extends StatefulWidget {
  final String content;
  final int index;
  final GameListModel gameDetails;


  const PracticeGameSplash({
    super.key,
    required this.content,
    required this.index,
    required this.gameDetails,
  });

  @override
  State<PracticeGameSplash> createState() => _PracticeGameSplashState();
}

class _PracticeGameSplashState extends State<PracticeGameSplash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  List<bool> _letterVisibility = [];
  int _visibleLetters = 0;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _initLetters();
    _controller.forward();
    _animateLetters();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/GameLevelScreen', arguments: widget.gameDetails);
    });
  }


  void _initAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  void _initLetters() {
    _visibleLetters = 0;
    _letterVisibility = List<bool>.filled(widget.content.length, false);
  }

  void _animateLetters() {
    Future.doWhile(() async {
      if (!mounted) return false; // widget is no longer in tree
      if (_visibleLetters >= _letterVisibility.length) return false;

      await Future.delayed(const Duration(milliseconds: 150));

      if (!mounted) return false; // check again after delay
      if (_visibleLetters >= _letterVisibility.length) return false;

      setState(() {
        _letterVisibility[_visibleLetters] = true;
        _visibleLetters++;
      });

      return true;
    });
  }


  @override
  void didUpdateWidget(covariant PracticeGameSplash oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.content != widget.content) {
      _initLetters();
      _animateLetters();
    }
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
          Image.asset(
            "assets/images/alphabet/alphabet_details_bg.jpeg",
            height: ScreenUtils().screenHeight(context),
            width: ScreenUtils().screenWidth(context),
            fit: BoxFit.cover,
          ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.content.split('').asMap().entries.map((entry) {
                            int idx = entry.key;
                            String letter = entry.value;

                            return AnimatedOpacity(
                              opacity: idx < _letterVisibility.length && _letterVisibility[idx] ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                              child: AnimatedPadding(
                                padding: EdgeInsets.only(
                                  top: idx < _letterVisibility.length && _letterVisibility[idx] ? 0 : 20.0,
                                ),
                                duration: const Duration(milliseconds: 300),
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
                                        color: Colors.black.withOpacity(0.5),
                                        offset: const Offset(1.0, 1.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 200,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.yellow),
                            minHeight: 10,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 40),
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
      Colors.yellow.shade300,
      Colors.pink.shade300,
      Colors.cyan.shade300,
      Colors.green.shade300,
      Colors.orange.shade300,
      Colors.purple.shade300,
      Colors.red.shade300,
      Colors.blue.shade300,
    ];
    return colors[index % colors.length];
  }

  Widget _buildAnimatedIcon(IconData icon, int delay) {
    return AnimatedOpacity(
      opacity: _visibleLetters >= widget.content.length ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
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
