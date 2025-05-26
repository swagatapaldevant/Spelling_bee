import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/constants/app_colors.dart';
import 'package:spelling_bee/core/utils/helper/screen_utils.dart';
import 'package:flutter/animation.dart';

class AnimatedGameItem extends StatefulWidget {
  final int index;
  final VoidCallback? onTap;
  final String gameName;

  const AnimatedGameItem({
    super.key,
    required this.index,
    this.onTap, required this.gameName,
  });

  @override
  State<AnimatedGameItem> createState() => _AnimatedGameItemState();
}

class _AnimatedGameItemState extends State<AnimatedGameItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: -10.0), weight: 1),
      TweenSequenceItem(
          tween: Tween<double>(begin: -10.0, end: 0.0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = _getGameColor(widget.index);
    final screenWidth = ScreenUtils().screenWidth(context);
    final isSmallScreen = screenWidth < 400;

    return MouseRegion(
      onEnter: (_) => setState(() {
        _isHovering = true;
        _controller.forward();
      }),
      onExit: (_) => setState(() {
        _isHovering = false;
        _controller.reverse();
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..scale(_scaleAnimation.value)
                ..translate(0.0, _bounceAnimation.value),
              child: child,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.8),
                  color.withOpacity(0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.6),
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: const Offset(-2, -2),
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 2,
              ),
            ),
            child: Stack(
              children: [
                // Decorative elements
                Positioned(
                  top: -10,
                  right: -10,
                  child: Icon(
                    Icons.star,
                    color: Colors.white.withOpacity(0.3),
                    size: 40,
                  ),
                ),

                // Main content
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Animated character image
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.9),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.4),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        widget.index%2 == 0?
                        "assets/images/level_1.png":"assets/images/level_2.png",
                        width: ScreenUtils().screenWidth(context)*0.3,
                        height: isSmallScreen ? ScreenUtils().screenHeight(context)*0.07 : ScreenUtils().screenHeight(context)*0.1,
                      ),
                    ),

                    // Game title with cute font
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.gameName,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 20,
                          fontWeight: FontWeight.w800,
                          fontFamily: "comic_neue", // Use a fun font
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            )
                          ],
                        ),
                      ),
                    ),

                    // Progress stars
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: LinearProgressIndicator(
                        value: (widget.index % 5) / 4, // Example progress
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.white),
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 6,
                      ),
                    ),

                    // Play button
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _isHovering
                            ? Colors.white
                            : Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'PLAY NOW',
                        style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                            fontWeight: FontWeight.bold,
                            color: color,
                            letterSpacing: 1,
                            fontFamily: "comic_neue"),
                      ),
                    ),
                  ],
                ),

                // Difficulty badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(widget.index),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _getDifficultyLevel(widget.index),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getGameColor(int index) {
    final colors = [
      const Color(0xFF8A012F), // Pink
      const Color(0xFF015C85), // Blue
      const Color(0xFF8C6B01), // Yellow
      const Color(0xFF008106), // Green
      const Color(0xFF6A027C), // Purple
      const Color(0xFF701B00), // Orange
    ];
    return colors[index % colors.length];
  }

  // String _getGameTitle(int index) {
  //   final titles = [
  //     "Alphabet Adventure",
  //     "Word Wizardry",
  //     "Letter Magic",
  //     "Spelling Safari",
  //     "Phonics Fun",
  //     "Reading Race",
  //     "Vocabulary Voyage",
  //     "Sound Puzzles",
  //     "Word Builder",
  //     "Letter Party",
  //   ];
  //   return titles[index % titles.length];
  // }

  Color _getDifficultyColor(int index) {
    switch (index % 3) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  String _getDifficultyLevel(int index) {
    switch (index % 3) {
      case 0:
        return 'EASY';
      case 1:
        return 'MEDIUM';
      case 2:
        return 'HARD';
      default:
        return 'NEW';
    }
  }
}
