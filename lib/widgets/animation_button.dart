// import 'package:flutter/material.dart' hide Colors;

// class ProgressButton extends StatefulWidget {
//   final String title;
//   final OnSelectCallback callBack;

//   ProgressButton({
//     this.title,
//     this.callBack,
//     Key key
//   }) : super(key: key);

//   @override
//   _ProgressButtonState createState() => _ProgressButtonState();
// }

// class _ProgressButtonState extends State<ProgressButton> with TickerProviderStateMixin {
//   int _state = 0;
//   Animation _animation;
//   AnimationController _controller;
//   GlobalKey _globalKey = GlobalKey();
//   double _width = double.maxFinite;
//   double _width2 = double.maxFinite;

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final statusPro = Provider.of<ProviderStatus>(context);
//     _state = statusPro.getStatus;

//     return Container(
//       key: _globalKey,
//       width: _state == 0 ? _width : _width2,
//       height: 50,
//       margin: EdgeInsets.only(top: 30.0),
//       child: RaisedButton(
//         animationDuration: Duration(milliseconds: 1000),
//         shape: _state == 0 ?
//         BeveledRectangleBorder(
//           borderRadius: BorderRadius.circular(2.0),
//         ) : 
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25),
//         ),
//         padding: EdgeInsets.all(0),
//         child: setUpButtonChild(),
//         onPressed: () => _state == 0 ? animateButton(context) : {},
//         elevation: 4,
//         color: Colors.green,
//       )
//     );
//   }

//   setUpButtonChild() {
//     if (_state == 0) {
//       return Text(
//         "Entrar",
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 18,
//           fontWeight: FontWeight.w600
//         ),
//       );
//     } else if (_state == 1) {
//       return SizedBox(
//         height: 36,
//         width: 36,
//         child: CircularProgressIndicator(
//           value: null,
//           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//         ),
//       );
//     } else {
//       return Icon(Icons.check, color: Colors.white);
//     }
//   }

//   void animateButton(context) {
//     widget.callBack(true);
//     double initialWidth = _globalKey.currentContext.size.width;
//     final statusPro = Provider.of<ProviderStatus>(context);

//     _controller = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
//     _animation = Tween(begin: 0.0, end: 1).animate(_controller)
//       ..addListener(() {
//         setState(() {
//           _width2 = initialWidth - ((initialWidth - 48) * _animation.value);
//         });
//       });
//     _controller.forward();

//     statusPro.setStatus = 1;
//   }
// }

// typedef OnSelectCallback = void Function(bool valid);