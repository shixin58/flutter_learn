import 'package:flutter/material.dart';

class StatefulGroup extends StatefulWidget {
  const StatefulGroup({Key? key}) : super(key: key);

  @override
  State<StatefulGroup> createState() => _StatefulGroupState();
}

class _StatefulGroupState extends State<StatefulGroup> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('StatefulWidget与基础组件'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.grey,),
              activeIcon: Icon(Icons.home, color: Colors.blue,),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list, color: Colors.grey,),
              activeIcon: Icon(Icons.list, color: Colors.blue,),
              label: '列表',
            ),
          ],
        ),
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          child: Text('点我'),
        ),
        body: _currentIndex == 0 ? RefreshIndicator(onRefresh: _handleRefresh, child: ListView(
          children: <Widget> [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Image.network(
                    'http://www.devio.org/img/avatar.png',
                    width: 100,
                    height: 100,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      hintText: '请输入',
                      hintStyle: TextStyle(fontSize: 15)
                    ),
                  ),
                  Container(
                    height: 100,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(color: Colors.lightBlueAccent),
                    child: PageView(
                      children: <Widget>[
                        _item('Page1', Colors.deepPurple),
                        _item('Page2', Colors.green),
                        _item('Page3', Colors.red),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        )
            :const Text('列表'),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 200));
    // 列表刷新过程
    return;
  }

  _item(String s, Color bg) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg),
      child: Text(s, style: const TextStyle(fontSize: 22, color: Colors.white)),
    );
  }
}