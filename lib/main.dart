import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taylor_janus/resources/app_theme_data.dart';
import 'package:taylor_janus/src/home_splash_screen.dart';

import 'src/installation_screen/historic_data_screen/historic_data_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Favourites(),
    child: TaylorJanusApp(),
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();

class TaylorJanusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taylor app',
      theme: lightTheme,
      home: HomeSplashScreen(),
      navigatorKey: navigatorKey,
    );
  }
}
