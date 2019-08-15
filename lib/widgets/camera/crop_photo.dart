import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';

class CropCamera extends StatefulWidget {
  final OnTapCallback dataCallBack;
  final String imagePath;

  CropCamera({
    Key key,
    this.imagePath = "",
    this.dataCallBack,
    }): super(key: key);

  @override
  _CropCameraState createState() => _CropCameraState();
}

class _CropCameraState extends State<CropCamera> {
  final cropKey = GlobalKey<CropState>();
  File _sample;
  File _lastCropped;

  @override
  void initState() {
    File _imagePath = File(widget.imagePath);
    _sample = _imagePath;
    // WidgetsBinding.instance.addPostFrameCallback((_) =>  Future.delayed(const Duration(seconds: 1), () { 
    //   _openImage();
    //  }));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _sample?.delete();
  }
  
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
    child: _sample == null ? Container(
      height: 1.0,
      width: 1.0,
    ) : 
    Column(
      children: <Widget>[
        Expanded(
          child: Crop(
            key: cropKey,
            image: FileImage(_sample)
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Volver',
                  style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                ),
                onPressed: () => {
                  widget.dataCallBack([4])
                },
              ),
              FlatButton(
                child: Text(
                  'Crop Image',
                  style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                ),
                onPressed: () => crop()
              ),
            ],
          ),
        )
      ],
    ),
  );

  // Future<void> _openImage() async {
  //   var file = File(widget.imagePath);
  //   final sample = await ImageCrop.sampleImage(
  //     file: file,
  //     preferredSize: context.size.longestSide.ceil(),
  //   );

  //   _sample?.delete();
  //   _file?.delete();

  //   setState(() {
  //     _sample = sample;
  //     _file = file;
  //   });
  // }


  void crop() {
    _cropImage().then((onValue){
      if(onValue.isNotEmpty) widget.dataCallBack([0, onValue]);
    });
  }

  Future<String> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      return "";
    }
    widget.dataCallBack([5]);
    final sample = await ImageCrop.sampleImage(
      file: _sample,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    await sample.delete();

    await _lastCropped?.delete();
    _lastCropped = file;
    print(_lastCropped.lengthSync());
    return _lastCropped.path;
  }
}

typedef OnTapCallback = void Function(dynamic data);