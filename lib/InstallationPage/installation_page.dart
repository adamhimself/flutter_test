import 'package:flutter/material.dart';
import 'package:taylor_janus/InstallationPage/InstallationDetails/installation_details.dart';

import '../ScannerPage.dart';
import 'PowerGenerated/power_generated.dart';
import 'TotalSavings/savings_page.dart';

class InstallationPage extends StatefulWidget {
  const InstallationPage({Key? key}) : super(key: key);

  @override
  InstallationPageState createState() => InstallationPageState();
}

class InstallationPageState extends State<InstallationPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taylor'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.solar_power),
            label: 'Power',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.details),
            icon: Icon(Icons.details),
            label: 'Details',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.energy_savings_leaf_rounded),
            icon: Icon(Icons.energy_savings_leaf_rounded),
            label: 'Savings',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.barcode_reader),
            icon: Icon(Icons.barcode_reader),
            label: 'Scanner',
          ),
        ],
      ),
      body: <Widget>[
        PowerGeneratedChart(),
        InstallationDetails(),
        SavingsPage(),
        ScannerPage()
      ][currentPageIndex],
    );
  }
}
