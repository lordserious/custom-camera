import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:widgets_form/view_model/test_url.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          RaisedButton(
            onPressed: () => {
              _launchURL(context)
            },
          ),
        ],
    ),
  );

  void _launchURL(BuildContext context) async {
    try {
      await launch(
        'http://www.tracklink.pe/mt/sistema/trackfront/Trackfront.aspx',
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: false,
          enableUrlBarHiding: false,
          showPageTitle: false,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
