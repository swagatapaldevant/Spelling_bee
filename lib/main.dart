import 'package:flutter/material.dart';
import 'package:spelling_bee/core/services/routeGenerator/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spelling Bee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: RouteGenerator.navigatorKey,
      initialRoute: RouteGenerator.kSplash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}


