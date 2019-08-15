import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as PI;
import 'package:path_provider/path_provider.dart';

class TakePhoto extends StatefulWidget {
  final List<CameraDescription> cameras;
  final OnTapCallback dataCallBack;
  
  TakePhoto({
    Key key,
    this.cameras,
    this.dataCallBack
    }): super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  CameraController controller;
  var position = 0;
  var haveOneCamera = true;
  String imagePath;
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();
    haveOneCamera = widget.cameras.length == 1;

    controller = CameraController(widget.cameras[position], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    } 
    return SafeArea(
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () => onNewCameraSelected(),
                      color: Colors.transparent,
                      highlightColor: Colors.white70,
                      child: Icon(Icons.camera_front, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () => onTakePictureButtonPressed(),
                      color: Colors.transparent,
                      highlightColor: Colors.white70,
                      child: Icon(Icons.camera_alt, size: 50.0, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () => {},//widget.dataCallBack([0, "pinche leo x2"])
                      color: Colors.transparent,
                      highlightColor: Colors.white70,
                      child: Icon(Icons.flash_off, color: Colors.white)
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onNewCameraSelected() async {
    if (controller != null) {
      await controller.dispose();
    }
    position = haveOneCamera ? 0 : (position == 0 ? 1 : 0);
    controller = CameraController(widget.cameras[position], ResolutionPreset.medium);

    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        widget.dataCallBack([2, 'Camera error ${controller.value.errorDescription}']);
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      widget.dataCallBack([1, e]);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) widget.dataCallBack([3, filePath]);
      }
    });
  }
  Future<File> _returnFileProcessed(File file) async => await compute(_processImage, file);

  static File _processImage(File file) {
    PI.Image image = PI.decodeImage(file.readAsBytesSync());

    PI.Image resize = PI.copyResize(image, width: 1024);

    file..writeAsBytesSync(PI.encodeJpg(resize, quality: 75));
    return file;
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      widget.dataCallBack([2, 'Error: select a camera first.']);
      return null;
    }
    widget.dataCallBack([5]);
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      widget.dataCallBack([1, e]);
      return null;
    }

    var fileProcess = await _returnFileProcessed(File(filePath));

    return fileProcess.path;
  }
}

typedef OnTapCallback = void Function(List<dynamic> data);