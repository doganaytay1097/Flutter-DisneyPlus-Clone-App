import 'package:disney_plus/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DisneyPlusClone());
}

class DisneyPlusClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disney Plus Clone',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Color(0xff142850),

      ),
      home: MainScreen(),
    );
  }
}
