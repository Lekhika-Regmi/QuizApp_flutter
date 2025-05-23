import 'dart:async';

import 'package:flutter/material.dart';

import 'question_engine.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  final QuestionEngine _engine = QuestionEngine();
  int _currentIndex = 0;
  int _score = 0;

  // timer
  late AnimationController _controller;
  static const int _timeLimit = 15;

  // feedback
  int? _selectedIndex;
  bool _isCorrect = false;
  bool _buttonsEnabled = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _timeLimit),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onAnswerTimedOut();
      }
    });
    _controller.forward();
  }

  void _onAnswerTimedOut() {
    // treat as wrong
    _showFeedback(null);
  }

  void _showFeedback(int? selected) {
    _controller.stop();
    setState(() {
      _selectedIndex = selected;
      _isCorrect =
          (selected != null &&
              selected == _engine.questions[_currentIndex].correctIndex);
      _buttonsEnabled = false;
    });
    if (_isCorrect) _score++;

    // wait 1 second to show color feedback, then move on
    Future.delayed(Duration(seconds: 1), _moveToNext);
  }

  void _moveToNext() {
    if (_currentIndex < _engine.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedIndex = null;
        _buttonsEnabled = true;
      });
      _controller.reset();
      _controller.forward();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) => ResultScreen(
                score: _score,
                total: _engine.questions.length,
                time: '${_engine.questions.length * _timeLimit} seconds',
              ),
        ),
      );
    }
  }

  void _answerQuestion(int selected) {
    _showFeedback(selected);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = _engine.questions[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text('Quick Maths'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Q${_currentIndex + 1}/${_engine.questions.length}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: 1.0 - _controller.value,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                    backgroundColor: Colors.grey[300],
                    strokeWidth: 8,
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder:
                      (_, __) => Text(
                        '${(_timeLimit * (1.0 - _controller.value)).round()}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(question.questionText, style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ...List.generate(question.options.length, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(double.infinity, 50),
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.resolveWith((
                      states,
                    ) {
                      // If feedback phase is active:
                      if (_selectedIndex != null) {
                        if (i == _selectedIndex) {
                          // selected button: green if correct, red if wrong
                          return _isCorrect ? Colors.green : Colors.red;
                        } else {
                          // other buttons: greyed out
                          return Colors.grey[400];
                        }
                      }
                      // Normal state (no selection yet):
                      return Colors.deepPurpleAccent;
                    }),
                  ),
                  onPressed: _buttonsEnabled ? () => _answerQuestion(i) : null,
                  child: Text(
                    question.options[i],
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
