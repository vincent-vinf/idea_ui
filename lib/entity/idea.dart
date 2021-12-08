import 'package:idea/entity/comment.dart';

class Idea {
  static final Idea blankIdea = Idea(0, 0, "", "", 0, false,DateTime.now());
  int id;
  int userId;
  String summary;
  String content;
  double life;
  bool isLike;
  List<Comment> comments = [];
  DateTime createdAt;

  Idea(
      this.id, this.userId, this.summary, this.content, this.life, this.isLike,this.createdAt);
}

// {
// "ID": 13,
// "CreatedAt": "2021-12-04T19:34:55+08:00",
// "UpdatedAt": "2021-12-04T19:34:55+08:00",
// "userId": 6,
// "simple": "fjfjfhofhi",
// "content": "",
// "life": 0,
// "isLike": false
// }
Idea json2Idea(dynamic data) {
  // print(DateTime.parse(data["CreatedAt"]).toString());
  return Idea(data["ID"], data["userId"], data["simple"], data["content"],
      data["life"].toDouble(), data["isLike"],DateTime.parse(data["CreatedAt"]));
}
