import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:widgets_form/view_model/test_url.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class UrlWebView extends StatefulWidget {
  @override
  _UrlWebViewState createState() => _UrlWebViewState();
}

class _UrlWebViewState extends State<UrlWebView> {

  // https://admin.dev.monito.pe/#/login
  // 'Access-Control-Allow-Origin': '*',
  // 'Access-Control-Allow-Methods': 'DELETE, POST, GET, OPTIONS',
  // 'Access-Control-Allow-Methods': 'Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With'


  // Ingrese usuario: 20177217043
  // Ingrese contraseña: 1704
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: InAppWebView(
        initialUrl: "www.tracklink.pe/mt",
        initialHeaders: {
        },
        initialOptions: {
        },
        onWebViewCreated: (InAppWebViewController controller) {
        },
        onLoadStart: (InAppWebViewController controller, String url) {
        },
        onProgressChanged: (InAppWebViewController controller, int progress) {
        },
      ),
    ),
  );
}
