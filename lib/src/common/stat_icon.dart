import 'package:flutter/material.dart';

class StatIcon extends StatelessWidget {
  const StatIcon({
    super.key,
    required this.iconBgroundColor,
    required this.icon,
  });

  final Color iconBgroundColor;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: 40,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: iconBgroundColor),
        child: icon);
  }
}
