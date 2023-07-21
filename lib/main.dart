import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gap/gap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: CoffeeTimer(),
      ),
    );
  }
}

class CoffeeTimer extends StatefulWidget {
  const CoffeeTimer({super.key});

  @override
  State<CoffeeTimer> createState() => _CoffeeTimerState();
}

class _CoffeeTimerState extends State<CoffeeTimer> {
  late Timer timer;
  var started = false;
  var secondsElapsed = 0;

  final swirlTime = 110;
  final pressTime = 140;

  String get swirlTimerValue {
    if (!started) return displayTime(swirlTime);
    var remaining = swirlTime - secondsElapsed;
    if (remaining < 0) remaining = 0;
    return displayTime(remaining);
  }

  String get pressTimerValue {
    if (!started) return displayTime(pressTime);
    var remaining = pressTime - secondsElapsed;
    if (remaining < 0) remaining = 0;
    return displayTime(remaining);
  }

  String displayTime(int myseconds) {
    final minutes = (myseconds / 60).floor();
    final seconds = myseconds.remainder(60);

    return '$minutes:$seconds';
  }

  void handleFAB() {
    if (!started) {
      startTimer();
    } else {
      resetTimer();
    }
  }

  void startTimer() {
    started = true;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() => secondsElapsed++),
    );
  }

  void resetTimer() {
    timer.cancel();
    started = false;
    secondsElapsed = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.displayMedium;
    return Container(
        alignment: Alignment.center,
        color: Colors.brown[50],
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              swirlTimerValue,
              style: style,
            ),
            const Gap(24),
            Text('Time to swirl', style: style),
            const Gap(24),
            Text(pressTimerValue, style: style),
            const Gap(24),
            Text('Time to press', style: style),
            const Gap(24),
            FloatingActionButton(
              onPressed: handleFAB,
              elevation: 0,
              child: Icon(
                switch (started) {
                  true => Icons.refresh_outlined,
                  false => Icons.play_arrow
                },
              ),
            )
          ],
        ));
  }
}
