import 'package:flutter/material.dart';

import '../../common/stat_card.dart';
import '../../common/stat_icon.dart';

class TotalPowerGenerated extends StatelessWidget {
  const TotalPowerGenerated(
      {Key? key, required this.timePeriod, required this.amountInWh});

  final String timePeriod;
  final num amountInWh;

  @override
  Widget build(BuildContext context) {
    return StatCard(
      timePeriod: timePeriod,
      amountInWh: amountInWh,
      mainText: 'Power generated',
      statIcon: StatIcon(
        iconBgroundColor: Colors.blue.shade600,
        icon: Icon(
          color: Colors.yellow,
          Icons.bolt,
          size: 28,
        ),
      ),
    );
  }
}
