import 'dart:math';

import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';

import 'src/portfolio/portfolio.dart';

void main() {
  runApp(TaylorJanusApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class TaylorJanusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taylor app',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'SuisseIntl',
          textTheme: const TextTheme(
              displayLarge: TextStyle(
                  fontSize: 72.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              displayMedium: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titleLarge:
                  TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'))),
      home: MyHomePage(title: 'Taylor Janus login'),
      navigatorKey: navigatorKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  static final Config config = Config(
      tenant: '8574a84d-ca63-4e63-9e5f-ca427a5fa24a',
      clientId: 'e4d69612-044a-4b56-accc-7f99b666ca2f',
      scope: 'openid profile offline_access',
      navigatorKey: navigatorKey,
      loader: SizedBox());

  final AadOAuth oauth = AadOAuth(config);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: SweepGradient(
        center: FractionalOffset.center,
        colors: <Color>[
          Color.fromARGB(255, 21, 57, 216), // blue
          Color.fromARGB(255, 47, 56, 94), // green
          Color.fromARGB(255, 49, 66, 94), // yellow
          Color.fromARGB(255, 50, 24, 163), // red
          Color.fromARGB(255, 21, 57, 216)
          // blue again to seamlessly transition to the start
        ],
        stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
      )),
      child: Stack(
        children: [
          HeaderText(animationController: _animationController),
          Center(
              child: TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.fromLTRB(20, 5, 20, 5)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Colors.white, width: 3)))),
            onPressed: () => login(true),
            child: Text("Login Azure AD".toUpperCase(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ))
        ],
      ),
    );
  }

  void showError(dynamic ex) {
    showMessage(ex.toString());
  }

  void showMessage(String text) {
    var alert = AlertDialog(content: Text(text), actions: <Widget>[
      TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          })
    ]);
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  void login(bool redirect) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Portfolio()),
    );
    config.webUseRedirect = redirect;
    final result = await oauth.login();
    result.fold(
        (l) => showError(l.toString()),
        (r) => {
              showMessage('Logged in successfully, your access token: $r'),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Portfolio()),
              )
            });
    var accessToken = await oauth.getAccessToken();
  }

  void hasCachedAccountInformation() async {
    var hasCachedAccountInformation = await oauth.hasCachedAccountInformation;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('HasCachedAccountInformation: $hasCachedAccountInformation'),
      ),
    );
  }

  void logout() async {
    await oauth.logout();
    showMessage('Logged out');
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
    required AnimationController animationController,
  }) : _animationController = animationController;

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
        ).drive(
          Tween<Offset>(begin: Offset(0, -0.3), end: Offset(0, 0)),
        ),
        child: FadeTransition(
            opacity: _animationController, child: SplashScreenHeader()));
  }
}

class SplashScreenHeader extends StatefulWidget {
  const SplashScreenHeader({
    super.key,
  });

  @override
  State<SplashScreenHeader> createState() => _SplashScreenHeaderState();
}

class _SplashScreenHeaderState extends State<SplashScreenHeader> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  double _width = 50;
  double _height = 50;
  Color _color = Colors.pink;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: Text(
        'taylor.',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
