class Idea {
  int id;
  int userId;
  String summary;
  String content;
  double life;
  bool isLike;

  Idea(
      this.id, this.userId, this.summary, this.content, this.life, this.isLike);
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
  return Idea(data["ID"], data["userId"], data["simple"], data["content"], data["life"].toDouble(), data["isLike"]);
}
