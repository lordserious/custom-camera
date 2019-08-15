import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'take_photo.dart';
import 'crop_photo.dart';
import 'package:widgets_form/base/base_state.dart';

class ControlCamera extends StatefulWidget {
  final List<CameraDescription> cameras;
  
  ControlCamera({
    Key key,
    this.cameras
    }): super(key: key);

  @override
  _ControlCameraState createState() => _ControlCameraState();
}

class _ControlCameraState extends BaseState<ControlCamera> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var position = 0;
  TakePhoto _takePhoto;
  CropCamera _cropCamera;



  @override
  void initState() {
    _takePhoto = TakePhoto(
      cameras: widget.cameras,
      dataCallBack: (data) => pathPhoto(data, context),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    key: _scaffoldKey,
    backgroundColor: Colors.black,
    body: position == 0 ? _takePhoto : _cropCamera,
  );

  void pathPhoto(List<dynamic> path, BuildContext context) {
    switch(path[0]) {
      case 0: { // back
        hideDialog();
        resultActivity(path[1], context);
      }
      break;
      case 1: { //snackBar Exception
        _showCameraException(path[1]);
      }
      break;
      case 2: { //snackBar
        showInSnackBar(path[1]);
      }
      break;
      case 3: { //succes image file
        update(path[1]);
      }
      break;
      case 4: {
        back();
      }
      break;
      case 5: {
        showDialogLoading();
      }
      break;
      case 6: {
        hideDialog();
      }
      break;
      default : {

      }
      break;
    }
  }

  void back() {
    setState(() {
      position = 0;
    });
  }

  void update(String path) {
    hideDialog();
    _cropCamera = CropCamera(
      imagePath: path,
      dataCallBack: (data) => pathPhoto(data, context),
    );
    setState(() {
      position = 1;
    });
  }

  void resultActivity(String value, BuildContext context) {
    Navigator.of(context).pop({'selection':value});
  }
  
  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
  
  void logError(String code, String message) => print('Error: $code\nError Message: $message');
  
  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

}