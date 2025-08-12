import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  final Color? intialColor;
  final bool allowSound ;
  const Menu({super.key,this.intialColor,required this.allowSound});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool isSoundOn=true;
  late Color currentColor;
  int pomodoro = 25;
  int shortBreak = 5;
  int longBreak = 15;

  final List<Color> colors = [
    Color.fromARGB(255, 217, 79, 54),
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    const Color.fromARGB(255, 136, 91, 113),
    Colors.pink,
    Colors.cyan,
    Colors.lime,
    Colors.indigo,
    Color(0xFFE76F51),
    Colors.deepOrange,
    Colors.lightGreen,
    Colors.deepPurple,
    Colors.brown,
    Colors.pink,
    Colors.blueGrey,
  ];

  @override
  void initState() {
    super.initState();
    currentColor = widget.intialColor ?? Colors.red;
  }

  Widget buildCard(
      String title, int value, VoidCallback onIncrease, VoidCallback onDecrease) {
    return Expanded(
      child: Card(
        color: Colors.white.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "$value",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: onDecrease,
                    icon: const Icon(Icons.remove, color: Colors.white),
                    iconSize: 20,
                  ),
                  IconButton(
                    onPressed: onIncrease,
                    icon: const Icon(Icons.add, color: Colors.white),
                    iconSize: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, <String, dynamic>{
                      "pomodoro": pomodoro,
                      "shortBreak": shortBreak,
                      "longBreak": longBreak,
                      "color": currentColor,
                    });
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white.withOpacity(0.7),
                  iconSize: 30,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() => isSoundOn = !isSoundOn);
                  },
                  icon: Icon(isSoundOn ? Icons.volume_up : Icons.volume_off),

                  color: Colors.white.withOpacity(0.7),
                  iconSize: 30,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "DURATIONS",
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 1.5,
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                buildCard("POMODORO", pomodoro, () {
                  setState(() => pomodoro++);
                }, () {
                  if (pomodoro > 1) setState(() => pomodoro--);
                }),
                buildCard("BREAK", shortBreak, () {
                  setState(() => shortBreak++);
                }, () {
                  if (shortBreak > 1) setState(() => shortBreak--);
                }),
                buildCard("LONG BREAK", longBreak, () {
                  setState(() => longBreak++);
                }, () {
                  if (longBreak > 1) setState(() => longBreak--);
                }),
              ],
            ),
            SizedBox(height: 15),
            Text(
              "Themes",
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1.5,
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: colors.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentColor = colors[index]; 
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: BorderRadius.circular(10),
                          border: currentColor == colors[index]
                              ? Border.all(color: Colors.white, width: 3)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
