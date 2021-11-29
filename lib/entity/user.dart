User getUser(int id){
  return User(1, "Vincent", "assets/image/test.jpg");
}

class User {
  int id;
  String name;
  String avatar;

  User(this.id, this.name, this.avatar);
}
