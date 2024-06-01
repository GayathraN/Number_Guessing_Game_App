import 'package:flutter/material.dart';
import './home.dart';  // Import the MainMenuScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guessing Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainMenuScreen(), // Set MainMenuScreen as the home screen
    );
  }
}
