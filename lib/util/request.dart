import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:idea/util/token.dart';

// const _baseUrl = "https://vinf.top";
const _baseUrl = "http://192.168.55.244:9999";
late Dio _dio ;

void initRequest() {
  _dio = Dio();
  _dio.options.baseUrl = _baseUrl;
  _dio.options.connectTimeout = 5000; //5s
  _dio.options.receiveTimeout = 3000;

  // dio.interceptors.add(
  //   InterceptorsWrapper(
  //     onRequest: (request, handler) {
  //       if (token != '') {
  //         request.headers['Authorization'] = 'Bearer $token';
  //       }
  //       return handler.next(request);
  //     },
  //     onError: (e, handler) async {
  //       if (e.response?.statusCode == 401) {
  //         try {
  //           await Dio()
  //               .get(_baseUrl + "/refresh_token",
  //                   options:
  //                       Options(headers: {"Authorization": 'Bearer $token'}))
  //               .then((value) => {
  //                     if (value.statusCode == 200)
  //                       {print("new token:" + value.data)}
  //                   });
  //         } catch (e) {
  //           print(e);
  //         }
  //         // try {
  //         //   await dio
  //         //       .get("/refresh_token",)
  //         //       .then((value) async {
  //         //     if (value.statusCode == 201) {
  //         //       //get new tokens ...
  //         //       print("access token" + token);
  //         //       //set bearer
  //         //       e.requestOptions.headers["Authorization"] = "Bearer " + token;
  //         //       //create request with new access token
  //         //       final opts = new Options(
  //         //           method: e.requestOptions.method,
  //         //           headers: e.requestOptions.headers);
  //         //       final cloneReq = await dio.request(e.requestOptions.path,
  //         //           options: opts,
  //         //           data: e.requestOptions.data,
  //         //           queryParameters: e.requestOptions.queryParameters);
  //         //
  //         //       return handler.resolve(cloneReq);
  //         //     }
  //         //     return ;
  //         //   });
  //         //   return ;
  //         // } catch (e) {}
  //       }
  //     },
  //   ),
  // );
}

Future<Response> post(String path, Map<String, dynamic> map)  async {
  return await _dio.post(_baseUrl + path, data: map);
}

