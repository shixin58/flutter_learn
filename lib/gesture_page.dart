import 'package:flutter/material.dart';

class GesturePage extends StatefulWidget {
  const GesturePage({Key? key}) : super(key: key);

  @override
  State<GesturePage> createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {
  String printString = '';
  double moveX=0,moveY=0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('如何检测用户手势及处理点击事件？'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: FractionallySizedBox(
          widthFactor: 1.0,
          child: Stack(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _printMsg('点击'),
                    onDoubleTap: () => _printMsg('双击'),
                    onLongPress: () => _printMsg('长按'),
                    onTapCancel: () => _printMsg('取消'),
                    onTapDown: (e) => _printMsg('按下'),
                    onTapUp: (e) => _printMsg('松开'),
                    child: Container(
                      padding: const EdgeInsets.all(60),
                      decoration: const BoxDecoration(color: Colors.blueAccent),
                      child: const Text(
                        '点我',
                        style: TextStyle(fontSize: 36, color: Colors.white),
                      ),
                    ),
                  ),
                  Text(printString),
                ],
              ),
              Positioned(
                left: moveX,
                top: moveY,
                child: GestureDetector(
                  onPanUpdate: (e) => _doMove(e),
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(36)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _printMsg(String msg) {
    setState(() {
      printString += '$msg, ';
    });
  }

  _doMove(DragUpdateDetails e) {
    setState(() {
      moveX += e.delta.dx;
      moveY += e.delta.dy;
    });
  }
}
