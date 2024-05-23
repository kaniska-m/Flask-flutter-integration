// import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:html/parser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImagePickerDemo(),
    );
  }
}

class ImagePickerDemo extends StatefulWidget {
  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;
  var result= "";
  // var dataList = [];

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        file = File(image!.path);
      });
      await classifyImage(file!);
    } catch (e) {
      print('Error picking image: $e');
    }
    print('Image picked successfully: $_image');
  }

  Future classifyImage(File image) async {
    final uri = Uri.parse(
        'https://cat-dog-classifier-using-flask-xisi3zlsna-el.a.run.app/upload');

    var request = http.MultipartRequest('POST', uri);
    String mimeType = lookupMimeType(image.path) ?? 'application/octet-stream';
    var mimeTypeData = mimeType.split('/');
    request.files.add(await http.MultipartFile.fromPath(
      'photo',
      image.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    ));

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      setState(() {
        result = responseBody;
      });
    } else {
      setState(() {
        result = 'Failed to upload image';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Dog classifier'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_image != null)
              Image.file(
                File(_image!.path),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
            else
              Text('No image selected'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image from Gallery'),
            ),
            SizedBox(height: 20),
            Text(parse(result).body?.text ?? ''),
          ],
        ),
      ),
    );
  }
}
