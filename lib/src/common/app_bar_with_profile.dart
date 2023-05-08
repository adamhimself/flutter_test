import 'package:flutter/material.dart';

import '../user_profile_screen/user_profile.dart';

class AppBarCommon extends StatelessWidget {
  const AppBarCommon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        'Portfolio',
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
    );
  }
}
