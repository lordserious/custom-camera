//WS Listado de Cotizaciones
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:widgets_form/view_model/base_dio.dart';
import 'package:widgets_form/view_model/object.dart';

class TextUrl {

  static Future<List<dynamic>> dioGet() async {
    CustomDio dio = new CustomDio();
    return dio.get("api/test").then((response) async {
      switch (response.statusCode) {
        case 200: {
          List<ObjectT> objects = [];
          for (Map m in response.data) {
            objects.add(ObjectT.fromJson(m));
          }
          return [0, objects];
        }
        break;
        default: return [10, "Vuelva a intentarlo más tarde"];
      }
    }).catchError((onError) {
      return errorMap(onError);
    });
  }

  static List<dynamic> errorMap(DioError onError) {
    try {
      if(onError.response != null) {
        if(onError.response.statusCode != null) {
          switch (onError.response.statusCode) {
            case 400: return [2, 'Credenciales incorrectas'];
            break;
            case 401: return [1, 'Sin autorizacion'];
            break;
            /**
             * 
             * 
             * 
             * 
             */
            default: return [6, "Vuelva a intentarlo mas tarde"];
          }
        } else {
          return [6, "Sin codigo de error"];
        }
      } else {
        return [6, "Sin respuesta del servidor"];
      }
    } catch(e) {
        return [6, "Error Desconocido"];
    }
  }
}

