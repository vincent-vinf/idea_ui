import 'package:idea/util/request.dart';

class User {
  int id;
  String name;
  String avatar;

  User(this.id, this.name, this.avatar);
}

class UserHolder {
  static User blankUser = User(0, " ", "assets/image/blank.png");

  static final Map _map = {};

  static Future<User> getUser(int id) async {
    if (_map.containsKey(id)) {
      return _map[id];
    } else {
      final re = await post("/user/get_user_info", {
        "ids": [id]
      });
      if (re.statusCode == 200 && re.data["code"] == 0) {
        final t = re.data["data"][0];
        User u = User(t["ID"], t["username"], t["avatar"]);
        _map[id] = u;
        return u;
      } else {
        // print("get user error!");
        return blankUser;
      }
    }
  }
}
