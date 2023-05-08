import 'package:flutter/material.dart';
import 'package:taylor_janus/resources/app_colors.dart';

class PanelLayoutContainer extends StatefulWidget {
  const PanelLayoutContainer({super.key});

  @override
  State<PanelLayoutContainer> createState() => _PanelLayoutContainerState();
}

class _PanelLayoutContainerState extends State<PanelLayoutContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation sizeAnimation;
  bool selected = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    sizeAnimation = Tween<double>(begin: 0, end: 10.0).animate(controller);

    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Panel layout'),
        SlideTransition(
            position: CurvedAnimation(
              parent: controller,
              curve: Curves.easeOutSine,
            ).drive(Tween<Offset>(begin: Offset(0, -2), end: Offset(0, 0.1))),
            child: Center(
              child: Transform(
                transform: Matrix4.identity()
                  ..rotateX(0.4)
                  ..rotateY(0)
                  ..rotateZ(0),
                child: PanelsLayout(),
              ),
            )),
      ],
    );
  }
}

class PanelsLayout extends StatelessWidget {
  const PanelsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Panel(),
            Panel(),
            Panel(),
            Panel(),
            Panel(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Panel(),
            Panel(),
            Panel(),
            Panel(),
            Panel(),
          ],
        ),
      ],
    );
  }
}

class Panel extends StatelessWidget {
  const Panel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      color: TaylorLightColors.taylorDarkColor,
      height: 100,
      width: 40,
      child: Center(
        child: Text(
          '235 W',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
