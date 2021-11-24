import 'package:dio/dio.dart';

// const _baseUrl = "https://vinf.top";
const _baseUrl = "127.0.0.1";
Dio dio = Dio();

Future<Response> post(String path, Map<String, dynamic> map) async {
  var formData = FormData.fromMap(map);
  return await dio.post(_baseUrl + path, data: formData);
}
