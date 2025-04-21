import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spelling_bee/features/child_dashboard/screens/bottom_nav_bar.dart';
import 'package:spelling_bee/features/exploreAndPlay/screens/vowel_game/all_vowel_screen.dart';
import 'package:spelling_bee/features/exploreAndPlay/screens/common_screen/match_letter_vowel_game.dart';
import 'package:spelling_bee/features/exploreAndPlay/screens/vowel_game/vowel_details_screen.dart';

import '../../../core/utils/commonWidgets/custom_buttom_navigation.dart';
import '../../../core/utils/commonWidgets/scrollable_custom_navigation.dart';
import 'consonant_game/all_consonant_screen.dart';
import 'consonant_game/consonant_details_screen.dart';
import 'match_numeric_game/all_numeric_screen.dart';
import 'match_numeric_game/numeric_details_screen.dart';
//
// class LearningGameButtonNavbar extends StatefulWidget {
//   const LearningGameButtonNavbar({super.key});
//
//   @override
//   State<LearningGameButtonNavbar> createState() => _LearningGameButtonNavbarState();
// }
//
// class _LearningGameButtonNavbarState extends State<LearningGameButtonNavbar> {
//   int selectedIndex = 1;
//
//   final List<Widget> _pages = [
//     Center(child: Text('Puzzle Page')),
//     MatchTheLetterGame(),
//     Center(child: Text('Teddy Page')),
//     Center(child: Text('Settings Page')),
//   ];
//
//   void _onItemTapped(int index) {
//     if(index == 0)
//       {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const BottomNavBar()),
//               (route) => false,
//         );
//
//       }
//     setState(() {
//       selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[selectedIndex],
//       bottomNavigationBar: ScrollableCustomNavigation(
//         selectedIndex: selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//     );
//   }
// }


class LearningGameButtonNavbar extends StatefulWidget {
  final int index;
  const LearningGameButtonNavbar({super.key, required this.index});

  @override
  State<LearningGameButtonNavbar> createState() => _LearningGameButtonNavbarState();
}

class _LearningGameButtonNavbarState extends State<LearningGameButtonNavbar> {
  int selectedIndex = 1;
  final GlobalKey<NavigatorState> vowelGameNavigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> consonantGameNavigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> numericGameNavigatorKey = GlobalKey<NavigatorState>();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
    _pages = [
      const Center(child: Text('Puzzle Page')),
      _buildVowelNavigator(),
      _buildConsonantNavigator(),
      _buildNumericNavigator(),
    ];
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
            (route) => false,
      );
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  void _openOverlayPage(Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withOpacity(0.2),
        pageBuilder: (_, __, ___) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // We use a Stack so the nav bar stays always visible
      body: Stack(
        children: [
          // Main page content
          Positioned.fill(child: _pages[selectedIndex]),

          // Fixed bottom navigation bar
          Align(
            alignment: Alignment.bottomCenter,
            child: ScrollableCustomNavigation(
              selectedIndex: selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.visibility),
      //   onPressed: () {
      //     _openOverlayPage(
      //       Scaffold(
      //         backgroundColor: Colors.white.withOpacity(0.9),
      //         body: Center(
      //           child: Text(
      //             'Overlay Content Here',
      //             style: TextStyle(fontSize: 24),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }


  Widget _buildVowelNavigator() {
    return Navigator(
      key: vowelGameNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return _animatedPageRoute(
              AllBengaliVowelScreen(
              ),
            );
          case '/VowelDetailsScreen':
            final args = settings.arguments as Map<String, dynamic>;
            return _animatedPageRoute(
              VowelDetailsScreen(
                initialIndex: args["index"] as int,
                letterList: List<String>.from(args["letterList"]),
              ),
            );

          case '/MatchLetterVowelGame':
            final args = settings.arguments as List<String>;
            return _animatedPageRoute(
              MatchLetterVowelGame(vowelList: args,
              ),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => AllBengaliVowelScreen(),
            );
        }
      },
    );
  }
  Widget _buildConsonantNavigator() {
    return Navigator(
      key: consonantGameNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return _animatedPageRoute(
              AllConsonantScreen(
              ),
            );
          case '/ConsonantDetailsScreen':
            final args = settings.arguments as Map<String, dynamic>;
            return _animatedPageRoute(
              ConsonantDetailsScreen(
                initialIndex: args["index"] as int,
                letterList: List<String>.from(args["letterList"]),
              ),
            );

          case '/MatchLetterVowelGame':
            final args = settings.arguments as List<String>;
            return _animatedPageRoute(
              MatchLetterVowelGame(vowelList: args,
              ),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => AllConsonantScreen(),
            );
        }
      },
    );
  }
  Widget _buildNumericNavigator() {
    return Navigator(
      key:numericGameNavigatorKey ,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return _animatedPageRoute(
              AllNumericScreen(
              ),
            );
          case '/NumericDetailsScreen':
            final args = settings.arguments as Map<String, dynamic>;
            return _animatedPageRoute(
              NumericDetailsScreen(
                initialIndex: args["index"] as int,
                letterList: List<String>.from(args["letterList"]),
              ),
            );

          case '/MatchLetterVowelGame':
            final args = settings.arguments as List<String>;
            return _animatedPageRoute(
              MatchLetterVowelGame(vowelList: args,
              ),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => AllConsonantScreen(),
            );
        }
      },
    );
  }

  static Route<dynamic> _animatedPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;  // The page to navigate to
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Define the transition animation

        // Slide from the right (Offset animation)
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final curve = Curves.easeInToLinear;  // A more natural easing curve

        var offsetTween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(offsetTween);

        // Scale transition (page zooms in slightly)
        var scaleTween = Tween(begin: 0.95, end: 1.0);
        var scaleAnimation = animation.drive(scaleTween);

        // Fade transition (opacity increases from 0 to 1)
        var fadeTween = Tween(begin: 0.0, end: 1.0);
        var fadeAnimation = animation.drive(fadeTween);

        // Return a combination of Slide, Fade, and Scale
        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Material(
                color: Colors.transparent,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Add blur effect
                  child: child,
                ),
              ),
            ),
          ),
        );

      },
    );
  }


}
