import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taylor_janus/src/installation_screen/panels_layout.dart';

import '../power_chart.dart';

class HistoricData extends StatelessWidget {
  const HistoricData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          PowerChart(),
          SingleChoice(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [PanelLayoutContainer()],
          ),
        ],
      ),
    );
  }
}

class FruitButton extends StatelessWidget {
  final String fruit;

  FruitButton({required this.fruit});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Provider.of<Favourites>(context, listen: false).changeFruit(fruit);
        },
        child: Text(fruit));
  }
}

class Favourites extends ChangeNotifier {
  String fruit = 'unknown';

  void changeFruit(String newFruit) {
    fruit = newFruit;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

enum PanelSelection { day, year }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  PanelSelection calendarView = PanelSelection.day;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<PanelSelection>(
      segments: const <ButtonSegment<PanelSelection>>[
        ButtonSegment<PanelSelection>(
            value: PanelSelection.day, label: Text('Overview')),
        ButtonSegment<PanelSelection>(
            value: PanelSelection.year, label: Text('Panels'))
      ],
      selected: <PanelSelection>{calendarView},
      onSelectionChanged: (Set<PanelSelection> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          calendarView = newSelection.first;
        });
      },
    );
  }
}
