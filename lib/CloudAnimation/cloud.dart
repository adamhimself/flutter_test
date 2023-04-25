import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatingCloudWidget extends StatefulWidget {
  const FloatingCloudWidget({Key? key}) : super(key: key);

  @override
  FloatingCloudWidgetState createState() => FloatingCloudWidgetState();
}

class FloatingCloudWidgetState extends State<FloatingCloudWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset(1.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenHeight,
      color: Colors.blue,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Icon(
            Icons.cloud,
            size: 100,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
