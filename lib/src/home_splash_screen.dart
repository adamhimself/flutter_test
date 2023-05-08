import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import 'login_form.dart';

class HomeSplashScreen extends StatefulWidget {
  HomeSplashScreen({Key? key}) : super(key: key);

  @override
  HomeSplashScreenState createState() => HomeSplashScreenState();
}

class HomeSplashScreenState extends State<HomeSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

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
          TaylorLightColors.matchingGradientOne,
          TaylorLightColors.matchingGradientOne,
          TaylorLightColors.matchingGradientThree,
          TaylorLightColors.matchingGradientOne,
          TaylorLightColors.matchingGradientOne,
          // blue again to seamlessly transition to the start
        ],
        stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
      )),
      child: Stack(
        children: [
          HeaderText(animationController: _animationController),
          LogInButton()
        ],
      ),
    );
  }
}

class LogInButton extends StatelessWidget {
  const LogInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.fromLTRB(20, 5, 20, 5)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.white, width: 3)))),
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginForm())),
      child: Text("Login".toUpperCase(),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
    ));
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
    super.dispose();
  }

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
