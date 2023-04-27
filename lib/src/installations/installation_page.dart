import 'package:flutter/material.dart';
import 'package:taylor_janus/src/installations/details/installation_details.dart';

import '../user_profile/user_profile.dart';
import 'power_generated/power_generated.dart';

class InstallationPage extends StatefulWidget {
  const InstallationPage({Key? key}) : super(key: key);

  @override
  InstallationPageState createState() => InstallationPageState();
}

class InstallationPageState extends State<InstallationPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    PowerGeneratedChart(),
    InstallationDetails(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taylor'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person_2),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const UserProfile();
              }));
            },
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: IconThemeData(color: Colors.white70),
        selectedIconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.electric_bolt),
            label: 'Power',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Details',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
