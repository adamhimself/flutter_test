import 'package:flutter/material.dart';
import 'package:taylor_janus/src/user_profile_screen/user_profile.dart';

import '../installation_screen/installation_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  PortfolioScreenState createState() => PortfolioScreenState();
}

class PortfolioScreenState extends State<PortfolioScreen> {
  final List<String> installationList = [
    'Installation 1',
    'Installation 2',
    'Installation 3',
    'Installation 4',
  ];

  @override
  void initState() {
    super.initState();
    _filteredInstallations = installationList;
  }

  void _filterInstallations(String searchText) {
    List<String> filteredList = [];
    for (var installation in installationList) {
      if (installation.toLowerCase().contains(searchText.toLowerCase())) {
        filteredList.add(installation);
      }
    }
    setState(() {
      _filteredInstallations = filteredList;
    });
  }

  TextEditingController _searchController = TextEditingController();
  List<String> _filteredInstallations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search..',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (searchText) {
                _filterInstallations(searchText);
              },
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _filteredInstallations.length,
                  itemBuilder: (context, index) {
                    final item = _filteredInstallations[index];
                    return ListTile(
                        textColor: Colors.black,
                        tileColor: Colors.white,
                        title: Text(item),
                        leading: Icon(Icons.list),
                        subtitle: Text("Subtitle of list item"),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const InstallationScreen(),
                          ));
                        });
                  })),
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
