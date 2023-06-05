import 'package:flutter/material.dart';
import 'package:rhythm_knight/checker.dart';

void main() {
  runApp(const RhythmKnight());
}

class RhythmKnight extends StatelessWidget {
  const RhythmKnight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.grey,
            scaffoldBackgroundColor: const Color.fromRGBO(27, 45, 42, 92)),
        debugShowCheckedModeBanner: false,
        home: const Checker());
  }
}
