import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoAppOld extends StatefulWidget {
  const PhotoAppOld({super.key});

  @override
  State<PhotoAppOld> createState() => _PhotoAppOldState();
}

class _PhotoAppOldState extends State<PhotoAppOld> {
  final List<XFile> _imageFileList = [];

  void _setImageFileListFromFile(XFile value) {
    _imageFileList.add(value);
  }

  final ImagePicker _picker = ImagePicker();

  Future getImage(bool isTakePhoto) async {
    Navigator.pop(context);
    var image = await _picker.pickImage(source: isTakePhoto?ImageSource.camera:ImageSource.gallery);
    if (image != null) {
      setState(() {
        _setImageFileListFromFile(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('拍照App开发old'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: _genImages(),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                _pickImage();
              },
              heroTag: 'image3',
              tooltip: '选择图片',
              child: const Icon(Icons.add_a_photo),
            ),
          ),
        ],
      ),
    );
  }

  _pickImage() {
    showModalBottomSheet(context: context, builder: (context)=>SizedBox(
      height: 160,
      child: Column(
        children: [
          _item('拍照', true),
          _item('从相册选择', false),
        ],
      ),
    ));
  }

  _item(String title, bool isTakePhoto) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(isTakePhoto?Icons.camera_alt:Icons.photo_library),
        title: Text(title),
        onTap: () => getImage(isTakePhoto),
      ),
    );
  }

  _genImages() {
    return _imageFileList.map((file) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.file(File(file.path), width: 120, height: 90, fit: BoxFit.fill),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _imageFileList.remove(file);
                });
              },
              child: ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(color: Colors.black54),
                  child: const Icon(Icons.close, size: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}