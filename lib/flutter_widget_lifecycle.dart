import 'package:flutter/material.dart';

/// StatelessWidget生命周期方法只有两个：createElement()和build()。
///
/// StatefulWidget生命周期分三个阶段:
/// * 初始化时期：createState(), initState()
/// * 更新时期：didChangeDependencies(), build(), didUpdateWidget()
/// * 销毁时期：deactivate(), dispose()
class WidgetLifecycle extends StatefulWidget {
  const WidgetLifecycle({Key? key}) : super(key: key);

  @override
  State<WidgetLifecycle> createState() => _WidgetLifecycleState();
}

class _WidgetLifecycleState extends State<WidgetLifecycle> {
  int _count = 0;

  @override
  void initState() {
    // 类似Android里的onCreate()和iOS里的viewDidLoad()，做一些初始化。
    print('----initState----');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 首次构建Widget时，在initState之后立即调用。
    // 若StatefulWidget依赖于InheritedWidget，InheritedWidget中变量改变时再次调用。
    // InheritedWidget高效的将数据在Widget树中向下传递、共享。
    print('----didChangeDependencies----');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // didChangeDependencies之后立即调用
    // setState后再次调用
    print('----build----');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter页面生命周期'),
        leading: const BackButton(),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _count++;
                });
              },
              child: const Text('点我', style: TextStyle(fontSize: 26)),
            ),
            Text(_count.toString()),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(WidgetLifecycle oldWidget) {
    // 不常用，父组件重绘时调用
    print('----didUpdateWidget----');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    // 不常用，组件被移除时在dispose前调用
    print('----deactivate----');
    super.deactivate();
  }

  @override
  void dispose() {
    // 组件被销毁时调用，执行一些资源释放工作
    print('----dispose----');
    super.dispose();
  }
}
