import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pomodoro/screens/pomodoro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class  _SplashScreenState extends  State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => Pomo(currColor: Color.fromARGB(255, 217, 79, 54), allowSound: true,)));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 79, 54),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:(
          [
          Center(
            child: Icon(
            Icons.check_circle,
            size: 100,
            color: Colors.white,
          )
          ),
          SizedBox(width: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
            'Loading ',
            style: TextStyle(
              
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          LoadingAnimationWidget.waveDots(
            color: Colors.white,
            size: 30,
          ),
          ]
          ),
        ]
        ) 
      )
    );
  }
}