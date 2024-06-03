import 'package:flutter/material.dart';
import './entername.dart';

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
      home: EnterNamePage(), // Set MainMenuScreen as the home screen
    );
  }
}
