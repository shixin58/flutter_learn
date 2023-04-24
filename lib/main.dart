import 'package:flutter/material.dart';
import 'package:my_app/animation_dev.dart';
import 'package:my_app/app_lifecycle.dart';
import 'package:my_app/flutter_layout_page.dart';
import 'package:my_app/flutter_widget_lifecycle.dart';
import 'package:my_app/gesture_page.dart';
import 'package:my_app/hero_dev.dart';
import 'package:my_app/image_dev.dart';
import 'package:my_app/launch_page.dart';
import 'package:my_app/less_group_page.dart';
import 'package:my_app/photo_app_page.dart';
import 'package:my_app/photo_app_page_old.dart';
import 'package:my_app/plugin_use.dart';
import 'package:my_app/res_page.dart';
import 'package:my_app/stateful_group_page.dart';

void main() {
  runApp(const DynamicTheme());
}

// StatelessWidget不具备动态修改主题的能力
class DynamicTheme extends StatefulWidget {
  const DynamicTheme({Key? key}) : super(key: key);

  @override
  State<DynamicTheme> createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  Brightness _brightness = Brightness.light;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // fontFamily: 'RubikMonoOne',// 将字体应用到全局
        brightness: _brightness,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Demo')),
        body: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_brightness == Brightness.dark) {
                    _brightness = Brightness.light;
                  } else {
                    _brightness = Brightness.dark;
                  }
                });
              },
              child: const Text('切换主题abc', style: TextStyle(fontFamily: 'RubikMonoOne'),),
            ),
            const RouteNavigator()
          ],
        ),
      ),
      routes: <String,WidgetBuilder>{
        'plugin':(BuildContext context)=>const PluginUse(),
        'less':(BuildContext context)=>const LessGroupPage(),
        'stateful':(BuildContext context)=>const StatefulGroup(),
        'layout':(BuildContext context)=>const FlutterLayoutPage(),
        'gesture':(BuildContext context)=>const GesturePage(),
        'res':(BuildContext context)=>const ResPage(),
        'launch':(BuildContext context)=>const LaunchPage(),
        'widgetLifecycle':(BuildContext context)=>const WidgetLifecycle(),
        'appLifecycle':(BuildContext context)=>const AppLifecycle(),
        'photo':(BuildContext context)=>const PhotoApp(),
        'photoOld':(BuildContext context)=>const PhotoAppOld(),
        'image':(BuildContext context)=>const ImageDev(),
        'animation':(BuildContext context)=>const AnimationDev(),
        'heroAnimation':(BuildContext context)=>const HeroAnimation(),
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
          value: byName,
          onChanged: (value) { setState(() { byName = value; }); },
        ),
        _item('如何使用Flutter包和插件？',const PluginUse(),'plugin'),
        _item('StatelessWidget与基础组件',const LessGroupPage(),'less'),
        _item('StatefulWidget与基础组件',const StatefulGroup(),'stateful'),
        _item('如何进行Flutter布局开发？',const FlutterLayoutPage(),'layout'),
        _item('如何检测用户手势及处理点击事件？', const GesturePage(),'gesture'),
        _item('如何导入和使用Flutter资源文件？', const ResPage(), 'res'),
        _item('如何打开第三方应用？', const LaunchPage(), 'launch'),
        _item('Flutter页面生命周期', const WidgetLifecycle(), 'widgetLifecycle'),
        _item('Flutter应用生命周期', const AppLifecycle(), 'appLifecycle'),
        _item('拍照App开发', const PhotoApp(), 'photo'),
        _item('拍照App开发old', const PhotoAppOld(), 'photoOld'),
        _item('图片控件开发详解', const ImageDev(), 'image'),
        _item('动画开发指南', const AnimationDev(), 'animation'),
        _item('Basic Hero Animation', const HeroAnimation(), 'heroAnimation'),
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
