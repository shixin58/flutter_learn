import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageDev extends StatefulWidget {
  const ImageDev({super.key});

  @override
  State<ImageDev> createState() => _ImageDevState();
}

class _ImageDevState extends State<ImageDev> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('图片控件开发详解'),
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
            Stack(
              children: [
                const Center(
                  child: CircularProgressIndicator(),
                ),
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: 'http://www.devio.org/img/avatar.png',
                  ),
                )
              ],
            ),
            FadeInImage.assetNetwork(
              placeholder: 'images/loading.gif',
              image: 'http://www.devio.org/img/avatar.png',
            ),
            CachedNetworkImage(
              imageUrl: 'http://via.placeholder.com/350x150',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        ),
      ),
    );
  }
}
