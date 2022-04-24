// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
              children: [
                MoveBottomCity(),
              ],
            ),
    );
  }
}

class MoveBottomCity extends StatefulWidget {
  const MoveBottomCity({

    Key? key,
  }) : super(key: key);

  @override
  State<MoveBottomCity> createState() => _MoveBottomCityState();
}

class _MoveBottomCityState extends State<MoveBottomCity>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
     controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
        // .. зная ширину картинки и минимальную ширину экрана (500) вычитаем 
        //разницу между минимальной и фактической шириной экрана 
    animation = Tween<double>(begin: 0, end: -10)
        .animate(controller);
   controller.reset();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

  
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      AnimateBottomCity(listenable: animation);
}

class AnimateBottomCity extends AnimatedWidget {
  const AnimateBottomCity({Key? key, required Listenable listenable})
      : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    print('h = $height w = $width');
    final animation = listenable as Animation<double>;
    return Positioned(
      bottom: 0,
      right: animation.value,
      child: Image.asset(
        'assets/spb_bottom.png',
        alignment: Alignment.bottomCenter,
        height: height / 2,
        fit: BoxFit.cover,
      ),
    );
  }
}

class StaticBottomCity extends StatelessWidget {
  const StaticBottomCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Image.asset(
        'assets/spb_bottom.png',
        alignment: Alignment.bottomCenter,
        height: height / 2,
        fit: BoxFit.contain,
      ),
    );
  }
}
