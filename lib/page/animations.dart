import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:widgets_form/view_model/test_url.dart';

class TestPage extends StatefulWidget {

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final GlobalKey _tabsKey = GlobalKey();
  TextEditingController controller = TextEditingController();
  bool searchOn = true;
  bool searchActive = false;
  double _height = 110.0;
  double _width = 60.0;
  double maxWidth = 0.0;
  bool visible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _text = "";

  @override
  void initState() {
    super.initState();
    // controller.addListener();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: _height,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.75)
                  ),
                ]
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60.0,
                    width: double.maxFinite,
                    child: Stack(
                    children: <Widget>[
                      Container(
                        height: 60.0,
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                        child: Center(
                          child: Text(
                            "Test Global Test Global Test Global Test GlobalvTest GlobalvTest Global Test Global Test Global Test Global",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: 60,
                        width: _width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  visible ? Flexible(
                                    child: Container(
                                    height: visible ? 60.0 : 0.0,
                                    width: visible ? 60.0 : 0.0,
                                    child: IconButton(
                                      onPressed: () => _update(context),
                                      iconSize: 45,
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: visible ? Colors.purple : Colors.transparent,
                                      )
                                    ),
                                  ),
                                  ) : Container(
                                    height: 0.0,
                                    width: 0.0,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: TextFormField(
                                      controller: controller,
                                      cursorColor: Colors.purple,
                                      decoration: InputDecoration(
                                        focusColor: Colors.white,
                                        counterText: "",
                                        hintText: "Buscar",
                                        hintStyle: TextStyle(
                                          color: Colors.purple
                                        ), 
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.purple, width: 0.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.purple, width: 0.0),
                                        ),
                                      )
                                    ),
                                  )
                                ],
                              )
                            ),
                            Container(
                              height: 60.0,
                              width: 60.0,
                              child: IconButton(
                                onPressed: () => visible ? _search() : _update(context),
                                iconSize: 45,
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.purple,
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  _height == 110.0 ? 
                  Expanded(
                    child: Container(
                      height: 50.0,
                      child: DefaultTabController(
                        length: 2,
                        child: TabBar(
                          key: _tabsKey,
                          indicatorColor: Colors.purple,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: <Widget>[
                            Tab(
                              child: Text(
                                  "Reportes",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.purple
                                  ),
                                ),
                            ),
                            Tab(
                              child: Text(
                                "Inventario",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.purple
                                ),
                              ),
                            ),
                          ],
                          onTap: (i) => {
                            print("${i}---------------------------")
                          },
                        ),
                      ),
                    ),
                  ) :
                  Container(),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: 40.0,
                    width: 60.0,
                    color: Colors.greenAccent,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    height: 40.0,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                onSaved: (s) => _text = s,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Campo obligatorio.";
                  }
                  return null;
                },
              ),
            ),
            RaisedButton(
              onPressed: _save,
              child: Text("Test"),
            ),
          ],
        ),
      ),
    );
  }

  _save() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print(_text);
    }
  }

  _update(c) {
    FocusScope.of(c).requestFocus(FocusNode());
    setState(() {
     if (_height == 110.0) {
        visible = true;
        _height = 60.0;
        _width = MediaQuery.of(c).size.width;
      } else {
        visible = false;
        _height = 110.0;
        _width = 60.0;
        controller.clear();
      } 
    });
  }

  _search() {
    print("buscar");
  }
}
