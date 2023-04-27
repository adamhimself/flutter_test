import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../animations/CloudAnimation/cloud.dart';

class CarbondioxideSaved extends StatelessWidget {
  const CarbondioxideSaved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Cloud animation widget goes here
        FloatingCloudWidget(),
        // CO2SavedWidget positioned on top of the cloud animation
        Positioned(
          top: 25,
          left: 0,
          right: 0,
          height: 200,
          child: Center(
            child: CO2SavedWidget(co2Saved: 100.0),
          ),
        ),
      ],
    );
  }
}

class CO2SavedWidget extends StatelessWidget {
  final double co2Saved; // amount of CO2 saved in kilograms

  CO2SavedWidget({required this.co2Saved});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'CO2 Saved',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${co2Saved.toStringAsFixed(2)} kg',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Equivalent to planting ${_calculateTrees()} trees',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  int _calculateTrees() {
    // assume each tree can absorb 22 kg of CO2 per year
    int trees = (co2Saved / 22).ceil();
    return trees;
  }
}
