import 'package:flutter/material.dart';

class GamePlayScreenOne extends StatefulWidget {
  const GamePlayScreenOne({super.key});

  @override
  State<GamePlayScreenOne> createState() => _GamePlayScreenOneState();
}

class _GamePlayScreenOneState extends State<GamePlayScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("label 2 game screen")),
    );
  }
}
