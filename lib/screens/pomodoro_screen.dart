import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoro/screens/menu_screen.dart';
import 'package:pomodoro/screens/models/painter.dart';
import 'package:audioplayers/audioplayers.dart';

class Pomo extends StatefulWidget {
  final Color currColor;
  final bool allowSound;
  const Pomo({super.key, required this.currColor, required this.allowSound});

  @override
  State<Pomo> createState() => _PomoState();
}

class _PomoState extends State<Pomo> {
  String Title = "Pomodoro";
  Color curretColor = const Color.fromARGB(255, 217, 79, 54);
  bool isSoundOn = true;
  final player = AudioPlayer();

  double pomodorotime = 25.0;
  double breakTime = 5.0;
  double longbreak = 15.0;

  double progress = 1.0;
  int totalSeconds = 25 * 60;
  int remaininSeconds = 25 * 60;
  Timer? timer;

  bool isRunning = false;
  bool isFinishedPomodoro = false;
  bool isFinishedBreak = false;
  bool isFinishedLongBreak = false;
  bool resetClicked = false;

  int currentIndex = 0;
  List<Map<String, dynamic>> timeOptions = [];

  @override
  void initState() {
    super.initState();
    isSoundOn = widget.allowSound;

    timeOptions = [
      {"label": "Pomodoro", "minutes": pomodorotime},
      {"label": "Break", "minutes": breakTime},
      {"label": "Long Break", "minutes": longbreak},
    ];
    currentIndex = 0;
  }



  void toggleTimer() {
    if (isRunning) {
      timer?.cancel();
    } 
    else {
      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        setState(() {
          if (remaininSeconds > 0) {
            remaininSeconds--;
            progress = remaininSeconds / totalSeconds;
          }
          else {
            t.cancel();
            isRunning = false;
            resetClicked = false;
                if (isSoundOn) {
                  player.play(AssetSource('sounds/alarm.mp3'));
                }

            if (Title == "Pomodoro") {
              isFinishedPomodoro = true;
              isFinishedBreak = false;
              isFinishedLongBreak = false;
            } else if (Title == "Break") {
              isFinishedBreak = true;
              isFinishedPomodoro = false;
              isFinishedLongBreak = false;
            } else if (Title == "Long Break") {
              isFinishedLongBreak = true;
              isFinishedPomodoro = false;
              isFinishedBreak = false;
            }

          }
        });
      });
    }
    setState(() {
      isRunning = !isRunning;
    });
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      remaininSeconds = totalSeconds;
      progress = 1.0;
      isRunning = false;
      isFinishedPomodoro = false;
      isFinishedBreak = false;
      isFinishedLongBreak = false;
      resetClicked = true;
    });
  }

  void setTime(String label, int minutes) {
    setState(() {
      Title = label;
      totalSeconds = minutes * 60;
      remaininSeconds = totalSeconds;
      progress = 1.0;
      isFinishedPomodoro = false;
      isFinishedBreak = false;
      isFinishedLongBreak = false;
      isRunning = false;
      resetClicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: curretColor,
      body: Stack(
        children: [
          if (!isRunning)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Menu(intialColor: curretColor, allowSound: isSoundOn),
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        pomodorotime = (result["pomodoro"] as int).toDouble();
                        breakTime = (result["shortBreak"] as int).toDouble();
                        longbreak = (result["longBreak"] as int).toDouble();

                        curretColor = result["color"] ?? curretColor;
                        timeOptions = [
                          {"label": "Pomodoro", "minutes": pomodorotime},
                          {"label": "Break", "minutes": breakTime},
                          {"label": "Long Break", "minutes": longbreak},
                        ];

                        if (Title == "Pomodoro") {
                          setTime("Pomodoro", pomodorotime.toInt());
                          currentIndex = 0;
                        } else if (Title == "Break") {
                          setTime("Break", breakTime.toInt());
                          currentIndex = 1;
                        } else if (Title == "Long Break") {
                          setTime("Long Break", longbreak.toInt());
                          currentIndex = 2;
                        }
                      });
                    }
                  },
                  icon: const Icon(Icons.menu),
                  color: Colors.white,
                  iconSize: 30,
                ),
              ),
            ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: (isFinishedPomodoro || isFinishedBreak || isFinishedLongBreak)
                      ? null
                      : toggleTimer,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(250, 250),
                        painter: Painter(
                          totalTicks: (totalSeconds / 60).round(),
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 250,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 8,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      Icon(
                        isRunning ? Icons.pause : Icons.play_arrow,
                        size: 100,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "...   ... ....",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  Title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${remaininSeconds ~/ 60}:${(remaininSeconds % 60).toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                if (!isRunning && remaininSeconds != totalSeconds)
                  TextButton(
                    onPressed: resetTimer,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    child: const Text("reset"),
                  ),
                const SizedBox(height: 30),
                if (resetClicked && !isRunning)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = (currentIndex + 1) % timeOptions.length;
                        Title = timeOptions[currentIndex]["label"];
                        totalSeconds =
                            (timeOptions[currentIndex]["minutes"] as double).toInt() * 60;
                        remaininSeconds = totalSeconds;
                        progress = 1.0;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: 1.5708,
                          child: Icon(
                            Icons.code,
                            size: 30,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          timeOptions[currentIndex]["label"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const SizedBox(width: 3),
                        Text(
                          timeOptions[currentIndex]["minutes"].toString(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
