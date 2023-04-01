import 'package:flutter/material.dart';
import 'package:my_app/flutter_layout_page.dart';
import 'package:my_app/gesture_page.dart';
import 'package:my_app/less_group_page.dart';
import 'package:my_app/plugin_use.dart';
import 'package:my_app/stateful_group_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('如何创建和使用Flutter的路由和导航？')),
        body: const RouteNavigator(),
      ),
      routes: <String,WidgetBuilder>{
        'plugin':(BuildContext context)=>const PluginUse(),
        'less':(BuildContext context)=>const LessGroupPage(),
        'stateful':(BuildContext context)=>const StatefulGroup(),
        'layout':(BuildContext context)=>const FlutterLayoutPage(),
        'gesture':(BuildContext context)=>const GesturePage(),
      },
    );
  }
}

class RouteNavigator extends StatefulWidget {
  const RouteNavigator({super.key});

  @override
  State<RouteNavigator> createState() => _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  bool byName = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitchListTile(
          title: Text('${byName?'':'不'}通过路由跳转'),
            value: byName, onChanged: (value){
          setState(() {
            byName = value;
          });
        }),
        _item('如何使用Flutter包和插件？',const PluginUse(),'plugin'),
        _item('StatelessWidget与基础组件',const LessGroupPage(),'less'),
        _item('StatefulWidget与基础组件',const StatefulGroup(),'stateful'),
        _item('如何进行Flutter布局开发？',const FlutterLayoutPage(),'layout'),
        _item('如何检测用户手势及处理点击事件？', const GesturePage(),'gesture'),
      ],
    );
  }

  _item(String title, page, String routeName) {
    return ElevatedButton(
      child: Text(title),
      onPressed: () {
        if (byName) {
          Navigator.pushNamed(context, routeName);
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>page));
        }
      },
    );
  }
}
