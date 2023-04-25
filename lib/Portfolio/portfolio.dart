import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Auth/login.dart';
import '../CloudAnimation/animated_wire.dart';
import '../InstallationPage/installation_page.dart';
import '../main.dart';

class Portfolio extends StatelessWidget {
  final List<String> installationList = [
    'Installation 1',
    'Installation 2',
    'Installation 3',
    'Installation 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Installations'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: installationList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SquareWaveAnimation(
                      amplitude: 20,
                      frequency: 2,
                      initialPhase: 1,
                    ),
                    ListTile(
                      title: Text(installationList[index]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                InstallationPage(),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class FlatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const FlatButton(
      {required Key key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ),
  );
}
