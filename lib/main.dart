import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'CloudAnimation/animated_wire.dart';
import 'Portfolio/portfolio.dart';

void main() {
  runApp(TaylorJanusApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class TaylorJanusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taylor app',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'SuisseIntl'),
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

class MyHomePageState extends State<MyHomePage> {
  static final Config config = Config(
      tenant: '8574a84d-ca63-4e63-9e5f-ca427a5fa24a',
      clientId: 'e4d69612-044a-4b56-accc-7f99b666ca2f',
      scope: 'openid profile offline_access',
      navigatorKey: navigatorKey,
      loader: SizedBox());
  final AadOAuth oauth = AadOAuth(config);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'AzureAD OAuth',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          ListTile(
            leading: Icon(Icons.launch),
            title: Text('Login${kIsWeb ? ' (web popup)' : ''}'),
            onTap: () {
              login(false);
            },
          ),
          if (kIsWeb)
            ListTile(
              leading: Icon(Icons.launch),
              title: Text('Login (web redirect)'),
              onTap: () {
                login(true);
              },
            ),
          ListTile(
            leading: Icon(Icons.data_array),
            title: Text('HasCachedAccountInformation'),
            onTap: () => hasCachedAccountInformation(),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              logout();
            },
          )
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
    if (accessToken != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(accessToken)));
    }
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
