import 'package:flutter/material.dart';
import 'home.dart';

class InstructionsPage extends StatelessWidget {
  final String name;

  InstructionsPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 55, 113, 136),
        title: Text(
          'Instructions',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(225, 55, 113, 136),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(60),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(224, 255, 255, 255),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(60),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Objectives:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Guess the number between 1 and 100.',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Guessing Logic:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Single Player:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      '• 10 attempts to guess.',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Center(
                    child: Text(
                      '• Feedback after each guess.',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Multiplayer:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      '• Each player gets 10 attempts.',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Center(
                    child: Text(
                      '• First to guess wins.',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Feedback:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Low',
                          style: TextStyle(
                            fontSize: 19,
                            color: const Color.fromARGB(255, 231, 6, 6),
                          ),
                        ),
                        Text(
                          ' Guess is within 10 below the number.',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'High',
                          style: TextStyle(
                            fontSize: 19,
                            color: const Color.fromARGB(255, 231, 6, 6),
                          ),
                        ),
                        Text(
                          ' Guess is within 10 above the number.',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Too low',
                          style: TextStyle(
                            fontSize: 19,
                            color: const Color.fromARGB(255, 231, 6, 6),
                          ),
                        ),
                        Text(
                          ' Guess is more than 10 below the number.',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Too high',
                          style: TextStyle(
                            fontSize: 19,
                            color: const Color.fromARGB(255, 231, 6, 6),
                          ),
                        ),
                        Text(
                          ' Guess is more than 10 above the number.',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 250.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainMenuScreen(name: name),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: Text('Next'),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 55, 113, 136),
                        onPrimary: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
