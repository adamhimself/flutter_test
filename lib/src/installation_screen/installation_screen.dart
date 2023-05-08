import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taylor_janus/resources/app_resources.dart';

import '../user_profile_screen/user_profile.dart';
import 'current_metrics/current_metrics_screen.dart';
import 'historic_data_screen/historic_data_screen.dart';

class InstallationScreen extends StatefulWidget {
  const InstallationScreen({super.key});

  @override
  State<InstallationScreen> createState() => _InstallationScreenState();
}

enum TimePeriod { current, day, week, month, year }

class _InstallationScreenState extends State<InstallationScreen> {
  TimePeriod timePeriodView = TimePeriod.current;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget viewToShow;

    switch (timePeriodView) {
      case TimePeriod.current:
        viewToShow = CurrentMetricsScreen();
        break;
      case TimePeriod.day:
        viewToShow = HistoricData();
        break;
      case TimePeriod.week:
        viewToShow = HistoricData();
        break;
      case TimePeriod.month:
        viewToShow = HistoricData();
        break;
      case TimePeriod.year:
        viewToShow = HistoricData();
        break;
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'taylor.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person_2),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const UserProfileScreen();
              }));
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(children: [
          SegmentedButton<TimePeriod>(
            showSelectedIcon: false,
            segments: const <ButtonSegment<TimePeriod>>[
              ButtonSegment<TimePeriod>(
                value: TimePeriod.current,
                label: Text('Now'),
              ),
              ButtonSegment<TimePeriod>(
                value: TimePeriod.day,
                label: Text('Day'),
              ),
              ButtonSegment<TimePeriod>(
                value: TimePeriod.week,
                label: Text(
                  'Week',
                  style: TextStyle(),
                ),
              ),
              ButtonSegment<TimePeriod>(
                value: TimePeriod.month,
                label: Text('Month'),
              ),
              ButtonSegment(
                value: TimePeriod.year,
                label: Text('Year'),
              ),
            ],
            selected: <TimePeriod>{timePeriodView},
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Color.fromARGB(255, 7, 7, 7);
                }
                return Color.fromARGB(
                    255, 6, 27, 143); // Use the component's default.
              },
            ), backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return TaylorLightColors.taylorPrimaryShadeTwo;
                }
                return Color.fromARGB(
                    255, 225, 226, 235); // Use the component's default.
              },
            )),
            onSelectionChanged: (Set<TimePeriod> newSelection) {
              setState(() {
                // By default there is only a single segment that can be
                // selected at one time, so its value is always the first
                // item in the selected set.
                timePeriodView = newSelection.first;
              });
            },
          ),
          Expanded(child: Container(child: viewToShow))
        ]),
      ),
    );
  }
}
