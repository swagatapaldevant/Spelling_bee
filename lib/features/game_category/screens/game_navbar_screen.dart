
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:spelling_bee/core/utils/helper/app_dimensions.dart';
import 'package:spelling_bee/core/utils/commonWidgets/scrollable_game_navigation.dart';
import 'package:spelling_bee/features/game_category/screens/game_play_screen.dart';
import 'package:spelling_bee/features/game_category/screens/game_play_screen_one.dart';
import 'package:spelling_bee/features/game_category/screens/practice_game_splash.dart';

import '../models/game_list_model.dart';
import 'game_level_screen.dart';

// class GamePlayScreen extends StatefulWidget {
//   final int? initialGameIndex;
//   final List<GameListModel> gameList;
//
//   const GamePlayScreen({
//     super.key,
//     required this.gameList,
//     this.initialGameIndex = 0,
//   });
//
//   @override
//   State<GamePlayScreen> createState() => _GamePlayScreenState();
// }
//
// class _GamePlayScreenState extends State<GamePlayScreen> {
//   late int selectedIndex = 0;
//   late List<UniqueKey> navigatorKeys;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedIndex = widget.initialGameIndex!;
//
//     // Unique keys to force full rebuilds
//     navigatorKeys = List.generate(widget.gameList.length, (_) => UniqueKey());
//   }
//
//   void _onItemTapped(int index) {
//     if (index != selectedIndex) {
//       setState(() {
//         // Replace the key with a new one to force full rebuild
//         navigatorKeys[index] = UniqueKey();
//         selectedIndex = index;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     AppDimensions.init(context);
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//           IndexedStack(
//             index: selectedIndex,
//             children: List.generate(widget.gameList.length, (index) {
//               return _buildGameNavigator(index, navigatorKeys[index]);
//             }),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: ScrollableGameNavigation(
//               onItemTapped: _onItemTapped,
//               navItems: widget.gameList,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildGameNavigator(int index, Key key) {
//     return KeyedSubtree(
//       key: key,
//       child: Navigator(
//         onGenerateRoute: (settings) {
//           Widget page;
//
//           switch (settings.name) {
//             case '/GameLevelScreen':
//               page = GameLevelScreen();
//               break;
//             case '/':
//             default:
//               page = PracticeGameSplash(
//                 content: widget.gameList[index].gameName.toString(),
//                 index: index,
//               );
//           }
//
//           return _animatedPageRoute(page);
//         },
//       ),
//     );
//   }
//
//   static Route<dynamic> _animatedPageRoute(Widget page) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => page,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0);
//         const end = Offset.zero;
//         final curve = Curves.easeInOut;
//
//         final offsetTween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//         final scaleTween = Tween(begin: 0.95, end: 1.0);
//         final fadeTween = Tween(begin: 0.0, end: 1.0);
//
//         return SlideTransition(
//           position: animation.drive(offsetTween),
//           child: FadeTransition(
//             opacity: animation.drive(fadeTween),
//             child: ScaleTransition(
//               scale: animation.drive(scaleTween),
//               child: Material(
//                 color: Colors.transparent,
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
//                   child: child,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class GamePlayNavbarScreen extends StatefulWidget {
  final int initialGameIndex;
  final List<GameListModel> gameList;

  const GamePlayNavbarScreen({
    super.key,
    required this.gameList,
    this.initialGameIndex = 0,
  });

  @override
  State<GamePlayNavbarScreen> createState() => _GamePlayNavbarScreenState();
}

class _GamePlayNavbarScreenState extends State<GamePlayNavbarScreen> {
  late int selectedIndex;
  late List<UniqueKey> navigatorKeys;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialGameIndex;
    navigatorKeys = List.generate(widget.gameList.length, (_) => UniqueKey());
  }

  void _onItemTapped(String gameId) {
    final index = widget.gameList.indexWhere((item) => item.sId == gameId);
    if (index != -1 && index != selectedIndex) {
      setState(() {
        navigatorKeys[index] = UniqueKey();
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          IndexedStack(
            index: selectedIndex,
            children: List.generate(widget.gameList.length, (index) {
              return _buildGameNavigator(index, navigatorKeys[index]);
            }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ScrollableGameNavigation(
              onItemTapped: _onItemTapped,
              navItems: widget.gameList,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameNavigator(int index, Key key) {
    return KeyedSubtree(
      key: key,
      child: Navigator(
        onGenerateRoute: (settings) {
          Widget page;
          switch (settings.name) {
            case '/GameLevelScreen':
              page = GameLevelScreen(
                gameDetails: widget.gameList[index],
              );
              break;

              case '/GamePlayScreen':
              page = ActualGamePlayScreen(

              );
              break;

             case '/GamePlayScreenOne':
                          page = GamePlayScreenOne(

                          );
                          break;

            case '/':
            default:
              page = PracticeGameSplash(
                content: widget.gameList[index].gameName.toString(),
                index: index, 
                gameDetails: widget.gameList[index],
              );
          }

          return _animatedPageRoute(page);
        },
      ),
    );
  }

  static Route<dynamic> _animatedPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final curve = Curves.easeInOut;

        return SlideTransition(
          position: animation.drive(
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve)),
          ),
          child: FadeTransition(
            opacity: animation.drive(Tween(begin: 0.0, end: 1.0)),
            child: ScaleTransition(
              scale: animation.drive(Tween(begin: 0.95, end: 1.0)),
              child: Material(
                color: Colors.transparent,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
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