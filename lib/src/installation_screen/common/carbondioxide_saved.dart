import 'package:flutter/material.dart';
import 'package:taylor_janus/src/common/stat_card.dart';
import 'package:taylor_janus/src/common/stat_icon.dart';

class CarbondioxideSaved extends StatelessWidget {
  const CarbondioxideSaved(
      {Key? key, required this.timePeriod, required this.amountInKg});

  final String timePeriod;
  final num amountInKg;

  @override
  Widget build(BuildContext context) {
    return StatCard(
        timePeriod: timePeriod,
        amountInWh: amountInKg,
        mainText: 'Co2 saved',
        statIcon: StatIcon(
          iconBgroundColor: Colors.green.shade600,
          icon: Icon(
            color: Color.fromARGB(255, 177, 236, 179),
            Icons.energy_savings_leaf_rounded,
            size: 28,
          ),
        ));
  }
}
