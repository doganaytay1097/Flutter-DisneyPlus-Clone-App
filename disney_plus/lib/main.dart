import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:disney_plus/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DisneyPlusClone());
}

class DisneyPlusClone extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    _playSound();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disney Plus Clone',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Color(0xff142850),

      ),
      home: AnimatedSplashScreen(
        splash: Lottie.asset('assets/animations/disney.json'),
        nextScreen: MainScreen(),
        duration: 4300,
        splashIconSize: 500,
        backgroundColor: Color(0xff142850),
      ),
    );
  }
  void _playSound() async {
    await _audioPlayer.play(AssetSource('audio/disney.mp3'));
  }
}
