import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AimGame extends StatefulWidget {
  const AimGame({super.key});

  @override
  State<AimGame> createState() => _AimGameState();
}

class _AimGameState extends State<AimGame> {
  static final _rng = Random();

  Color _color = Colors.red;
  double _width = 100;
  double _height = 100;
  double _radius = 50;
  Alignment _alignment = const Alignment(0.5, 0.5);

  int _score = 0;

  void _randomize() {
    _color = Color.fromARGB(_rng.nextInt(255), _rng.nextInt(255),
        _rng.nextInt(255), _rng.nextInt(255));
    _width = _rng.nextDouble() * 120 + 10;
    _height = _rng.nextDouble() * 120 + 10;
    _radius = _rng.nextDouble() * 60 + 10;
    _alignment =
        Alignment(_rng.nextDouble() * 2 - 1, _rng.nextDouble() * 2 - 1);
  }

  void _increaseScore() => _score++;

  Timer? _timer;
  int _countdown = 10;
  bool _isPlaying = false;

  void _startGame() {
    _score = 0;
    _countdown = 10;
    _isPlaying = true;
    _randomize();
    _startTimer();
  }

  void _endGame() => _isPlaying = false;

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      // print(_countdown);
      if (_countdown < 1) {
        _endGame();
        timer.cancel();
      } else {
        _countdown = _countdown - 1;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Aim Game'),
        ),
        body: Container(
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Score: $_score',
                      style: const TextStyle(color: Colors.white, fontSize: 48),
                    ),
                    (!_isPlaying)
                        ? GestureDetector(
                            onTap: () => setState(_startGame),
                            child: const Text(
                              'Start',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 28),
                            ),
                          )
                        : Text(
                            '$_countdown',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 28),
                          ),
                  ],
                ),
              ),
              (_isPlaying)
                  ? GestureDetector(
                      onTap: () => setState(() {
                        _increaseScore();
                        _randomize();
                      }),

                      // movement
                      child: AnimatedAlign(
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 500),
                        alignment: _alignment,

                        // shape transformation
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: _width,
                          height: _height,
                          decoration: BoxDecoration(
                            color: _color,
                            borderRadius: BorderRadius.circular(_radius),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ));
  }
}
