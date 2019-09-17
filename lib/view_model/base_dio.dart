import 'package:dio/dio.dart';

class CustomDio extends Dio{
  CustomDio() {
    options.baseUrl = "https://us-central1-hey-app-a3e51.cloudfunctions.net/";
    options.connectTimeout = (60*1000);
    options.receiveTimeout = (60*1000);
  }
}