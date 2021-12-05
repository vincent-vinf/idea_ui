import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:idea/util/token.dart';

const _baseUrl = "http://idea.tclx.xyz";
late Dio _dio;

void initRequest() {
  _dio = Dio();
  _dio.options.connectTimeout = 5000; //5s
  _dio.options.receiveTimeout = 3000;

  _dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (request, handler) {
        if (token != '') {
          debugPrint(token);
          request.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(request);
      },
      onError: (e, handler) async {
        if (e.requestOptions.uri.path == "/login") {
          debugPrint(e.requestOptions.uri.path);
          return handler.next(e);
        }
        debugPrint("try update token");
        if (e.response?.statusCode == 401) {
          try {
            await Dio()
                .get(_baseUrl + "/refresh_token",
                    options:
                        Options(headers: {"Authorization": 'Bearer $token'}))
                .then((value) {
              if (value.statusCode == 200 && value.data["code"] == 200) {
                debugPrint("token updated!" + value.data["token"]);
                setToken(value.data["token"]);
              }
            });
          } catch (err) {
            print(err);
            debugPrint("clear token");
            delToken();
          }
        }
        return handler.next(e);
      },
    ),
  );
}

Future<Response> post(String path, Map<String, dynamic> map) async {
  return await _dio.post(_baseUrl + path, data: map);
}
