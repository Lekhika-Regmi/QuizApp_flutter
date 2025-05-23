import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() => runApp(QuickMathsApp());

class QuickMathsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Maths',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat',
      ),
      home: HomeScreen(),
    );
  }
}
