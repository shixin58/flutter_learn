import 'package:flutter/material.dart';

class AnimationDev extends StatefulWidget {
  const AnimationDev({super.key});

  @override
  State<AnimationDev> createState() => _AnimationDevState();
}

class _AnimationDevState extends State<AnimationDev> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  AnimationStatus? animationStatus;
  double animationValue = 0.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0.0, end: 300.0).animate(controller)
    ..addListener(() {
      setState(() {
        animationValue = animation.value;
      });
    })
    ..addStatusListener((AnimationStatus status) {
      setState(() {
        animationStatus = status;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('动画开发指南'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: const Text('Start', textDirection: TextDirection.ltr,),
          ),
          Text('State: ${animationStatus?.toString()}', textDirection: TextDirection.ltr,),
          Text('State: $animationValue', textDirection: TextDirection.ltr,),
          SizedBox(
            width: animationValue,
            height: animationValue,
            child: const FlutterLogo(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}