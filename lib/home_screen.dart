import 'package:flutter/material.dart';

import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => QuizScreen()),
            );
          },
          child: Text('Start Quick Maths Quiz'),
        ),
      ),
    );
  }
}
