import 'package:flutter/material.dart';
import 'package:taylor_janus/src/user_profile_screen/settings_screen.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          title: Center(
              child: Text(
            'Profile',
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SettingsPage();
                }));
              },
            ),
          ],
        ),
        body: Scaffold(
          body: Column(children: [
            _buildNormalContainer(),
            Expanded(
                child: Container(
              color: Colors.black,
            ))
          ]),
        ));
  }

  Widget _buildNormalContainer() => Container(
        color: Colors.grey.shade900,
        height: 200,
      );
}
