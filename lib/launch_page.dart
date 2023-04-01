import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('如何打开第三方应用？'),
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
            ElevatedButton(
              onPressed: _launchUrl,
              child: const Text('打开浏览器'),
            ),
            ElevatedButton(
              onPressed: _openMap,
              child: const Text('打开地图'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    Uri url = Uri.parse('https://www.devio.org/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  _openMap() async {
    const url = 'geo:52.32,4.917';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      const url = 'https://maps.apple.com/?ll=52.32,4.917';
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw Exception('Could not launch $url');
      }
    }
  }
}
