import 'package:flutter/material.dart';

class AnimationDev extends StatefulWidget {
  const AnimationDev({super.key});

  @override
  State<AnimationDev> createState() => _AnimationDevState();
}

// 定义Animation对象
class _AnimationDevState extends State<AnimationDev> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0.0, end: 300.0).animate(controller);
    controller.forward();
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
      body: GrowTransition(animation: animation, child: const LogoWidget()),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// 业务逻辑：显示Logo
class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: const FlutterLogo(),
    );
  }
}

// 用AnimatedBuilder渲染过渡效果
class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const GrowTransition({Key? key, required this.child, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context,child)=>SizedBox(
        width: animation.value,
        height: animation.value,
        child: child,
      ),
      child: child,
    );
  }
}
