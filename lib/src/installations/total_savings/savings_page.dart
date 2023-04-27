import 'package:flutter/cupertino.dart';
import 'package:taylor_janus/src/installations/total_savings/carbondioxide_saved.dart';
import 'package:taylor_janus/src/installations/total_savings/money_saved.dart';

class SavingsPage extends StatefulWidget {
  const SavingsPage({Key? key}) : super(key: key);

  @override
  _SavingsPageState createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: CarbondioxideSaved());
    Column(
      children: [CarbondioxideSaved(), MoneySaved()],
    );
  }
}
