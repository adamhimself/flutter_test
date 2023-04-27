import 'package:flutter/material.dart';
import 'package:taylor_janus/src/user_profile/user_profile.dart';
import '../installations/installation_page.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  PortfolioState createState() => PortfolioState();
}

class PortfolioState extends State<Portfolio> {
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
    installationList.forEach((installation) {
      if (installation.toLowerCase().contains(searchText.toLowerCase())) {
        filteredList.add(installation);
      }
    });
    setState(() {
      _filteredInstallations = filteredList;
      _showCards = filteredList.isNotEmpty;
    });
  }

  TextEditingController _searchController = TextEditingController();
  List<String> _filteredInstallations = [];
  bool _showCards = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Portfolio',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person_2),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const UserProfile();
              }));
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search installations...',
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
                          title: Text(item),
                          leading: Icon(Icons.list),
                          subtitle: Text("Subtitle of list item"),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const InstallationPage(),
                            ));
                          });
                    })),
          ],
        ),
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
