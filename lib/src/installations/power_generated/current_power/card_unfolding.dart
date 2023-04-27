import 'dart:async';
import 'package:flutter/material.dart';

class BirthdayCard extends StatefulWidget {
  @override
  _BirthdayCardState createState() => _BirthdayCardState();
}

class _BirthdayCardState extends State<BirthdayCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Timer _timer;
  bool _isUnfolded = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _timer = Timer(Duration(seconds: 2), () {
      setState(() {
        _isUnfolded = true;
        _animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(20),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(-_animation.value),
            child: child,
          );
        },
        child: _isUnfolded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Happy Birthday!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Wishing you all the best on your special day!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                ],
              )
            : Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
      ),
    );
  }
}
