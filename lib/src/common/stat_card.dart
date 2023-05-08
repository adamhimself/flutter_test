import 'package:flutter/material.dart';
import 'package:taylor_janus/src/common/stat_icon.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.statIcon,
    required this.mainText,
    required this.timePeriod,
    required this.amountInWh,
  });

  final StatIcon statIcon;
  final String mainText;
  final String timePeriod;
  final num amountInWh;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              statIcon,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainText,
                    style: TextStyle(
                      color: Color.fromARGB(255, 49, 49, 49),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Power $timePeriod',
                    style: TextStyle(
                      color: Color.fromARGB(255, 182, 182, 182),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '$amountInWh Wh',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
