import 'package:flutter/material.dart';
import 'package:praktikum8/constants.dart';
import 'package:praktikum8/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant App',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: kTextColor,
              displayColor: kTextColor,
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true, 
      ),
      home: const HomeScreen(),
    );
  }
}

