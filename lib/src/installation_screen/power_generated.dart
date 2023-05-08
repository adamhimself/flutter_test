import 'package:flutter/material.dart';
import 'package:taylor_janus/resources/app_colors.dart';

class PowerGenerated extends StatelessWidget {
  const PowerGenerated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        color: Theme.of(context).cardTheme.color,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Current power',
                  style: Theme.of(context).textTheme.bodyMedium),
              Text('102 kWh', style: Theme.of(context).textTheme.bodyMedium),
              Icon(
                Icons.bolt,
                size: 80,
                color: TaylorLightColors.taylorYellow,
              )
            ],
          ),
        ),
      ),
    );
  }
}
