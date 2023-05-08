import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final Config config = Config(
  tenant: "8574a84d-ca63-4e63-9e5f-ca427a5fa24a",
  clientId: "e4d69612-044a-4b56-accc-7f99b666ca2f",
  scope: "openid profile offline_access",
  redirectUri: 'https://login.live.com/oauth20_desktop.srf',
  navigatorKey: navigatorKey,
  webUseRedirect:
      true, // default is false - on web only, forces a redirect flow instead of popup auth
  loader: Center(child: CircularProgressIndicator()),
  postLogoutRedirectUri: 'http://your_base_url/logout', //optional
);
