import 'package:idea/entity/comment.dart';

class Idea {
  static final Idea blankIdea =
      Idea(0, 0, "", "", 0, false, DateTime.now(), 0, "");
  int id;
  int userId;
  String summary;
  String content;
  String type;
  double life;
  bool isLike;
  List<Comment> comments = [];
  DateTime createdAt;
  int likeCount;

  Idea(this.id, this.userId, this.summary, this.content, this.life, this.isLike,
      this.createdAt, this.likeCount, this.type);
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
  Idea i = Idea(
      data["ID"],
      data["userId"],
      data["simple"],
      data["content"],
      data["life"].toDouble(),
      false,
      DateTime.parse(data["CreatedAt"]),
      0,
      data["typeName"]);
  if (data["likeCount"] != null) {
    i.likeCount = data["likeCount"];
  }
  if (data["isLike"] != null) {
    i.isLike = data["isLike"];
  }
  return i;
}
