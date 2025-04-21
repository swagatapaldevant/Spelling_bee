import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spelling_bee/features/auth/screens/signup_screen.dart';
import 'package:spelling_bee/features/child_dashboard/screens/bottom_nav_bar.dart';
import 'package:spelling_bee/features/child_dashboard/screens/child_dashboard_screen.dart';
import 'package:spelling_bee/features/exploreAndPlay/screens/explore_and_play_alphabet_screen.dart';
import 'package:spelling_bee/features/exploreAndPlay/screens/explore_and_play_number_screen.dart';
import 'package:spelling_bee/features/exploreAndPlay/screens/vowel_game/vowel_details_screen.dart';
import 'package:spelling_bee/features/splash/overview_screen.dart';
import 'package:spelling_bee/features/splash/wellcome_screen.dart';

import '../../../features/auth/screens/login_screen.dart';
import '../../../features/auth/screens/parent_concern_screen.dart';
import '../../../features/exploreAndPlay/screens/learning_game_button_navbar.dart';
import '../../../features/splash/splash_screen.dart';
import '../../utils/helper/app_fontSize.dart';

class RouteGenerator{

  // general navigation
  static const kSplash = "/";
  static const kWellcomeScreen = "/WellcomeScreen";
  static const kLoginScreen = "/LoginScreen";
  static const kBottomNavBar = "/BottomNavBar";
  static const kChildDashboardScreen = "/ChildDashboardScreen";
  static const kOverviewScreen = "/OverviewScreen";
  static const kSignupScreen = "/SignupScreen";
  static const kParentConcernScreen = "/ParentConcernScreen";
  static const kExploreAndPlayScreen = "/ExploreAndPlayScreen";
  static const kExploreAndPlayNumberScreen = "/ExploreAndPlayNumberScreen";
  //static const kMatchTheLetterGame = "/MatchTheLetterGame";
  //static const kAllBengaliLetterScreen = "/AllBengaliLetterScreen";
  static const kVowelDetailsScreen = "/VowelDetailsScreen";
  static const kLearningGameButtonNavbar = "/LearningGameButtonNavbar";






  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;
    switch(settings.name){

      case kSplash:
        //return MaterialPageRoute(builder: (_)=>SplashScreen());
        return _animatedPageRoute(SplashScreen());
     case kWellcomeScreen:
        return _animatedPageRoute(WellcomeScreen());
     case kLoginScreen:
        return _animatedPageRoute(LoginScreen());
     case kBottomNavBar:
        return _animatedPageRoute(BottomNavBar());
     case kChildDashboardScreen:
        return _animatedPageRoute(ChildDashboardScreen());
     case kOverviewScreen:
        return _animatedPageRoute(OverviewScreen());
     case kSignupScreen:
        return _animatedPageRoute(SignupScreen());
      case kParentConcernScreen:
        return _animatedPageRoute(ParentConcernScreen());
     case kExploreAndPlayScreen:
        return _animatedPageRoute(ExploreAndPlayScreen());
     case kExploreAndPlayNumberScreen:
        return _animatedPageRoute(ExploreAndPlayNumberScreen());
     // case kMatchTheLetterGame:
     //    return _animatedPageRoute(MatchTheLetterGame());
     // case kAllBengaliLetterScreen:
     //    return _animatedPageRoute(AllBengaliLetterScreen(
     //     // letter: args as List<String>,
     //    ));
      case kVowelDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _animatedPageRoute(
          VowelDetailsScreen(
            initialIndex: args["index"] as int,
            letterList: List<String>.from(args["letterList"]),
          ),
        );

      case kLearningGameButtonNavbar:
        return _animatedPageRoute(LearningGameButtonNavbar(index: args as int,));


      default:
        return _errorRoute(errorMessage: "Route not found: ${settings.name}");

    }

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




  static Route<dynamic> _errorRoute(
      {
        String errorMessage = '',
      }
      ) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Error",
            style: Theme.of(_)
                .textTheme
                .displayMedium
                ?.copyWith(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                "Oops something went wrong",
                style: Theme.of(_).textTheme.displayMedium?.copyWith(
                    fontSize: AppFontSize.textExtraLarge,
                    color: Colors.black),
              ),
              Text(
                errorMessage,
                style: Theme.of(_).textTheme.displayMedium?.copyWith(
                    fontSize: AppFontSize.textExtraLarge,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      );
    });
  }
}