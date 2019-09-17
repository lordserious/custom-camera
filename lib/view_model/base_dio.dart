import 'package:dio/dio.dart';

class CustomDio extends Dio{
  CustomDio() {
    options.baseUrl = "https://url_base/";
    options.connectTimeout = (60*1000);
    options.receiveTimeout = (60*1000);
  }
}