import 'package:flutter/material.dart';

class TimerSettings extends StatefulWidget {
  const TimerSettings({super.key});

  @override
  State<TimerSettings> createState() => _TimerSettingsState();
}

class _TimerSettingsState extends State<TimerSettings> {
  double pomodoroTime = 25;
  double breakTime = 5;
  double longBreakTime = 15;

  Widget buildTimeCard(String title, double time, Function onIncrease, Function onDecrease) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 18)),
            Row(
              children: [
                IconButton(
                  onPressed: () => onDecrease(),
                  icon: const Icon(Icons.remove),
                ),
                Text("${time.toStringAsFixed(0)} min",
                    style: const TextStyle(fontSize: 16)),
                IconButton(
                  onPressed: () => onIncrease(),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Timer Settings")),
      body: Column(
        children: [
          buildTimeCard("Pomodoro", pomodoroTime, () {
            setState(() => pomodoroTime++);
          }, () {
            if (pomodoroTime > 1) setState(() => pomodoroTime--);
          }),
          buildTimeCard("Short Break", breakTime, () {
            setState(() => breakTime++);
          }, () {
            if (breakTime > 1) setState(() => breakTime--);
          }),
          buildTimeCard("Long Break", longBreakTime, () {
            setState(() => longBreakTime++);
          }, () {
            if (longBreakTime > 1) setState(() => longBreakTime--);
          }),
        ],
      ),
    );
  }
}
