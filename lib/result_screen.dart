import 'package:flutter/material.dart';

import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final String time;

  ResultScreen({required this.score, required this.total, required this.time});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Score: $score / $total', style: TextStyle(fontSize: 24)),
            // Text('Time: $time', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                    (route) => false,
                  ),
              child: Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }
}
