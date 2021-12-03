import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

const tokenKey = "token";
String token = "";

Future<void> getToken() async {
  await delToken();
  final tmp = await storage.read(key: tokenKey);
  if (tmp != null) {
    token = tmp;
  }
}

Future<void> setToken(String newToken) async {
  token = newToken;
  await storage.write(key: tokenKey, value: newToken);
}

Future<void> delToken() async {
  token = "";
  await storage.delete(key: tokenKey);
}

bool isValidToken() {
  // if (token == "") return false;
  return true;
}
