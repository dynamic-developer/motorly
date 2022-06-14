import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../style/colors.dart';

class DynamicLoadingWidget extends StatefulWidget {
  const DynamicLoadingWidget({Key key}) : super(key: key);

  @override
  _DynamicLoadingState createState() => _DynamicLoadingState();
}

class _DynamicLoadingState extends State<DynamicLoadingWidget> {
  Timer _timer;
  int _index = 0;
  String _currentPhrase = "Loading...";

  final List<String> _phrases = [
    "Look! Is that a Kiwi?...",
    "Results coming in Nek Minnit...",
    "Still calculating stuff...",
    "Unicorns are at the end of this road, I promise.",
    "Come here more often :)... ",
    "I need more coffee...",
    "Still the fastest way to find a car!",
    "Almost there..."
  ];

  void switchPhrases() {
    _phrases.shuffle();

    _timer = Timer.periodic(Duration(milliseconds: 1500), (timer) {
      if (mounted) {
        setState(() {
          if (_index < _phrases.length) {
            _currentPhrase = _phrases[_index];
            _index++;
          } else {
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switchPhrases();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 150,
            width: double.maxFinite,
            child: Lottie.asset('assets/car.json'),
          ),
          Text(
            _currentPhrase,
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
