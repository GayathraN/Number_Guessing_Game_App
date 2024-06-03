import 'package:flutter/material.dart';
import 'instruction.dart';

class EnterNamePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Number Guessing',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 55, 113, 136),
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
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Enter your name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your Name',
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
                            builder: (context) =>
                                InstructionsPage(name: _controller.text),
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
