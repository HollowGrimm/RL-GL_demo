import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rhythm_knight/homescreen.dart';
import 'package:rhythm_knight/singleton.dart';
import 'package:rhythm_knight/sizeConfig.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late Timer T;
  int start = 10;
  final singleton = Singleton();
  bool light = false, moving = false, timerStop = false;
  Color lightColor = Colors.white;
  late AnimationController _controller;
  late Animation<double> _animation;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    T = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0 || (!light && moving)) {
          setState(() {
            timer.cancel();
            _controller.stop();
            singleton.lossScore(1);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          });
        } else if (timerStop) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  String timeText() {
    if (start < 10) {
      return "00:0$start";
    }
    return "00:$start";
  }

  String rglight() {
    if (start <= 5) {
      lightColor = const Color.fromRGBO(57, 255, 20, 92);
      light = true;
      return "Green Light!";
    } else {
      lightColor = const Color.fromRGBO(255, 49, 49, 92);
      light = false;
      return "Red Light!";
    }
  }

  @override
  void initState() {
    super.initState();

    startTimer();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 300).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    T.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                timeText(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                rglight(),
                style: TextStyle(
                    color: lightColor,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
            const SizedBox(
              height: 100.0,
            ),
            Center(
              child: GestureDetector(
                onLongPressStart: (details) {
                  setState(() {
                    timerStop = true;
                    _controller.forward().whenComplete(() {
                      singleton.winScore(1);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    });
                    moving = true;
                  });
                },
                onLongPressEnd: (details) {
                  setState(() {
                    _controller.stop();
                    moving = false;
                  });
                },
                child: const Icon(
                  Icons.arrow_forward,
                  color: Color.fromRGBO(57, 255, 20, 92),
                  size: 50,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
        Positioned(
          height: SizeConfig.blockSizeVertical! * 105,
          left: _animation.value,
          child: const Icon(
            Icons.directions_run,
            color: Color.fromRGBO(57, 255, 20, 92),
            size: 100,
          ),
        ),
      ],
    ));
  }
}
