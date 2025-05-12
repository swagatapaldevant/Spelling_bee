
import 'package:flutter/material.dart';


class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});


  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("achievement screen")),
    );
  }
}