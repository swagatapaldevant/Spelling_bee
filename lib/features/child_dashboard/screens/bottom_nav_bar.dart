import 'package:flutter/material.dart';

import '../../../core/utils/commonWidgets/custom_buttom_navigation.dart';
import 'child_dashboard_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int selectedIndex = 0;

  final List<Widget> _pages = [

    ChildDashboardScreen(),
    Center(child: Text('Game Page')),
    Center(child: Text('Achievement Page')),
    Center(child: Text('Profile Page')),

  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
