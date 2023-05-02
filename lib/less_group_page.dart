import 'package:flutter/material.dart';

class LessGroupPage extends StatelessWidget {
  const LessGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 20);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('StatelessWidget与基础组件'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                'I am Text',
                style: textStyle,
              ),
              const Icon(
                Icons.android,
                size: 50,
                color: Colors.red,
              ),
              const CloseButton(),
              const BackButton(),
              const Chip(
                avatar: Icon(Icons.people),
                label: Text('StatelessWidget与基础组件')
              ),
              const Divider(
                height: 10,
                thickness: 2,
                indent: 10,
                endIndent: 10,
                color: Colors.orange
              ),
              Card(
                color: Colors.blue,
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'I am Card',
                    style: textStyle,
                  ),
                ),
              ),
              const AlertDialog(
                title: Text('盘他'),
                content: Text('你这个糟老头子坏的很'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}