import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

const storage = FlutterSecureStorage();

const tokenKey = "token";
String token = "";
int selfID = 0;

Future<void> getDiskToken() async {
  // await delToken();
  final tmp = await storage.read(key: tokenKey);
  if (tmp != null) {
    setToken(tmp);
  }
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
  await storage.delete(key: tokenKey);
}

bool isValidToken() {
  if (token == "") return false;
  return true;
}
