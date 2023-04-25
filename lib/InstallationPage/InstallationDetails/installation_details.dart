import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taylor_janus/InstallationPage/InstallationDetails/user_data.dart';
import 'package:taylor_janus/InstallationPage/InstallationDetails/user_details.dart';

class InstallationDetails extends StatefulWidget {
  const InstallationDetails({Key? key}) : super(key: key);

  @override
  _InstallationDetailsState createState() => _InstallationDetailsState();
}

class _InstallationDetailsState extends State<InstallationDetails> {
  Future<User> _futureSite = fetchSiteData();

  static Future<User> fetchSiteData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      List<dynamic> jsonList = jsonDecode(response.body);
      User user = User.fromJson(jsonList[0]);
      return user;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load site data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _futureSite,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return UserDetails(user: snapshot.data!);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class Site {
  final String name;
  final String detail1;
  final String detail2;
  final String detail3;
  final String detail4;
  final String detail5;

  Site({
    required this.name,
    required this.detail1,
    required this.detail2,
    required this.detail3,
    required this.detail4,
    required this.detail5,
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      name: json['name'],
      detail1: json['detail1'],
      detail2: json['detail2'],
      detail3: json['detail3'],
      detail4: json['detail4'],
      detail5: json['detail5'],
    );
  }
}

class Details extends StatelessWidget {
  final Site site;

  Details({required this.site});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(site.name),
        Text(site.detail1),
        Text(site.detail2),
        Text(site.detail3),
        Text(site.detail4),
        Text(site.detail5),
      ],
    );
  }
}
