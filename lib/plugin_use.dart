import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:path_provider/path_provider.dart';

class PluginUse extends StatefulWidget {
  const PluginUse({super.key});

  @override
  State<PluginUse> createState() => _PluginUseState();
}

class _PluginUseState extends State<PluginUse> {
  Future<Directory?>? _tempDirectory;
  Future<Directory?>? _appSupportDirectory;
  Future<Directory?>? _appDocumentsDirectory;

  void _requestTempDirectory() {
    setState(() {
      _tempDirectory = getTemporaryDirectory();
    });
  }

  void _requestAppSupportDirectory() {
    setState(() {
      _appSupportDirectory = getApplicationSupportDirectory();
    });
  }

  void _requestAppDocumentsDirectory() {
    setState(() {
      _appDocumentsDirectory = getApplicationDocumentsDirectory();
    });
  }

  Widget _buildDirectory(BuildContext context, AsyncSnapshot<Directory?> snapshot) {
    Text text = const Text('');
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        text = Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        text = Text('path: ${snapshot.data!.path}');
      } else {
        text = const Text('path unavailable');
      }
    }
    return Padding(padding: const EdgeInsets.all(16.0), child: text,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('如何使用Flutter包和插件？'),
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
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(color: ColorUtil.color('#a9ee00')),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _requestTempDirectory,
                child: const Text('Get Temporary Directory'),
              ),
            ),
            FutureBuilder<Directory?>(
              future: _tempDirectory,
              builder: _buildDirectory,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _requestAppSupportDirectory,
                child: const Text('Get Application Support Directory'),
              ),
            ),
            FutureBuilder<Directory?>(
              future: _appSupportDirectory,
              builder: _buildDirectory,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _requestAppDocumentsDirectory,
                child: const Text('Get Application Documents Directory'),
              ),
            ),
            FutureBuilder<Directory?>(
              future: _appDocumentsDirectory,
              builder: _buildDirectory,
            ),
          ],
        ),
      ),
    );
  }
}
