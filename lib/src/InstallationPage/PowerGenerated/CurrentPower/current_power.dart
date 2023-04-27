import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';

class CurrentPower extends StatefulWidget {
  const CurrentPower({Key? key}) : super(key: key);

  @override
  _CurrentPowerState createState() => _CurrentPowerState();
}

class _CurrentPowerState extends State<CurrentPower>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _pointerValue;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );
    _pointerValue = Tween<double>(
      begin: -100,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ),
    )..addListener(() {
        setState(() {});
      });
    controller.forward().whenComplete(() => null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = min(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height) -
        100;

    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(
            width: size,
            height: size,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: RadialGauge(
                axes: [
                  RadialGaugeAxis(
                    minValue: -100,
                    maxValue: 100,
                    minAngle: -150,
                    maxAngle: 150,
                    radius: 0.6,
                    width: 0.2,
                    color: Colors.transparent,
                    ticks: [
                      RadialTicks(
                          interval: 20,
                          alignment: RadialTickAxisAlignment.inside,
                          color: Colors.blue,
                          length: 0.2,
                          children: [
                            RadialTicks(
                                ticksInBetween: 5,
                                length: 0.1,
                                color: Colors.grey[500]!),
                          ])
                    ],
                    pointers: [
                      RadialNeedlePointer(
                        minValue: -100,
                        maxValue: 100,
                        value: _pointerValue.value,
                        thicknessStart: 20,
                        thicknessEnd: 0,
                        color: Colors.blue,
                        length: 0.6,
                        knobRadiusAbsolute: 10,
                        gradient: LinearGradient(
                          colors: [
                            Color(Colors.blue[300]!.value),
                            Color(Colors.blue[300]!.value),
                            Color(Colors.blue[600]!.value),
                            Color(Colors.blue[600]!.value)
                          ],
                          stops: [0, 0.5, 0.5, 1],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
