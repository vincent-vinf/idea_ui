import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

const storage = FlutterSecureStorage();

const tokenKey = "token";
String token = "";
int selfID = 0;
bool isFirstInit = false;

Future<void> getDiskToken() async {
  await storage.delete(key: tokenKey);
  // token == null 第一次使用
  // token == ""  上次登出
  // token 有效
  // await delToken();
  final tmp = await storage.read(key: tokenKey);
  if (tmp != null) {
    setToken(tmp);
  } else {
    isFirstInit = true;
  }
  print("isFirstInit: " + isFirstInit.toString());
}

Future<void> setToken(String newToken) async {
  token = newToken;
  if (token != "") {
    final decodedToken = JwtDecoder.decode(token);
    selfID = int.parse(decodedToken["id"]);
    debugPrint("selfID: " + selfID.toString());
    await storage.write(key: tokenKey, value: newToken);
  }
}

Future<void> delToken() async {
  selfID = 0;
  token = "";
  await storage.write(key: tokenKey, value: "");

  // await storage.delete(key: tokenKey);
}

bool isValidToken() {
  if (token == "") return false;
  // if (JwtDecoder.isExpired(token)) return false;
  return true;
}
