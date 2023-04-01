import 'package:flutter/material.dart';

class ResPage extends StatefulWidget {
  const ResPage({super.key});

  @override
  State<ResPage> createState() => _ResPageState();
}

class _ResPageState extends State<ResPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('如何导入和使用Flutter资源文件？'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Image(
              width: 100,
              height: 100,
              image: AssetImage('images/team.png'),
            )
          ],
        ),
      ),
    );
  }
}
