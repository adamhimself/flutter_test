import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';

import '../src/portfolio_screen/portfolio_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AuthState extends StatefulWidget {
  const AuthState({Key? key}) : super(key: key);

  @override
  _AuthStateState createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  static final Config config = Config(
      tenant: '8574a84d-ca63-4e63-9e5f-ca427a5fa24a',
      clientId: 'e4d69612-044a-4b56-accc-7f99b666ca2f',
      scope: 'openid profile offline_access',
      navigatorKey: navigatorKey,
      loader: SizedBox());

  final AadOAuth oauth = AadOAuth(config);

  @override
  Widget build(BuildContext context) {
    return Container();
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

  void Login(bool redirect) async {
    config.webUseRedirect = redirect;
    final result = await oauth.login();
    result.fold(
        (l) => showError(l.toString()),
        (r) => {
              showMessage('Logged in successfully, your access token: $r'),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PortfolioScreen()),
              )
            });
    var accessToken = await oauth.getAccessToken();
  }

  void hasCachedAccountInformation() async {
    var hasCachedAccountInformation = await oauth.hasCachedAccountInformation;
  }

  void logout() async {
    await oauth.logout();
    showMessage('Logged out');
  }
}
