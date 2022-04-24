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
    final size = MediaQuery.of(context).size;
    print(size.width);
    print(size.height);
    return Scaffold(
      body: Stack(
        children: [
          AnimateBottomImage(
            heightDevice: size.height,
            widghtDevice: size.width,
            widghtImage: 1597,
            heightImage: 473,
            heightNeedImage: size.height * 0.6,
            pathImage: 'assets/spb_bottom.png', secondAnimate: 10,
          )
        ],
      ),
    );
  }
}

class AnimateBottomImage extends StatefulWidget {
  const AnimateBottomImage({
    Key? key,
    required this.heightDevice,
    required this.widghtDevice,
    required this.widghtImage,
    required this.heightImage,
    required this.heightNeedImage,
    required this.pathImage,
    required this.secondAnimate,
  }) : super(key: key);
  final double heightDevice;
  final double widghtDevice;
  final double widghtImage;
  final double heightImage;
  final String pathImage;
  final double heightNeedImage;
  final int secondAnimate;
  @override
  State<AnimateBottomImage> createState() => _AnimateBottomImageState();
}

class _AnimateBottomImageState extends State<AnimateBottomImage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.secondAnimate),
    );

    // зная изначальную ширину и высоту картинки и размеры экрана можем узнать
    // растояние движения анимации

    final maxWidthImageOnDevice =
        widget.widghtImage * (widget.heightNeedImage / widget.heightImage);
    final motionTweenDistanceImage =
        maxWidthImageOnDevice - widget.widghtDevice;

    animation = Tween<double>(begin: 0, end: -motionTweenDistanceImage)
        .animate(controller);

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
  Widget build(BuildContext context) => _AnimateMove(
        listenable: animation,
        heightNeedImage: widget.heightNeedImage,
        pathImage: widget.pathImage,
      );
}

class _AnimateMove extends AnimatedWidget {
  const _AnimateMove({
    Key? key,
    required this.pathImage,
    required this.heightNeedImage,
    required Listenable listenable,
  }) : super(key: key, listenable: listenable);

  final String pathImage;
  final double heightNeedImage;
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Positioned(
      bottom: 0,
      right: animation.value,
      child: Container(
        color: Colors.blueGrey,
        height: heightNeedImage,
        child: Image.asset(
          pathImage,
          alignment: Alignment.bottomCenter,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
