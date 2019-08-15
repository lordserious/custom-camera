import 'package:flutter/material.dart';
import 'dart:io';

import 'package:widgets_form/widgets/camera/control_camera.dart';
import 'package:camera/camera.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  String path = "";
  
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Column(
        children: <Widget>[
          Expanded(
            child: path.isEmpty ? Container(width: double.infinity, height: double.infinity) : Image.file(File(path)),
          ),
          RaisedButton(
            onPressed: () => {
              openCamera()
            },
          ),
        ],
    ),
  );

  Future<void> openCamera() async {
    List<CameraDescription> cameras;
    cameras = await availableCameras();

    Map results = await Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return ControlCamera(
          cameras: cameras,
        );
      }
    ));

    if (results != null && results.containsKey('selection')) {
      setState(() {
        path = results['selection'];
      });
    }
  }
}
