import 'package:flutter/material.dart';
import 'package:my_app/utils.dart';

class AppLifecycle extends StatefulWidget {
  const AppLifecycle({Key? key}) : super(key: key);

  @override
  State<AppLifecycle> createState() => _AppLifecycleState();
}

// 用WidgetsBindingObserver(mixins)监听应用生命周期、语言变化
class _AppLifecycleState extends State<AppLifecycle> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter应用生命周期'),
        leading: const BackButton(),
      ),
      body: const Text('Flutter应用生命周期'),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    printDebug('state = $state');
    if (state == AppLifecycleState.paused) {
      printDebug('App进入后台');
    } else if (state == AppLifecycleState.resumed) {
      printDebug('App进入前台');
    } else if (state == AppLifecycleState.inactive) {
      // 不常用，app不活跃且不接收用户输入时，比如来了个电话
    } else if (state == AppLifecycleState.detached) {
      // suspending已被移除
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
