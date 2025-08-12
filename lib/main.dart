import 'package:flutter/material.dart';
import 'package:pomodoro/screens/splash_screen.dart';


void main(){
  return runApp(Pomodoro());
}

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : const SplashScreen(),
    );
  }
}