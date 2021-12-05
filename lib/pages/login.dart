import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:idea/util/request.dart';
import 'package:idea/util/token.dart';

import '../main.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    Response re;
    try {
      re = await post("/login", {"email": "1@qq.com", "passwd": "123456abc"});
    } catch (e) {
      print(e);
      return "Incorrect username or password";
    }
    if (re.statusCode == 200 && re.data["code"] == 200) {
      debugPrint(re.data["token"]);
      setToken(re.data["token"]);
      return null;
    } else {
      return "Incorrect username or password";
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    final re = await post("/register",
        {"username": data.name, "email": data.name, "passwd": data.password});
    if (re.statusCode == 200 &&
        re.data["code"] == 0 &&
        re.data["data"]["code"] == 200) {
      debugPrint(re.data["data"]["token"]);
      setToken(re.data["data"]["token"]);
      return null;
    } else {
      return "Email already exists";
    }
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'IDEA',
      logo: const AssetImage('assets/image/idea.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MyNavigationBar(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
