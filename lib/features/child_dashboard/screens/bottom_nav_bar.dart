import 'package:flutter/material.dart';
import 'package:spelling_bee/features/achievements/screens/achievement_screen.dart';
import 'package:spelling_bee/features/game_category/screens/game_category_screen.dart';

import '../../../core/utils/commonWidgets/custom_buttom_navigation.dart';
import '../../profile/screens/my_profile_screens.dart';
import 'child_dashboard_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    ChildDashboardScreen(),
    GameCategoryScreen(),
    Center(child: Text('Achievement Page')),
    MyProfileScreens(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static BottomNavBarState? of(BuildContext context) =>
      context.findAncestorStateOfType<BottomNavBarState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        onItemTapped: onItemTapped,
      ),
    );
  }
}
