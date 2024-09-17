import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Analogmclock extends StatefulWidget {
  double? circleWidth = 300.0;
  double? circleHeight = 300.0;
  Color? oneTOTwelveNumberColor = Colors.black;
  Color? hourHandColor = Colors.black;
  Color? minuteHandColor = Colors.black;
  Color? secondHandColor = Colors.black;
  Color? backgroundColor = Colors.white;
  double circleBorderWidth = 3.0;
  Color? secondsDotsColor = Colors.black;
  double centerCircleWidth = 10.0;
  double centerCircleHeight = 10.0;
  Color? centerCircleColor = Colors.black;
  double? clockNameFontSize = 25.0;
  Color? clockNameColor = Colors.black;
  String? clockName = 'Mari';
  double? clockNamePositionTop = 210.0;

  Analogmclock(
      {super.key,
        required this.circleWidth,
        required this.circleHeight,
        required this.oneTOTwelveNumberColor,
        required this.hourHandColor,
        required this.minuteHandColor,
        required this.secondHandColor,
        required this.circleBorderWidth,
        required this.secondsDotsColor,
        required this.centerCircleWidth,
        required this.centerCircleHeight,
        required this.centerCircleColor,
        required this.clockNameFontSize,
        required this.clockNameColor,
        required this.clockName,
        required this.clockNamePositionTop});

  @override
  State<Analogmclock> createState() => _AnalogmclockState();
}

class _AnalogmclockState extends State<Analogmclock> {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  // Timer to update the clock every second
  Timer? _timer;

  @override
  void initState() {
    updateClock();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateClock();
    });
    super.initState();
  }

  // Method to update the clock time
  void updateClock() {
    final now = DateTime.now();
    setState(() {
      hours = now.hour;
      minutes = now.minute;
      seconds = now.second;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.circleWidth,
        height: widget.circleHeight,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(width: widget.circleBorderWidth),
          ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Clock numbers (1 to 12)
            for (var i = 1; i <= 12; i++)
              Positioned(
                left: 140 + 120 * cos((i - 3) * pi / 6),
                top: 140 + 120 * sin((i - 3) * pi / 6),
                child: Text(
                  '$i',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: widget.oneTOTwelveNumberColor,
                  ),
                ),
              ),

            // Second markers (small dots or lines)
            for (var i = 0; i < 60; i++)
              Positioned(
                left: 145 + 130 * cos((i - 15) * pi / 30),
                // 15 offsets to rotate
                top: 145 + 137 * sin((i - 15) * pi / 30),
                child: Container(
                  decoration: BoxDecoration(
                      color: widget.secondsDotsColor,
                      // Adjust color for markers
                      borderRadius: BorderRadius.circular(15)),
                  width: (i % 5 == 0) ? 5 : 2, // Larger for every 5th marker
                  height: (i % 5 == 0) ? 8 : 5,
                  // color: Colors.black, // Adjust color for markers
                ),
              ),

            // Hour hand (shorter hand)
            Transform.rotate(
              angle: (hours % 12) * pi / 6 + (minutes) * pi / 360,
              child: Container(
                width: 6,
                // Width of the hour hand
                height: 90,
                // Height of the hour hand (shorter)
                alignment: Alignment.topCenter,
                // Align the hand from the center
                child: Container(
                  width: 6,
                  // Same width as the hour hand
                  height: 60,
                  // Shorter to keep only one side visible (length of the hand)
                  color: widget.hourHandColor, // Color for the hour hand
                ),
              ),
            ),

            Positioned(
                top: widget.clockNamePositionTop,
                child: Text(
                  '${widget.clockName}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.clockNameColor,
                      fontSize: widget.clockNameFontSize),
                )),

            // Minute hand (longer hand)
            Transform.rotate(
              angle: minutes * pi / 30, // Rotation based on minutes
              child: Container(
                width: 4, // Width of the minute hand
                height: 150, // Total height, adjust as needed
                alignment: Alignment.topCenter, // Align from the center outward
                child: Container(
                  width: 4, // Same width as the minute hand
                  height: 90, // Length of the visible part of the minute hand
                  color: widget.minuteHandColor, // Color for the minute hand
                ),
              ),
            ),

            // Second hand (longest hand)
            Transform.rotate(
              angle: seconds * pi / 30, // Rotation based on seconds
              child: Container(
                width: 2,
                // Width of the second hand
                height: 255,
                // Total height (adjust as needed for the length)
                alignment: Alignment.topCenter,
                // Align the hand from the center outward
                child: Container(
                  width: 2, // Same width as the second hand
                  height: 140, // Length of the visible part of the second hand
                  color: widget.secondHandColor, // Color for the second hand
                ),
              ),
            ),
            // Center point
            Container(
              width: widget.centerCircleWidth,
              height: widget.centerCircleHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.centerCircleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
