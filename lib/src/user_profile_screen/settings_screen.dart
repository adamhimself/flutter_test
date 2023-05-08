import 'package:flutter/material.dart';
import 'package:taylor_janus/resources/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text('Settings'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Row(children: [
            Text("Dark mode"),
            Switch(
              value: true,
              onChanged: (value) => {},
            )
          ]),
          Row(children: [
            Text(
              "Dark mode",
              style: TextStyle(color: Colors.white),
            ),
            Switch(
              value: true,
              onChanged: (value) => {},
            )
          ]),
        ],
      ),
    );
  }
}
